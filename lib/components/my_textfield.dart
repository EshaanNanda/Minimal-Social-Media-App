import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon? iconn;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.iconn});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isSecure=true;
  Widget togglePassword(){
    return IconButton(onPressed: (){
      setState(() {
        isSecure=!isSecure;
      });

    }, icon: isSecure?Icon(Icons.visibility):Icon(Icons.visibility));

  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(

          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(12),
          ),
          hintText: widget.hintText),
      obscureText: widget.obscureText,
    );
  }
}
