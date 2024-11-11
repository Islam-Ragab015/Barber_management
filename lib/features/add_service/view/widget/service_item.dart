import 'package:barber/constants/app_colors.dart';
import 'package:barber/core/component/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/sevice_model.dart';

class ServiceItem extends StatelessWidget {
  ServiceItem({
    required this.index,
    required this.service,
    super.key,
  });
  int index;
  SeviceModel service;
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
              shape: BoxShape.rectangle, color: CustomColors.kGreyColor),
          height: 120,
          width: 120,
          child: CustomNetworkImage(
            imageUrl: service.imageUrl ??
                'https://firebasestorage.googleapis.com/v0/b/ourapp-7b3f5.appspot.com/o/services%2Fmohamedhessan139%40gmail.com%2F1443239-5793971961490159533_121.jpg?alt=media&token=c176408b-f7c4-4776-8d3d-bfcf31a3dd8f',
          ),
        ),
      ),
    );
  }
}
