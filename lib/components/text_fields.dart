import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_constant.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final Color? fillColor;
  final bool? autoFocus;
  final bool obscureText;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? Function(String?) validator;

  // final Function? functionValidate;
  // final String? parametersValidate;
  final TextInputAction actionKeyboard;
  // final Function? onSubmitField;
  final Function? onTap;
  final Function? onChanged;

  const TextFormFieldWidget(
      {this.hintText,
        this.focusNode,
        required this.textInputType,
        this.defaultText,
        this.obscureText = false,
        this.controller,
        // this.functionValidate,
        // this.parametersValidate,
        required this.actionKeyboard,
        // this.onSubmitField,
        // this.onFieldTap,
        this.prefixIcon, this.autoFocus, this.suffixIcon, this.onTap, this.fillColor, this.onChanged, this.textAlign, this.readOnly, this.maxLines, this.maxLength, required this.validator, });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  // double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      cursorColor: ColorConstants.purple,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      textInputAction: widget.actionKeyboard,
      focusNode: widget.focusNode,
      validator: widget.validator,
      style: TextStyle(
        fontSize: 13.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.purple,
              width: MediaQuery.of(context).size.width / 200,
            ),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.purple,
              width: MediaQuery.of(context).size.width / 200,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.purple,
              width: MediaQuery.of(context).size.width / 200,
            ),
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: widget.fillColor,
        focusColor: Colors.black,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 200)),
        hintStyle: TextStyle(
          fontSize: 13.sp, color: Colors.black54,
        ),
      ),
      controller: widget.controller,
      // validator: (value) {
      //   if (widget.functionValidate != null) {
      //     String resultValidate =
      //     widget.functionValidate!(value, widget.parametersValidate);
      //     if (resultValidate != null) {
      //       return resultValidate;
      //     }
      //   }
      //   return null;
      // },
      // onFieldSubmitted: (value) {
      //   if (widget.onSubmitField != null) widget.onSubmitField!();
      // },
      // onTap: () {
      //   if (widget.onFieldTap != null) widget.onFieldTap!();
      // },
    );
  }
}

