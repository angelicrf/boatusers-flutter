import 'package:flutter/material.dart';

class CustomerServicesModel {
  final List<CSTopicModel> buCSTopics;
  final String buTopicId;
  static bool isCheckedOne = false;
  static bool checkBoxIsChecked = false;
  static bool isCheckedTwo = false;
  //stars
  static bool isClickedStarOne = false;
  static bool isClickedStarTwo = false;
  static bool isClickedStarThree = false;
  static bool isClickedStarFour = false;
  static bool isClickedStarFive = false;
  //
  static bool isClickedStarSix = false;
  static bool isClickedStarSeven = false;
  static bool isClickedStarEight = false;
  static bool isClickedStarNine = false;
  static bool isClickedStarTen = false;

  CustomerServicesModel({required this.buTopicId, required this.buCSTopics});

  static List<CustomerServicesModel> customerServicesData(
      {void Function(bool thisValue)? thisCheck,
      void Function(bool thisValue)? thisStar}) {
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
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarOne = true,
                  thisStar!(isClickedStarOne),
                },
                child: Icon(Icons.star,
                    color: isClickedStarOne ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarTwo = true,
                  thisStar!(isClickedStarTwo),
                },
                child: Icon(Icons.star,
                    color: isClickedStarTwo ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarThree = true,
                  thisStar!(isClickedStarThree),
                },
                child: Icon(Icons.star,
                    color: isClickedStarThree ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarFour = true,
                  thisStar!(isClickedStarFour),
                },
                child: Icon(Icons.star,
                    color: isClickedStarFour ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarFive = true,
                  thisStar!(isClickedStarFive),
                },
                child: Icon(Icons.star,
                    color: isClickedStarFive ? Colors.red : Colors.grey),
              ),
              const Text(
                '&Up',
                style: TextStyle(fontSize: 18.0),
              ),
            ]),
            Row(children: [
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarSix = true,
                  thisStar!(isClickedStarSix),
                },
                child: Icon(Icons.star,
                    color: isClickedStarSix ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarSeven = true,
                  thisStar!(isClickedStarSeven),
                },
                child: Icon(Icons.star,
                    color: isClickedStarSeven ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarEight = true,
                  thisStar!(isClickedStarEight),
                },
                child: Icon(Icons.star,
                    color: isClickedStarEight ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarNine = true,
                  thisStar!(isClickedStarNine),
                },
                child: Icon(Icons.star,
                    color: isClickedStarNine ? Colors.red : Colors.grey),
              ),
              Listener(
                onPointerDown: (event) => {
                  print('clickedIcon'),
                  isClickedStarTen = true,
                  thisStar!(isClickedStarTen),
                },
                child: Icon(Icons.star,
                    color: isClickedStarTen ? Colors.red : Colors.grey),
              ),
              const Text(
                '&Up',
                style: TextStyle(fontSize: 18.0),
              ),
            ])
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
