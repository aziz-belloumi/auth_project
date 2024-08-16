// property_event.dart

import 'package:convergeimmob/features/immobilier/domain/entities/property.dart';

abstract class PropertyEvent {}

class AddProperty extends PropertyEvent {

  Property property;

  AddProperty(this.property);

}

class SelectPropertyType extends PropertyEvent {
  final int index;
  SelectPropertyType(this.index);
}
