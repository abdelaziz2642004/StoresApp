import 'package:store_app/Models/student.dart';
import 'package:store_app/Providers/studentProvider.dart';
import 'package:store_app/Screens/ProfileScreen/HelpingWidgets/profileInfo.dart';
import 'package:store_app/Screens/ProfileScreen/HelpingWidgets/profileOptions.dart';
import 'package:store_app/Screens/ProfileScreen/HelpingWidgets/profilePic.dart';
import 'package:store_app/Screens/ProfileScreen/ProfileService.dart';
import 'package:store_app/Screens/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);
    return PopScope(
      canPop: false, // Prevents back navigation
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false, // Hides back button
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfilePicture(),
                  const SizedBox(height: 16),
                  const ProfileInfo(),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1),
                  const ProfileOptions(),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final isConnected = await ProfileService.checkBackendConnection();
                        print(isConnected);
                        if (!isConnected) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("❌ Not connected to backend. try again later"),
                            ),
                          );
                          return;
                        }

                        var box = Hive.box('credentials');
                        await box.clear();

                        ref
                            .read(studentProvider.notifier)
                            .updateStudent(
                              Student(
                                fullName: 'fullName',
                                email: 'email',
                                studentID: 0,
                                password: 'password',
                              ),
                            );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffc47c51),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
