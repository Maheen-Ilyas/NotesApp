import 'package:flutter/material.dart';
import 'dart:developer' as dev show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes_app/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    dev.log(userCredential.toString());
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.all(10),
                    ),
                    maximumSize: MaterialStateProperty.resolveWith(
                        (states) => Size.infinite),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
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
