import 'package:convergeimmob/features/immobilier/data/datasources/property_remote_data_source.dart';

import '../../domain/entities/property.dart';
import '../../domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;

  PropertyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Property> addProperty(property) async {
    print(property.name);
    print(property.description);
    return await remoteDataSource.addProperty(property);
  }
}
