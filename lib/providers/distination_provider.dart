import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/destination_model.dart';

class DestinationNotifier extends StateNotifier<List<DestModel>> {
  DestinationNotifier() : super([]);

  void addNewDest(DestModel newDest) {
    state = [...state, newDest];
  }
}

final destProvider =
    StateNotifierProvider<DestinationNotifier, List<DestModel>>(
  (ref) => DestinationNotifier(),
);
