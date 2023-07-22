import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/screens/destination_details.dart';

class DestinationItem extends StatelessWidget {
  const DestinationItem({super.key, required this.destination});
  final DestModel destination;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DestinationDetails(destination: destination)));
      },
      contentPadding: const EdgeInsets.all(16),
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: FileImage(destination.image),
      ),
      title: Text(destination.name),
      subtitle: Text(destination.location.address),
    );
  }
}
