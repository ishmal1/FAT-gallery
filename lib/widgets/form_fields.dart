import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/color_constant.dart';

// ignore: camel_case_types, must_be_immutable
class form_fields extends StatelessWidget {
  form_fields(
      {key,
      required this.icon,
      required this.label,
      required this.fieldtext,
      required this.secure,
      required this.onclick,
      required this.controller,
      required this.onChanged,
        this.initialValue,
        this.textInputAction,
        this.keyboardType,
        this.maxlength,
      this.maxlines,
      this.hinttext, required this.validator});

  IconData icon;
  String label;
  String fieldtext;
  String? initialValue;
  bool secure;
  int? maxlines;
  int? maxlength;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  Function(String) onChanged;
  TextEditingController controller;
  String? hinttext;
  final String? Function(String?) validator;
  final VoidCallback onclick;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              icon,
              color: ColorConstants.darkgrey,
            ),
            SizedBox(
              width: 7.w,
            ),
            Text(label, style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600
            ),),
          ],
        ),
        TextFormField(
          style: TextStyle(
            fontSize: 13.sp,
          ),
          maxLines: maxlines,
          textInputAction: textInputAction,
          onChanged: onChanged,
          keyboardType: keyboardType,
          controller: controller,
          initialValue: initialValue,
          maxLength: maxlength,
          obscureText: secure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(
              fontSize: 13.sp
            ),
            suffix: InkWell(
              onTap: onclick,
              child: Text(
                fieldtext.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.purple,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
