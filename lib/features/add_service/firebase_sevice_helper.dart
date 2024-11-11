import 'dart:io';
import 'dart:math';
import 'package:barber/core/utils/cashe_helper.dart';
import 'package:barber/features/add_service/model/sevice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class FirebaseSeviceHelper {
  String email = CacheHelper.getEmail()!;
  CollectionReference barberService = FirebaseFirestore.instance
      .collection('Barbers')
      .doc(CacheHelper.getEmail())
      .collection('Services');
  final storage = FirebaseStorage.instance;
  int rand = Random().nextInt(9999999);
  Future<String?> uploadProfileImage({
    required File? serviceImage,
  }) async {
    if (serviceImage != null) {
      try {
        var uploadTask = await storage
            .ref()
            .child(
                'services/$email/$rand${Uri.file(serviceImage.path).pathSegments.last}')
            .putFile(serviceImage);
        var imageUrl = await uploadTask.ref.getDownloadURL();

        return imageUrl;
      } on firebase_core.FirebaseException {}
    }
    return null;
  }

  Future<void> uploadServiceData({
    required double cost,
    required String name,
    required int time,
    String? description,
    String? imageUrl,
  }) async {
    await barberService.add({
      'image': imageUrl,
      'cost': cost,
      'name': name,
      'time': time,
      "description": description,
    });
  }

  Future<List<SeviceModel>> getAllData() async {
    final querySnapshot = await barberService.get();
    final serviceModels = querySnapshot.docs.map((doc) {
      return SeviceModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return serviceModels;
  }
}
