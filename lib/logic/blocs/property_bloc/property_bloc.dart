import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/data/repositories/property_service.dart';
import 'property_event.dart';
import 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyService propertyService;

  PropertyBloc(this.propertyService) : super(PropertiesInitial()) {
    on<LoadProperties>((event, emit) async {
      emit(PropertiesLoading());
      try {
        final properties = await propertyService.fetchProperties();
        emit(PropertiesLoaded(properties));
      } catch (e) {
        emit(PropertiesError(e.toString()));
      }
    });
  }
}