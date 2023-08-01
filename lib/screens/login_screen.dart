import 'package:flutter/material.dart';
import 'dart:developer' as dev show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes_app/widgets/text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(""),
              // const SizedBox(height: 24),
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
                    final userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    dev.log(userCredential.toString());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      dev.log("User not found");
                    } else if (e.code == 'wrong-password') {
                      dev.log("Wrong password");
                    }
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
                  "Login",
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
                    '/signup',
                    (route) => false,
                  );
                },
                child: const Text(
                  "Don't have an account? Signup here!",
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
    );
  }
}
