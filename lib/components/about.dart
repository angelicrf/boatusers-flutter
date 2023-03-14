import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About(
      {super.key, required this.appUserName, required this.appUserPassword});

  final String appUserPassword;
  final String appUserName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appUserName),
      ),
      body: FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 0.2,
          child: Container(
            //margin: const EdgeInsets.all(5.0),
            color: Color.fromARGB(255, 221, 209, 172),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome User: $appUserName',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.5,
                      height: 1.0,
                      color: Color.fromARGB(255, 134, 45, 39)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(appUserPassword),
              )
            ]),
          )),
    );
  }
}
