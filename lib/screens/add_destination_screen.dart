import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/providers/distination_provider.dart';
import 'package:travel_app/widgets/custom_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/widgets/image_input.dart';

class AddDestinationScreen extends ConsumerStatefulWidget {
  const AddDestinationScreen({super.key});

  @override
  ConsumerState<AddDestinationScreen> createState() =>
      _AddDestinationScreenState();
}

class _AddDestinationScreenState extends ConsumerState<AddDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new destination'),
        ),
        body: Padding(
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
              const ImageInput(),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ref
                          .read(destProvider.notifier)
                          .addNewDest(DestModel(name: _enteredName));
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ]),
          ),
        ));
  }
}
