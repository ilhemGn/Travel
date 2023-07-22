import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/models/location_model.dart';

Future<String> getAdrress(double lat, double long) async {
  try {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyBJx2zQ-CTyYkkMCqhyyycNIRyBSnVberE');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final address = data['results'][0]['formatted_address'];
    print('this in http requests  $address');

    return address;
  } catch (e) {
    print(e);
  }
  return '';
}

String getlocationImage(LocationModel location) {
  final lat = location.latitude;
  final long = location.longitude;

  return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=&markers=color:red%7Clabel:A%7C$lat,$long&key=AIzaSyBJx2zQ-CTyYkkMCqhyyycNIRyBSnVberE';
}
