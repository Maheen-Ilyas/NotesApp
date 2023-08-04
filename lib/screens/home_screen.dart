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
          // Future builder helps in executing asynchronous function
          child: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // The user is directed to main page after he/she verifies their email
                    if (user.emailVerified) {
                      return const NotesScreen();
                    // Else they are directed to the email verification page
                    } else {
                      return const EmailVerification();
                    }
                    // And if the user is not null, he/she is sent to the login screen
                  } else {
                    return const LogInScreen();
                  }
                default:
                // For any other connection state, the default will be a progress indicator
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
