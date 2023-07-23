import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/models/location_model.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.location = const LocationModel(
        latitude: 37.422131, longitude: -122.084801, address: ''),
    this.isSelected = false,
  });

  final LocationModel location;
  final bool isSelected;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.isSelected ? 'Location' : 'Pick a Loaction',
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        actions: widget.isSelected
            ? []
            : [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, _pickedLocation);
                  },
                  icon: const Icon(Icons.save, color: Colors.black),
                ),
              ],
      ),
      body: GoogleMap(
        onTap: widget.isSelected
            ? null
            : (position) {
                setState(() {
                  _pickedLocation = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (!widget.isSelected && _pickedLocation != null)
            ? {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: LatLng(
                      _pickedLocation!.latitude,
                      _pickedLocation!.longitude,
                    )),
              }
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: LatLng(
                      widget.location.latitude,
                      widget.location.longitude,
                    )),
              },
      ),
    );
  }
}
