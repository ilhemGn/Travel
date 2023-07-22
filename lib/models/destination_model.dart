import 'package:travel_app/models/location_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class DestModel {
  final String id;
  final String name;
  final File image;
  final LocationModel location;

  DestModel({required this.name, required this.image, required this.location})
      : id = uuid.v4();
}

// List<DestModel> destinations = [
//   DestModel(name: 'Algeria'),
//   DestModel(name: 'Lebane'),
//   DestModel(name: 'Jordon'),
//   DestModel(name: 'Dubai'),
// ];
