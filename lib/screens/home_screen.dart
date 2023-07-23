import 'package:flutter/material.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/providers/distination_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/widgets/destination_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _destinationFuture;

  @override
  void initState() {
    _destinationFuture = ref.read(destProvider.notifier).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DestModel> destinations = ref.watch(destProvider);

    return Scaffold(
      body: FutureBuilder(
        future: _destinationFuture,
        builder: ((context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.blueGrey),
                  )
                : DestinationList(destinations: destinations)),
      ),
    );
  }
}
