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
        appBar: AppBar(
          title: const Text('Add new destination'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              CustomInputField(
                hintText: 'Destination name',
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
              const SizedBox(height: 10),
              ImageInput(
                onPickImage: getTakenPicture,
              ),
              const SizedBox(height: 10),
              LocationInput(
                onPickLocation: getPickedLocation,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedPicture != null &&
                        _selectedLocation != null) {
                      _formKey.currentState!.save();
                      ref.read(destProvider.notifier).addNewDest(
                          _enteredName, _selectedPicture!, _selectedLocation!);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ]),
          ),
        ));
  }
}
