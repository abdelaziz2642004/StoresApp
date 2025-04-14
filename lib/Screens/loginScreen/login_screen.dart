import 'package:store_app/Providers/autoLoginProviderLoadingProvider.dart';
import 'package:store_app/Screens/ProfileScreen/profileScreen.dart';
import 'package:store_app/Screens/loginScreen/loginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'login_button_section.dart';
import 'login_fields_section.dart';
import 'login_header.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late Loginservice loginservice;

  @override
  void initState() {
    super.initState();
    loginservice = Loginservice(ref: ref);
    _attemptAutoLogin(); // Check Hive for saved credentials
  }

  Future<void> _attemptAutoLogin() async {
    var box = await Hive.openBox('credentials');
    int? storedId = box.get('studentID');
    String? storedPassword = box.get('password');

    if (storedId != null && storedPassword != null) {
      ref.read(loginLoadingProvider.notifier).state =
          true; // Show loading indicator
      loginservice.studentID = storedId;
      loginservice.password = storedPassword;
      bool successful = await loginservice.getStudent(context);
      ref.read(loginLoadingProvider.notifier).state =
          false; // Hide loading indicator

      if (successful && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginLoadingProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  const CircularProgressIndicator(), // Show loading indicator
                if (!isLoading) ...[
                  const LoginHeader(),
                  LoginFieldsSection(loginservice: loginservice),
                  LoginButtonSection(loginservice: loginservice),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
