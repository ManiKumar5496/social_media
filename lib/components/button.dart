import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
