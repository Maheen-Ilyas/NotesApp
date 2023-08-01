import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes_app/firebase_options.dart';
import 'package:my_notes_app/screens/email_verification_screen.dart';
import 'package:my_notes_app/screens/login_screen.dart';
import 'package:my_notes_app/screens/notes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    if (user.emailVerified) {
                      return const NotesScreen();
                    } else {
                      return const EmailVerification();
                    }
                  } else {
                    return const LogInScreen();
                  }
                default:
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
