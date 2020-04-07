import 'package:flutter/material.dart';

class MyDialogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Text('Some data'),
        ),
      ),
    );
  }
}
