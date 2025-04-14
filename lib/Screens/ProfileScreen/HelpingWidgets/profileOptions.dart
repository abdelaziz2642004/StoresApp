import 'package:store_app/FieldsData/SuccessMessage.dart';
import 'package:store_app/Models/student.dart';
import 'package:store_app/Providers/studentProvider.dart';
import 'package:store_app/Screens/EditInfoScreen/EditinfoScreen.dart';
import 'package:store_app/Screens/EditInfoScreen/editService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileOptions extends ConsumerWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EditService editService = EditService(rebuildParent: () {}, ref: ref);
    Student student = ref.watch(studentProvider);
    editService.gender = student.gender;
    editService.fullName = student.fullName;
    editService.level = student.level;
    editService.studentID = student.studentID;
    editService.email = student.email;

    return Column(
      children: [
        ListTile(
          title: const Text(
            'Edit Profile Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          subtitle: const Text('Edit your info'),
          leading: const Icon(Icons.edit, color: Color(0xffc47c51)),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Editinfoscreen()),
              ),
        ),
        ListTile(
          title: const Text(
            'Change your password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          subtitle: const Text('Change to a new password :D'),
          leading: const Icon(
            Icons.change_circle_rounded,
            color: Color(0xffc47c51),
          ),
          onTap: () => _showChangePasswordDialog(context, editService, student),
        ),
        ListTile(
          title: const Text(
            'Delete Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
              color: Colors.red,
            ),
          ),
          subtitle: const Text('Permanently delete your account'),
          leading: const Icon(Icons.delete, color: Colors.red),
          onTap: () => _showDeleteConfirmationDialog(context, editService),
        ),
      ],
    );
  }

  void _showChangePasswordDialog(
    BuildContext context,
    EditService editService,
    Student student,
  ) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: oldPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Enter old password';
                    if (value != student.password)
                      return 'Password Incorrect, enter the right one';
                    return null;
                  },
                ),
                TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator:
                      (value) =>
                          value == null || value.length < 8
                              ? 'Password must be at least 8 characters with one number'
                              : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  editService.password = oldPasswordController.text.trim();
                  editService.confirmPassword =
                      newPasswordController.text.trim();

                  bool success = await editService.changePassword(context);
                  if (success) {
                    Navigator.pop(context);
                    showSuccessPopup(context, "🎉 Success!");
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    EditService editService,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'This action cannot be undone. Do you want to proceed?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);

                  await editService.deleteAccount(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
