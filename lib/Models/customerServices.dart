import 'package:flutter/material.dart';

class CustomerServicesModel {
  final List<CSTopicModel> buCSTopics;
  final String buTopicId;
  static bool isCheckedOne = false;
  static bool checkBoxIsChecked = false;
  static bool isCheckedTwo = false;

  CustomerServicesModel({required this.buTopicId, required this.buCSTopics});

  static List<CustomerServicesModel> customerServicesData(
      {void Function(bool thisValue)? thisCheck}) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      isCheckedOne = false;
      isCheckedTwo = false;
      return Colors.red;
    }

    var thisCustomerServicesList = [
      CustomerServicesModel(buTopicId: '1', buCSTopics: [
        CSTopicModel(topicName: 'topicOne', buCSSubTopics: [
          CSTopicSubCategoriesModel(buCSTopicsSCategories: [
            'SubCategory1-One',
            'SubCategory1-Two',
            'SubCategory1-Three'
          ])
        ])
      ]),
      CustomerServicesModel(buTopicId: '2', buCSTopics: [
        CSTopicModel(topicName: 'topicTwo', buCSSubTopics: [
          CSTopicSubCategoriesModel(buCSTopicsSCategories: [
            'SubCategory2-One',
            'SubCategory2-Two',
            'SubCategory2-Three'
          ])
        ])
      ]),
      CustomerServicesModel(buTopicId: '3', buCSTopics: [
        CSTopicModel(topicName: 'topicThree', buCSSubTopics: [
          CSTopicSubCategoriesModel(buCSTopicsSCategories: [
            Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value:
                    isCheckedOne && !isCheckedTwo ? checkBoxIsChecked : false,
                onChanged: (value) => !isCheckedOne && !isCheckedTwo
                    ? {
                        isCheckedOne = true,
                        isCheckedTwo = false,
                        checkBoxIsChecked = !checkBoxIsChecked,
                        thisCheck!(value!),
                      }
                    : null),
            Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value:
                    !isCheckedOne && isCheckedTwo ? checkBoxIsChecked : false,
                onChanged: (value) => !isCheckedOne && !isCheckedTwo
                    ? {
                        isCheckedTwo = true,
                        isCheckedOne = false,
                        checkBoxIsChecked = !checkBoxIsChecked,
                        thisCheck!(value!),
                      }
                    : null),
          ])
        ])
      ]),
    ];
    return thisCustomerServicesList;
  }
}

class CSTopicModel {
  final String topicName;
  final List<CSTopicSubCategoriesModel> buCSSubTopics;

  CSTopicModel({required this.topicName, required this.buCSSubTopics});
}

class CSTopicSubCategoriesModel {
  final List<dynamic> buCSTopicsSCategories;
  CSTopicSubCategoriesModel({required this.buCSTopicsSCategories});
}
