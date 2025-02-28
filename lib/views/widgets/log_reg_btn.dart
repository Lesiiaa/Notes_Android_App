import 'package:flutter/material.dart';
import 'package:Notes_App/utils/my_colors.dart';

class LogRegBtn extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed; //po kliknieciu

  const LogRegBtn({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.extraLightPurpleColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        textStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w700,
        ),
        minimumSize: const Size(double.infinity, 50.0),
      ),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
