import 'package:flutter/material.dart';
import 'package:Notes_App/utils/my_colors.dart';

class BasicTextFormField extends StatefulWidget {
  final String hintText; // podpowiedz
  final bool obscureText; // ukrywany tekst
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const BasicTextFormField({
    Key? key,
    required this.hintText,
    this.obscureText = false, //domyslnie nie ukrywamy tekstu
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _BasicTextFormFieldState createState() => _BasicTextFormFieldState();
}

class _BasicTextFormFieldState extends State<BasicTextFormField> {
  late bool _obscureText; //widocznosc tekstu

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; //przelaczanie widocznosci tekstu
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0x4D000000), // czarny kolor 30% opacity
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: widget.suffixIcon ??
                Icon(
                  _obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: MyColors.lightPurpleColor,
                ),
            onPressed: _togglePasswordVisibility,
          )
              : widget.suffixIcon, // jesli nie ma ukrywania to zwykla ikona
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: MyColors.lightPurpleColor,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: MyColors.lightPurpleColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
