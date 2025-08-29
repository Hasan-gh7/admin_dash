

import 'package:real_estate_dashboard/data/models/property_model.dart';

abstract class PropertyState {}

class PropertiesInitial extends PropertyState {}

class PropertiesLoading extends PropertyState {}

class PropertiesLoaded extends PropertyState {
  final List<PropertyModel> properties;
  PropertiesLoaded(this.properties);
}

class PropertiesError extends PropertyState {
  final String message;
  PropertiesError(this.message);
}