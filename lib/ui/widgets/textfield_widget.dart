import 'package:college_books/constant/globals.dart';
import 'package:flutter/material.dart';
import '../theme/extention.dart';




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
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
        fillColor: Theme.of(context).accentColor,
        labelStyle: TextStyle(color: Theme.of(context).accentColor,),
        focusColor: Theme.of(context).accentColor,
        disabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).accentColor,),
        ),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).accentColor,),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).accentColor,),
        ),
        //labelText: hintText,
        
        prefixIcon: Icon(
          prefixIconData,
          size: 12.h,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon:suffixIconData
      ),
    );
  }
}
