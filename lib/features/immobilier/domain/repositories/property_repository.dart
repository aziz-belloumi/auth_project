import '../entities/property.dart';

abstract class PropertyRepository {
  Future<Property> addProperty(property);
}
