import 'dart:ui';

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_circle_left_rounded,
              color: Colors.white,
              size: 28,
            )),
      ),
      body: Stack(
        children: [
          Image.file(
            widget.destination.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 30,
            right: 30,
            top: MediaQuery.of(context).size.height * 0.6,
            child: Container(
              width: 360,
              height: 160,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.destination.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        const Expanded(
                          child: Text(
                            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.85,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsScreen(
                          location: widget.destination.location,
                          isSelected: true,
                        ),
                      ));
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color.fromARGB(143, 255, 255, 255),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(urlImage),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
