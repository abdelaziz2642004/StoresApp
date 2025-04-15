import 'package:store_app/ImagePIcker.dart';
import 'package:store_app/Models/student.dart';
import 'package:store_app/Providers/studentProvider.dart';
import 'package:store_app/Screens/ProfileScreen/ProfileService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/main.dart';

class ProfilePicture extends ConsumerStatefulWidget {
  const ProfilePicture({super.key});

  @override
  ConsumerState createState() => _ProfilePictureState();
}

// async stuff , need to prevent the users from exiting in case of is uploading

class _ProfilePictureState extends ConsumerState<ProfilePicture> {
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileService = ProfileService(ref: ref);
    Student student = ref.read(studentProvider);
    profileService.gender = student.gender;
    profileService.fullName = student.fullName;
    profileService.level = student.level;
    profileService.studentID = student.studentID;
    profileService.email = student.email;
  }

  late final ProfileService profileService;

  @override
  Widget build(BuildContext context) {
    ref.watch(studentProvider);
    return Column(
      children: [
        UserImagePicker(
          onPickImage: (image) async {
            final isConnected = await ProfileService.checkBackendConnection();
            if (!isConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("❌ Not connected to backend. try again later"),
                ),
              );
              return;
            }
            profileService.uploadImage(image);
          },
          fromProfile: true,
        ),
        TextButton(
          onPressed: () async {
            final isConnected = await ProfileService.checkBackendConnection();
            if (!isConnected) {
              ScaffoldMessenger.of(context).clearSnackBars();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("❌ Not connected to backend. try again later"),
                ),
              );
              return;
            }
            profileService.deleteImage();
          },
          child: const Text(
            'Delete Image',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
