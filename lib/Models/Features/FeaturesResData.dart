<<<<<<< HEAD
class FeaturesResData {
  FeaturesResData({
    this.key,
    this.name,
    this.image,
    this.description,
  });

  int key;
  String name;
  String image;
  String description;

  factory FeaturesResData.fromJson(Map<String, dynamic> json) => FeaturesResData(
    key:json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null :  json["name"],
    image: json["image"] == null ? null :  json["image"],
    description: json["description"] == null ? null :  json["description"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "image": image == null ? null :  image,
    "description": description == null ? null :  description,
  };
}
=======
class FeaturesResData {
  FeaturesResData({
    this.key,
    this.name,
    this.image,
    this.description,
  });

  int key;
  String name;
  String image;
  String description;

  factory FeaturesResData.fromJson(Map<String, dynamic> json) => FeaturesResData(
    key:json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null :  json["name"],
    image: json["image"] == null ? null :  json["image"],
    description: json["description"] == null ? null :  json["description"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "image": image == null ? null :  image,
    "description": description == null ? null :  description,
  };
}
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
