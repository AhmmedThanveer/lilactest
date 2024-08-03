import 'package:flutter/material.dart';

class Featurecourselist {
  bool status;
  String message;
  List<CourseList> data;

  Featurecourselist({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Featurecourselist.fromJson(Map<String, dynamic> json) =>
      Featurecourselist(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null
            ? List<CourseList>.from(
                json["data"].map((x) => CourseList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CourseList {
  int universityId;
  String courseTitle;
  String courseFee;
  List<String> images;
  Country country;
  CourseState state;
  City city;
  String universityName;
  int courseId;

  CourseList({
    required this.universityId,
    required this.courseTitle,
    required this.courseFee,
    required this.images,
    required this.country,
    required this.state,
    required this.city,
    required this.universityName,
    required this.courseId,
  });

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        universityId: json["universityId"] ?? 0,
        courseTitle: json["courseTitle"] ?? 'No Title',
        courseFee: json["courseFee"] ?? 'No Fee',
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x as String))
            : [],
        country: countryValues.map[json["Country"]] ?? Country.INDIA_91,
        state: stateValues.map[json["State"]] ?? CourseState.KERALA,
        city: cityValues.map[json["city"]] ?? City.ADUR,
        universityName: json["universityName"] ?? 'No University',
        courseId: json["courseId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "universityId": universityId,
        "courseTitle": courseTitle,
        "courseFee": courseFee,
        "images": List<dynamic>.from(images.map((x) => x)),
        "Country": countryValues.reverse[country],
        "State": stateValues.reverse[state],
        "city": cityValues.reverse[city],
        "universityName": universityName,
        "courseId": courseId,
      };
}

enum City { ADUR, KOZHIKODE }

final cityValues = EnumValues({"Adur": City.ADUR, "Kozhikode": City.KOZHIKODE});

enum Country { INDIA_91 }

final countryValues = EnumValues({"India (+91)": Country.INDIA_91});

enum CourseState { KERALA }

final stateValues = EnumValues({"Kerala": CourseState.KERALA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
