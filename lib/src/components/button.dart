import 'package:flutter/material.dart';


typedef OnPressed = void Function();

class Button extends StatefulWidget {
  final String text;

  final OnPressed onPressed;

  final double borderRadius;

  final int borderSideColor;

  final Color backgroundColor;

  final int foregroundColor;

  final double width;

  final double height;

  final double fontSize;

  final Color textColor;

  const Button(
  this.text,
      {
    Key? key,
    required this.onPressed,
    this.borderRadius = 18.0,
    this.borderSideColor = 0xFFE85656,
    this.foregroundColor = 0xFFE85656,
    this.width = 100,
    this.height = 40,
    this.fontSize = 14,
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFFE85656)
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(

        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(Color(widget.foregroundColor)),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: BorderSide(color: Color(widget.borderSideColor)),
            ),
          ),
        ),
        child: Text(widget.text, style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),),
      ),
    );
  }
}
