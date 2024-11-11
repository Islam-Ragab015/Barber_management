class BarberModel {
  String? bio;
  String? coverImage;
  String? email;
  String? name;
  String? phone;
  String? profileImage;

  BarberModel({
    this.bio,
    this.coverImage,
    this.email,
    this.name,
    this.phone,
    this.profileImage,
  });

  factory BarberModel.fromJson(Map<String, dynamic> json) {
    return BarberModel(
      bio: json['bio'],
      coverImage: json['coverImage'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = bio;
    data['coverImage'] = coverImage;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['profileImage'] = profileImage;
    return data;
  }
}
