import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextFieldEmail extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;
  final int maxLines;
  const CustomTextFieldEmail({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (value) => EmailValidator.validate(value!)
          ? null
          : "Bitte gib eine valide E-mail ein",
      maxLines: maxLines,
    );
  }
}

class CustomTextFieldPassword extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;
  final int maxLines;
  const CustomTextFieldPassword({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        if (val.length < 5) {
          return 'Das Passwort muss mindestens 6 Zeichen lang sein';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
