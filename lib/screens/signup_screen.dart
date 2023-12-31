import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/functions/error_dialog.dart';
import 'package:my_notes_app/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Text controllers
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // Initializing the controllers
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // Only text editing controllers are disposed
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea adds any necessary padding required
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image here
                CustomTextField(
                  controller: _email,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _password,
                  hintText: "Password",
                  isPass: true,
                  inputType: TextInputType.text,
                  icon: const Icon(Icons.password),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                      // Error handling on signup
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        // dev.log("Weak password");
                        await errorDialogBox(context, "Weak password");
                      } else if (e.code == 'invalid-email') {
                        // dev.log("Invalid password");
                        await errorDialogBox(context, "Invalid password");
                      } else if (e.code == 'email-already-in-use') {
                        // dev.log("Email already in use");
                        await errorDialogBox(context, "Email already in use");
                      }
                    } catch (e) {
                      await errorDialogBox(context, e.toString());
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                    ),
                    maximumSize: MaterialStateProperty.resolveWith(
                        (states) => Size.infinite),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.teal),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Do you have an account already? Login here!",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
