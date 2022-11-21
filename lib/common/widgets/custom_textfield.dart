import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextFieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String hintText;
  final int maxLines;
  const CustomTextFieldEmail({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.icon,
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
          prefixIcon: Icon(
            icon,
            color: Colors.teal,
          ),
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

class CustomTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;

  final String hintText;
  final int maxLines;
  final IconData? icon;
  final Function onPressed;
  const CustomTextFieldPassword({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_passwordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
        prefixIcon: Icon(
          widget.icon,
          color: Colors.teal,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.teal,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        if (val.length < 6) {
          return 'Das Passwort muss mindestens 6 Zeichen lang sein';
        }
        return null;
      },
      maxLines: widget.maxLines,
    );
  }
}
