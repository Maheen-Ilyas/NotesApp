import 'package:flutter/material.dart';

Future<void> errorDialogBox(BuildContext context, String text) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "An error occurred!",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.teal,
          ),
        ),
        content: Text(text),
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
            // This is done to close the error dialog and return to the screen
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Ok",
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
  );
}
