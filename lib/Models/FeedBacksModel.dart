import 'package:flutter/material.dart';

class FeedBackModel {
  final String buFeedBack;
  final Icon buFeedBackImageSrc;

  FeedBackModel({required this.buFeedBack, required this.buFeedBackImageSrc});
  static List<FeedBackModel> feedBacksData() {
    var thisFeedbackList = [
      FeedBackModel(
          buFeedBack: 'FeedBackOne',
          buFeedBackImageSrc: const Icon(
            Icons.replay_10_rounded,
            size: 60.0,
          )),
      FeedBackModel(
          buFeedBack: 'FeedBackTwo',
          buFeedBackImageSrc: const Icon(
            Icons.point_of_sale_rounded,
            size: 60.0,
          )),
      FeedBackModel(
          buFeedBack: 'FeedBackThree',
          buFeedBackImageSrc: const Icon(
            Icons.feedback_rounded,
            size: 60.0,
          )),
      FeedBackModel(
          buFeedBack: 'FeedBackFour',
          buFeedBackImageSrc: const Icon(
            Icons.access_alarm_rounded,
            size: 60.0,
          )),
      FeedBackModel(
          buFeedBack: 'FeedBackFive',
          buFeedBackImageSrc: const Icon(
            Icons.accessible_forward_rounded,
            size: 60.0,
          )),
      FeedBackModel(
          buFeedBack: 'FeedBackSix',
          buFeedBackImageSrc: const Icon(
            Icons.download_done_rounded,
            size: 60.0,
          ))
    ];

    return thisFeedbackList;
  }
}
