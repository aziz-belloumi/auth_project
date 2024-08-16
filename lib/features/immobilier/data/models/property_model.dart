import '../../domain/entities/property.dart';

class PropertyModel extends Property {
  PropertyModel({required String name, required String description})
      : super(name: name, description: description);

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}