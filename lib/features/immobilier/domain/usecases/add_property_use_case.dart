import '../entities/property.dart';
import '../repositories/property_repository.dart';

class AddPropertyUseCase {
  final PropertyRepository repository;

  AddPropertyUseCase({required this.repository});

  Future<Property> call(Property property) async {
    return repository.addProperty(property);
  }
}
