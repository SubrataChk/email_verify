import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final IconData icons;
  final TextEditingController controller;
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.icons,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icons),
          hintText: title,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
