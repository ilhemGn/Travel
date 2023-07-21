import 'package:flutter/material.dart';
import 'package:travel_app/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.youknowboat.com/wp-content/uploads/2023/04/catamaran-boat-tour-Milos-Sykia-Kleftiko-with-lunch-on-board-snorkeling-swimming-turquoise-sea-of-the-coast-of-Milos-Greece.jpeg'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Explore Your Favorite Journey',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              const Text(
                'Step Out of Your Comfort Zone, into the World of Exploration!',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 2, 43, 47),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Let\'s start',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}