import 'package:convergeimmob/features/immobilier/domain/usecases/add_property_use_case.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final AddPropertyUseCase addPropertyUseCase;
  int selectedIndex = -1;

  PropertyBloc(this.addPropertyUseCase) : super(PropertyInitial()) {
    on<AddProperty>(_onAddProperty);
    on<SelectPropertyType>(_onSelectPropertyType);
  }

  Future<void> _onAddProperty(
      AddProperty event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    try {
      final property = await addPropertyUseCase.call(event.property);
      emit(PropertyLoaded(property));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  void _onSelectPropertyType(
      SelectPropertyType event, Emitter<PropertyState> emit) {
    selectedIndex = event.index;
    emit(PropertyTypeSelected(selectedIndex));
  }

}
