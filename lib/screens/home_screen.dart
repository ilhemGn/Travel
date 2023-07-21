import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/providers/distination_provider.dart';
import 'package:travel_app/screens/add_destination_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/widgets/destination_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<DestModel> destinations = ref.watch(destProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddDestinationScreen()));
              },
              icon: const Icon(
                Icons.add_box_rounded,
              )),
        ],
      ),
      body: DestinationList(destinations: destinations),
    );
  }
}
