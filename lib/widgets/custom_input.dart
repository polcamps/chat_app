import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  
  final TextInputType keybordType;
  final IconData? prefixIcon;
  final String hintText;
  final TextEditingController textController;
  final bool isPassword;
  
  const CustomInput(
    { 
      Key? key,
      this.keybordType = TextInputType.text,
      this.prefixIcon,
      this.hintText = "",
      required this.textController,
      this.isPassword = false
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0,5),
            blurRadius: 5 
          ),
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: keybordType,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}