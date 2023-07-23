import 'package:flutter/material.dart';
import 'package:travel_app/screens/add_destination_screen.dart';
import 'package:travel_app/screens/home_screen.dart';
import 'package:travel_app/screens/recommended_screen.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: TabBar(
                labelColor: Colors.black54,
                indicatorColor: Colors.black54,
                unselectedLabelColor: Color.fromARGB(255, 195, 195, 195),
                tabs: [
                  Tab(text: 'Popular'),
                  Tab(text: 'Recommended'),
                ],
              ),
            ),
            title: const Column(
              children: [
                Text(
                  'Where would you',
                  style: TextStyle(color: Color.fromARGB(177, 0, 0, 0)),
                ),
                Text(
                  'like to go?',
                  style: TextStyle(color: Color.fromARGB(177, 0, 0, 0)),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddDestinationScreen()));
                  },
                  icon: const Icon(
                    Icons.add_box_rounded,
                    color: Colors.black87,
                  )),
            ],
          ),
          body: const TabBarView(
            children: [
              HomeScreen(),
              RecommendedScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
