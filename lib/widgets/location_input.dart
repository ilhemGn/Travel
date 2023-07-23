import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel_app/http/http_requests.dart';
import 'package:travel_app/models/location_model.dart';
import 'package:travel_app/screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onPickLocation});
  final void Function(LocationModel?) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool isGettingPosition = false;
  LocationModel? _pickedLocation;
  late String urlImage;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingPosition = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }
    await returnLocation(lat, lng);
  }

  Future<void> returnLocation(double lat, double lng) async {
    final address = await getAdrress(lat, lng);
    print('this when call the function  $address');

    setState(() {
      _pickedLocation = LocationModel(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      widget.onPickLocation(_pickedLocation);
      isGettingPosition = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pickedLocation != null) {
      urlImage = getlocationImage(_pickedLocation!);
    }
    Widget content = _pickedLocation != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/location_logo.png',
                width: 60,
                height: 60,
              ),
              const Text(
                'No Location Selected',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          );

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: isGettingPosition
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                onPressed: _getCurrentLocation,
                label: const Text(
                  'Get Current Location',
                  style: TextStyle(color: Colors.black87),
                )),
            TextButton.icon(
                onPressed: () async {
                  final pickedCoordinates = await Navigator.push<LatLng>(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapsScreen()));
                  if (pickedCoordinates == null) {
                    return;
                  }
                  await returnLocation(
                      pickedCoordinates.latitude, pickedCoordinates.longitude);
                },
                icon: const Icon(
                  Icons.location_searching_sharp,
                  color: Colors.black,
                ),
                label: const Text(
                  'Select on Map',
                  style: TextStyle(color: Colors.black87),
                )),
          ],
        ),
      ],
    );
  }
}
