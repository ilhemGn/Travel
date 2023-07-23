import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_app/models/location_model.dart';
import 'package:travel_app/providers/distination_provider.dart';
import 'package:travel_app/widgets/custom_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/widgets/image_input.dart';
import 'package:travel_app/widgets/location_input.dart';

class AddDestinationScreen extends ConsumerStatefulWidget {
  const AddDestinationScreen({super.key});

  @override
  ConsumerState<AddDestinationScreen> createState() =>
      _AddDestinationScreenState();
}

class _AddDestinationScreenState extends ConsumerState<AddDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  File? _selectedPicture;
  LocationModel? _selectedLocation;

  void getTakenPicture(File? takenPicture) {
    _selectedPicture = takenPicture;
  }

  void getPickedLocation(LocationModel? location) {
    _selectedLocation = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEDEFF2),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Add destination'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_circle_left_rounded,
                size: 30,
              ),
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 50,
          ),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomInputField(
                    hintText: 'Enter you destination name',
                    labelText: 'Name',
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length >= 50) {
                        return 'Must be between 1 & 50 characteres';
                      }
                      return null;
                    },
                    onSave: (value) {
                      _enteredName = value!;
                    },
                  ),
                  const SizedBox(height: 14),
                  CustomInputField(
                    hintText: 'description....',
                    labelText: 'Description',
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'description field is required';
                      }
                      return null;
                    },
                    onSave: (value) {
                      // _enteredName = value!;
                    },
                  ),
                  const SizedBox(height: 14),
                  ImageInput(
                    onPickImage: getTakenPicture,
                  ),
                  const SizedBox(height: 14),
                  LocationInput(
                    onPickLocation: getPickedLocation,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // gradient: const LinearGradient(
                        //     colors: [
                        //       Color.fromARGB(234, 19, 38, 74),
                        //       Color.fromARGB(255, 81, 82, 84),
                        //       Color.fromARGB(255, 148, 147, 147),
                        //     ],
                        //     begin: Alignment.bottomCenter,
                        //     end: Alignment.bottomRight),
                        color: Colors.black87),
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedPicture != null &&
                              _selectedLocation != null) {
                            _formKey.currentState!.save();
                            ref.read(destProvider.notifier).addNewDest(
                                _enteredName,
                                _selectedPicture!,
                                _selectedLocation!);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ]),
          ),
        ));
  }
}
