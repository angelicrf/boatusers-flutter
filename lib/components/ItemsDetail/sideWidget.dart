import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/customerServices.dart';

class SideWidget {
  static Widget sideComponentDisplay(
      void Function(bool thisCValue) thisCheckFunc,
      void Function(bool thisCValue) thisStarFunc) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: CustomerServicesModel.customerServicesData().length,
        itemBuilder: (context, index) => ListTile(
              tileColor: const Color.fromARGB(255, 223, 163, 163),
              title: Text(
                CustomerServicesModel.customerServicesData()[index]
                    .buCSTopics[0]
                    .topicName,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0;
                      i <
                          CustomerServicesModel.customerServicesData()[index]
                              .buCSTopics[0]
                              .buCSSubTopics[0]
                              .buCSTopicsSCategories
                              .length;
                      i++)
                    if (CustomerServicesModel.customerServicesData()[index]
                        .buCSTopics[0]
                        .buCSSubTopics[0]
                        .buCSTopicsSCategories[i] is Row)
                      CustomerServicesModel.customerServicesData(
                        thisStar: (thisValue) => thisStarFunc(thisValue),
                      )[index]
                          .buCSTopics[0]
                          .buCSSubTopics[0]
                          .buCSTopicsSCategories[i]
                    else if (CustomerServicesModel.customerServicesData()[index]
                        .buCSTopics[0]
                        .buCSSubTopics[0]
                        .buCSTopicsSCategories[i] is String)
                      InkWell(
                          child: Text(
                              CustomerServicesModel.customerServicesData()[index]
                                  .buCSTopics[0]
                                  .buCSSubTopics[0]
                                  .buCSTopicsSCategories[i]),
                          onTap: () =>
                              launchUrl(Uri.parse('https://www.example.com')))
                    else if (CustomerServicesModel.customerServicesData()[index]
                        .buCSTopics[0]
                        .buCSSubTopics[0]
                        .buCSTopicsSCategories[i] is Checkbox)
                      CustomerServicesModel.customerServicesData(
                              thisCheck: (bool thisValue) =>
                                  thisCheckFunc(thisValue))[index]
                          .buCSTopics[0]
                          .buCSSubTopics[0]
                          .buCSTopicsSCategories[i],
                ],
              ),
              minLeadingWidth: 10,
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ));
  }
}
