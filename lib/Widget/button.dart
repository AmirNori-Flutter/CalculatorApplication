import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final color;
  final textcolor;
  final buttontext;
  final buttonclick;
  const ButtonWidget({
    super.key,
    this.color,
    this.textcolor,
    this.buttontext = '',
    this.buttonclick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonclick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttontext,
                style: TextStyle(
                  color: textcolor,
                  fontSize: 25,
                  fontFamily: 'inter',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
