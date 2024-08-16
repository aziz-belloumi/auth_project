import 'package:http/http.dart' as http;
import '../models/property_model.dart';

abstract class PropertyRemoteDataSource {
  Future<PropertyModel> addProperty(property);
}

class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  final http.Client client;

  PropertyRemoteDataSourceImpl({required this.client});

  @override
  Future<PropertyModel> addProperty(property) async {
    // print(name);
    // print(description);
    return PropertyModel(name: property.name, description: property.description);
    // final response = await client.post(
    //   Uri.parse('http://localhost:3000/properties'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'name': name,
    //     'description': description,
    //   }),
    // );

    // if (response.statusCode == 201) {
    //   return PropertyModel.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to add property');
    // }
  }
}
