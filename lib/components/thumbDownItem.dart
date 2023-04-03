import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThumbDownItem extends StatefulWidget {
  const ThumbDownItem({super.key});

  @override
  State<ThumbDownItem> createState() => _ThumbDownItemState();
}

class _ThumbDownItemState extends State<ThumbDownItem> {
  final fakerFa = Faker();
  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context)?.settings.arguments) as Map<dynamic, dynamic>;
    final int buId = arguments['buThumbDownItemId'];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.0)),
                      alignment: Alignment.center,
                      width: kIsWeb
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width,
                      height: kIsWeb
                          ? MediaQuery.of(context).size.height / 6
                          : MediaQuery.of(context).size.height / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          fakerFa.lorem.sentences(4).join(' '),
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 94, 33, 29)),
                        ),
                      )),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: const Color.fromARGB(255, 111, 57, 53),
                child: const Icon(Icons.arrow_back),
              )
            ])));
  }
}
