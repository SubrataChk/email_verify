import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backColors;
  const CustomButton(
      {Key? key,
      required this.backColors,
      required this.onTap,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 7.h,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              color: backColors, borderRadius: BorderRadius.circular(20)),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
