import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev show log;

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

enum Menu { logout }

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<Menu>(
            onSelected: (value) async {
              switch (value) {
                case Menu.logout:
                  final ifLogout = await logOutDialogBox(context);
                  dev.log(ifLogout.toString());
                  if (ifLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login',
                      (_) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<Menu>(
                  value: Menu.logout,
                  child: Text("Logout"),
                ),
              ];
            },
          )
        ],
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
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> logOutDialogBox(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Log out",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.teal,
          ),
        ),
        content: const Text(
            "Are you sure you want to logout? You will have to login again."),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
