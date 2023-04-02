import 'package:boatusers/Models/FeedBacksModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThumUpItem extends StatefulWidget {
  const ThumUpItem({super.key});

  @override
  State<ThumUpItem> createState() => _ThumUpItemState();
}

class _ThumUpItemState extends State<ThumUpItem> {
  bool isClicked = false;
  int clickedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context)?.settings.arguments) as Map<dynamic, dynamic>;
    final int buId = arguments['buThumbUpItemId'];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 143, 181, 213),
                        borderRadius: BorderRadius.circular(25.0)),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        mainAxisExtent: kIsWeb ? 150.0 : 120.0,
                      ),
                      itemCount: FeedBackModel.feedBacksData().length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => setState(() {
                            clickedIndex = index;
                            isClicked = true;
                          }),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                color: isClicked && clickedIndex == index
                                    ? const Color.fromARGB(255, 153, 95, 95)
                                    : const Color.fromARGB(255, 171, 159, 124)),
                            child: Column(
                              children: [
                                FeedBackModel.feedBacksData()[index]
                                    .buFeedBackImageSrc,
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    FeedBackModel.feedBacksData()[index]
                                        .buFeedBack,
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 149, 122, 42)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              )),
              isClicked
                  ? const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        'Thanks For Your FeedBack, and purchasing products from us. See You Soon',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 70, 15, 85)),
                      ),
                    )
                  : const SizedBox.shrink(),
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
