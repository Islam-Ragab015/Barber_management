import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'custom_outline.dart';

class CustomBottom extends StatelessWidget {
  VoidCallback? onTap;
  String text;
  Color? color1;
  Color? color2;
  bool? isloading = true;
  CustomBottom(
      {super.key,
      this.color1,
      this.color2,
      this.onTap,
      required this.text,
      this.isloading});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Visibility(
      visible: isloading ?? true,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: CustomOutline(
          strokeWidth: 3,
          radius: 20,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color1 ?? CustomColors.kPinkColor,
              color2 ?? CustomColors.kGreenColor,
            ],
          ),
          width: 160,
          height: 38,
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color1 ?? CustomColors.kPinkColor.withOpacity(0.5),
                  color2 ?? CustomColors.kGreenColor.withOpacity(0.5),
                ],
              ),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: height <= 660 ? 11 : 15,
                  fontWeight: FontWeight.w700,
                  color: CustomColors.kWhiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
