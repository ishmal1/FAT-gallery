import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_constant.dart';

class AdminTextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  int? maxLength;
  int? maxLines;
  final TextAlign? textAlign;
  final Color? fillColor;
  final bool? autoFocus;
  final bool obscureText;
  final bool? readOnly;
  final TextEditingController? controller;
  // final Function? functionValidate;
  // final String? parametersValidate;
  final TextInputAction actionKeyboard;
  // final Function? onSubmitField;
  final Function? onTap;
  final Function? onChanged;

  AdminTextFormFieldWidget(
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
        this.prefixIcon, this.autoFocus, this.suffixIcon, this.onTap, this.fillColor, this.onChanged, this.textAlign, this.readOnly, this.maxLength, this.maxLines, });

  @override
  _AdminTextFormFieldWidgetState createState() => _AdminTextFormFieldWidgetState();
}

class _AdminTextFormFieldWidgetState extends State<AdminTextFormFieldWidget> {
  // double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      cursorColor: ColorConstants.purple,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      textInputAction: widget.actionKeyboard,
      focusNode: widget.focusNode,
      style: TextStyle(
        fontSize: 4.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.purple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.purple,
              width: 2
            ),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.purple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5)),
        filled: true,
        fillColor: widget.fillColor,
        focusColor: Colors.black,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: ColorConstants.purple,
                width: 2)),
        hintStyle: TextStyle(
          fontSize: 4.sp, color: Colors.black,
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

