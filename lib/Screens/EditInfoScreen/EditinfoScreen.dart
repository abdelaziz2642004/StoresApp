import 'package:store_app/Models/student.dart';
import 'package:store_app/Providers/studentProvider.dart';
import 'package:store_app/Screens/EditInfoScreen/HelpingWidgets.dart/Edit_fields_section.dart';
import 'package:store_app/Screens/EditInfoScreen/HelpingWidgets.dart/save_button_section.dart';
import 'package:store_app/Screens/EditInfoScreen/editService.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Editinfoscreen extends ConsumerStatefulWidget {
  const Editinfoscreen({super.key});

  @override
  ConsumerState<Editinfoscreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<Editinfoscreen> {
  @override
  void initState() {
    super.initState();
    editservice = EditService(
      rebuildParent: () {
        setState(() {});
      },
      ref: ref,
    );
    Student student = ref.read(studentProvider);

    editservice.fullName = student.fullName;
    editservice.studentID = student.studentID;
    editservice.email = student.email;
  }

  late EditService editservice;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Your Details",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EditFields(service: editservice),
                  ...SaveButton(editservice, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
