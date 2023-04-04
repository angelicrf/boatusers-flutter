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
        ]),
      ]),
      CustomerServicesModel(buTopicId: '3', buCSTopics: [
        CSTopicModel(topicName: 'topicThree', buCSSubTopics: [
          CSTopicSubCategoriesModel(buCSTopicsSCategories: [
            Row(children: [
              for (int k = 0; k < createStars().length; k++)
                Listener(
                  onPointerDown: (event) => {
                    print('clickedIcon $k'),
                    //createStars(),
                    //newList[k].icon = Colors.amber
                  },
                  child: createStars()[k],
                ),
              const Text(
                '&Up',
                style: TextStyle(fontSize: 18.0),
              ),
            ]),
          ])
        ])
      ]),
    ];
    return thisCustomerServicesList;
  }

  static List<Icon> createStars() {
    List<Icon> newList = [];
    bool isSelectedIcon = false;
    for (var i = 0; i < 5; i++) {
      Icon thisIcon = Icon(
        Icons.star,
        color: !isSelectedIcon ? Colors.grey : Colors.red,
      );
      Listener(onPointerHover: (event) => print('movedIcon'), child: thisIcon);
      newList.add(thisIcon);
    }
    return newList;
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
