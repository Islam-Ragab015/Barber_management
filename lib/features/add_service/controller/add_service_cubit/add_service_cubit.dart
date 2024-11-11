import 'dart:io';

import 'package:barber/features/add_service/firebase_sevice_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit({
    required this.firebaseSeviceHelper,
  }) : super(AddServiceInitial());
  FirebaseSeviceHelper firebaseSeviceHelper;

  final ImagePicker picker = ImagePicker();
  File? serviceImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> pickServiceImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      serviceImage = File(pickerFile.path);
      emit(ImagePicked());
    } else {
      emit(ImagePickedError('No Image Selected'));
    }
  }

  bool isloading = false;
  Future<void> addService() async {
    emit(AddServiceLoading());
    isloading = true;
    try {
      String? imageUrl = await firebaseSeviceHelper.uploadProfileImage(
          serviceImage: serviceImage);
      await firebaseSeviceHelper.uploadServiceData(
        imageUrl: imageUrl,
        cost: double.parse(priceController.text),
        name: nameController.text,
        time: int.parse(timeController.text),
        description: descriptionController.text,
      );
      isloading = false;
      emit(AddServiceSuccess());
    } catch (e) {
      isloading = false;
      emit(AddServiceError(e.toString()));
    }
  }
}
