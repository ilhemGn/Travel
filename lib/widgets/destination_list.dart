import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/widgets/destination_item.dart';

class DestinationList extends StatelessWidget {
  const DestinationList({super.key, required this.destinations});
  final List<DestModel> destinations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: destinations.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DestinationItem(destination: destinations[index]),
            ));
  }
}
