import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/database/database.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:travel_app/models/location_model.dart';

class DestinationNotifier extends StateNotifier<List<DestModel>> {
  DestinationNotifier() : super([]);

  Future<void> loadData() async {
    final db = await getDataBase();
    final data = await db.query('user_destinations');
    final destinations = data
        .map(
          (row) => DestModel(
            id: row['id'] as String,
            name: row['title'] as String,
            image: File(row['image'] as String),
            location: LocationModel(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                address: row['address'] as String),
          ),
        )
        .toList();

    state = destinations;
  }

  void addNewDest(String title, File image, LocationModel location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    DestModel newDest =
        DestModel(name: title, image: copiedImage, location: location);

    final db = await getDataBase();
    db.insert('user_destinations', {
      'id': newDest.id,
      'title': newDest.name,
      'image': newDest.image.path,
      'lat': newDest.location.latitude,
      'lng': newDest.location.longitude,
      'address': newDest.location.address,
    });

    state = [newDest, ...state];
  }
}

final destProvider =
    StateNotifierProvider<DestinationNotifier, List<DestModel>>(
  (ref) => DestinationNotifier(),
);
