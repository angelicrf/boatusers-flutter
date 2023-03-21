import 'package:boatusers/components/searchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About({super.key, required this.appUserPassword, required this.appUserName});
  final String appUserPassword;
  final String appUserName;

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SizedBox(
          width: kIsWeb ? 220.0 : 50.0,
          child: Text(
            kIsWeb ? widget.appUserName : 'About',
            style: const TextStyle(
              fontSize: kIsWeb ? 18.0 : 12.0,
            ),
          ),
        ),
        actions: [
          SearchWidget.searchTextField(searchController),
          SizedBox(
              child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    print(searchController.text);
                  }))
        ],
      ),
      body: FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 0.2,
          child: Container(
            //margin: const EdgeInsets.all(5.0),
            color: const Color.fromARGB(255, 221, 209, 172),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome User: ${widget.appUserName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.5,
                      height: 1.0,
                      color: Color.fromARGB(255, 134, 45, 39)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('${widget.appUserPassword}'),
              )
            ]),
          )),
    );
  }
}
