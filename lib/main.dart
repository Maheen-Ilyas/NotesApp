import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/firebase_options.dart';
import 'package:my_notes_app/screens/email_verification_screen.dart';
import 'package:my_notes_app/screens/home_screen.dart';
import 'package:my_notes_app/screens/login_screen.dart';
import 'package:my_notes_app/screens/notes_screen.dart';
import 'package:my_notes_app/screens/signup_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        loginRoute: (context) => const LogInScreen(),
        signupRoute: (context) => const SignUpScreen(),
        notesRoute: (context) => const NotesScreen(),
        verifyEmailRoute:(context) => const EmailVerification(),
      },
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
