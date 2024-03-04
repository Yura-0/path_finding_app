import 'package:flutter/material.dart';

class StandartBtn extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const StandartBtn({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 68, 186, 228),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      child: GestureDetector(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black),
            ),
          )),
    );
  }
}
