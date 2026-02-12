import 'package:flutter/material.dart';
import '../widgets/residence_profiling_form.dart';
import 'residents_lists_page.dart';
import '../database/database.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AppDatabase _database = AppDatabase();

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/best-logo.png',
                width: 170,
                height: 170,
              ),
              const SizedBox(height: 1),
              const Text(
                'Barangay Residence Profiling',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome! Please fill out the residence profiling form.',
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResidenceProfilingForm(database: _database),
                    ),
                  );
                },
                child: const Text('Start Profiling'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResidentsListsPage(),
                    ),
                  );
                },
                child: const Text('Residents Lists'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
