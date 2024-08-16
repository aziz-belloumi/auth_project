// property_state.dart

import 'package:convergeimmob/features/immobilier/domain/entities/property.dart';

abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final Property property;
  PropertyLoaded(this.property);
}

class PropertyError extends PropertyState {
  final String message;
  PropertyError(this.message);
}

class PropertyTypeSelected extends PropertyState {
  final int selectedIndex;
  PropertyTypeSelected(this.selectedIndex);
}
