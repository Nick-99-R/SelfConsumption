import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function callback;
  final Color color;
  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.callback,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () => callback(),
      child: Container(
        height: size.height * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(buttonText,
              style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4)),
        ),
      ),
    );
  }
}
