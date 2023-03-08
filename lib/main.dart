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
  final buserNameController = TextEditingController();
  final buPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buPasswordController.text = '';
    buserNameController.text = '';
    print('initStateCalled....');
  }

  @override
  void dispose() {
    buPasswordController.dispose();
    buserNameController.dispose();
    super.dispose();
  }

  void _SubmitInputs() async {
    /*   setState(() {
      _buCount += 20;
    }); */
    if (buPasswordController.text != '' && buserNameController.text != '') {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Confirmed UserName: ${buserNameController.text} and Password: ${buPasswordController.text}'),
          );
        },
      );
      setState(() {
        buPasswordController.text = '';
        buserNameController.text = '';
      });
    } else if (buPasswordController.text == '' &&
        buserNameController.text != '') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Empty Password Field!'),
          );
        },
      );
    } else if (buserNameController.text == '' &&
        buPasswordController.text != '') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Empty User Name Field!'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Invalid Entry!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buTitle),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'User Info',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'User Name',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: buserNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter User Name',
              ),
            ),
          ),
          Text(
            'Password',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: buPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: FloatingActionButton(
              onPressed: _SubmitInputs,
              tooltip: 'Enter',
              child: const Icon(Icons.send),
              //style:FloatingActionButtonLocation.startFloat
            ),
            //,
          ),
        ],
      )),
      //
    );
  }
}
