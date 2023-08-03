import 'package:flutter/material.dart';

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
