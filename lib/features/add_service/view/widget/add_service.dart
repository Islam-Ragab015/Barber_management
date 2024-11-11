import 'package:barber/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AddService extends StatelessWidget {
  AddService({
    required this.index,
    super.key,
  });
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
        right: index % 2 == 0 ? 10 : 0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle, color: CustomColors.kCyanColor),
          height: 120,
          width: 120,
          child: const Icon(Icons.add_shopping_cart_outlined,
              color: CustomColors.kPinkColor, size: 40),
        ),
      ),
    );
  }
}
