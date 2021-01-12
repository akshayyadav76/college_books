import 'package:flutter/material.dart';

import '../globals.dart';



class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final Widget suffixIconData;
  final bool obscureText;
  final String intialValue;
  final Function onChanged;
  final TextEditingController controller;
  final Function validate;
  final FocusNode focusNode;
  final Function onTap;
  final int maxLine;
  final int maxLength;

  TextFieldWidget(
      {this.hintText,
      this.prefixIconData,
      this.suffixIconData,
      this.obscureText,
      this.intialValue,
      this.onChanged,
      this.controller,
      this.focusNode,
      this.maxLine =1,
      this.onTap,
      this.maxLength,
      this.validate});

  @override
  Widget build(BuildContext context) {
   // final model = Provider.of<HomeProvider>(context);

    return TextFormField(
      onTap: onTap,
      focusNode: focusNode,
      maxLines: maxLine,
      maxLength: maxLength,
      controller: controller,
      initialValue: intialValue,
      onChanged: onChanged,
      validator: validate,
      obscureText: obscureText,
      cursorColor: Global.mediumBlue,
      style: TextStyle(
        color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Global.mediumBlue),
        focusColor: Global.mediumBlue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Global.mediumBlue),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Global.mediumBlue,
        ),
        suffixIcon:suffixIconData
      ),
    );
  }
}
