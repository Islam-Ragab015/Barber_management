class SeviceModel {
  String? id;
  String? name;
  int? cost;
  int? time;
  String? description;
  String? imageUrl;

  SeviceModel(
      {this.id,
      this.name,
      this.cost,
      this.time,
      this.description,
      this.imageUrl});
  SeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    cost = json['cost'] ?? 0;
    time = json['time'] ?? 0;
    description = json['description'];
    imageUrl = json['image'];
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'cost': cost,
        'time': time,
        'description': description,
        'image': imageUrl
      };
}
