import 'package:uuid/uuid.dart';

const uuid = Uuid();

class DestModel {
  final String id;
  final String name;

  DestModel({required this.name}) : id = uuid.v4();
}

// List<DestModel> destinations = [
//   DestModel(name: 'Algeria'),
//   DestModel(name: 'Lebane'),
//   DestModel(name: 'Jordon'),
//   DestModel(name: 'Dubai'),
// ];
