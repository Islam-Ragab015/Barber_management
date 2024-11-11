

class UserDataModel {
  // Private constructor
  UserDataModel._();

  // Singleton instance
  static final UserDataModel _instance = UserDataModel._();

  factory UserDataModel() {
    return _instance;
  }

  String? name;
  String? email;
  String? image;
  String? phone;
  String? bio = 'write a bio';
  String? caver;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    bio = json['bio'] ?? '';
    caver = json['caver'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email ?? email,
      'image': image ?? image,
      'bio': bio,
      'caver': caver ?? caver,
      'phone': phone,
    };
  }
}

class CreateUserModel {
  CreateUserModel({
    this.name,
    this.email,
    this.image =
        'https://th.bing.com/th/id/OIP.xntKTqP9pZbOAnyJwf9SdAAAAA?pid=ImgDet&rs=1',
    this.caver =
        'https://th.bing.com/th/id/OIP.xntKTqP9pZbOAnyJwf9SdAAAAA?pid=ImgDet&rs=1',
    this.bio,
    this.phone,
  });

  String? name;
  String? email;
  String? image;
  String? phone;
  String? bio = 'write a bio';
  String? caver;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email ?? email,
      'image': image ?? image,
      'bio': bio,
      'caver': caver ?? caver,
      'phone': phone,
    };
  }
}
