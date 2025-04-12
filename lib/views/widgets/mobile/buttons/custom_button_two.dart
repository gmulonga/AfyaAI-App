import 'package:afyaai/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomButtonTwo extends StatefulWidget {
  CustomButtonTwo({required this.callBackFunction, required this.label});

  final VoidCallback callBackFunction;
  final String label;

  @override
  _CustomButtonTwoState createState() => _CustomButtonTwoState();
}

class _CustomButtonTwoState extends State<CustomButtonTwo> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.callBackFunction();
      },
      style: ElevatedButton.styleFrom(
        shadowColor: kWhite,
        side: BorderSide(color: kGreen, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 17),
        child: Text(widget.label, style: TextStyle(color: kGreen, fontSize: 15)),
      ),
    );
  }
}