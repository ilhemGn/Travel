import 'package:flutter/material.dart';
import 'package:travel_app/http/http_requests.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/screens/maps_screen.dart';

class DestinationDetails extends StatefulWidget {
  const DestinationDetails({super.key, required this.destination});
  final DestModel destination;
  @override
  State<DestinationDetails> createState() => _DestinationDetailsState();
}

class _DestinationDetailsState extends State<DestinationDetails> {
  @override
  Widget build(BuildContext context) {
    String urlImage = getlocationImage(widget.destination.location);
    return Scaffold(
      body: Stack(
        children: [
          Image.file(
            widget.destination.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapsScreen(
                                      location: widget.destination.location,
                                      isSelected: true,
                                    )));
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          urlImage,
                        ),
                      ),
                    ),
                    Text(
                      widget.destination.location.address,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
