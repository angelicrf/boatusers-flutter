import 'package:flutter/material.dart';

void main() {
  runApp(const BoatUsersApp());
}

class BoatUsersApp extends StatelessWidget {
  const BoatUsersApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boat Users',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const BUHomePage(buTitle: 'Boat Users App'),
    );
  }
}

class BUHomePage extends StatefulWidget {
  const BUHomePage({super.key, required this.buTitle});

  final String buTitle;

  @override
  State<BUHomePage> createState() => _BUHomePageState();
}

class _BUHomePageState extends State<BUHomePage> {
  int _buCount = 0;

  void _AddCount() {
    setState(() {
      _buCount += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buTitle),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'User Info',
          ),
          Text(
            'User Name',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'Password',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            '$_buCount',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _AddCount,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
