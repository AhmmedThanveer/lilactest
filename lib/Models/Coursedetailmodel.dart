import 'package:flutter/material.dart';

class CoursedetailModel {
  bool status;
  String message;
  CourseData data;

  CoursedetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CoursedetailModel.fromJson(Map<String, dynamic> json) =>
      CoursedetailModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null
            ? CourseData.fromJson(json["data"])
            : CourseData.empty(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class CourseData {
  int courseId;
  String courseName;
  String courseDescription;
  String? courseSyllabusPdf; // Nullable field
  String courseLevel;
  String courseSubject;
  String courseDuration;
  String totalFee;
  List<CourseIntake> courseIntaks;
  List<CourseEligibility> courseEligible;
  int universityId;
  String universityName;
  String universityCountry;
  String universityState;
  String universityCity;
  String universityEstablishedYear;
  String universityRank;
  int universityInternationalFee;
  String universityBrochure;
  String aboutUniversity;
  String? logoImage; // Nullable field

  CourseData({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    this.courseSyllabusPdf,
    required this.courseLevel,
    required this.courseSubject,
    required this.courseDuration,
    required this.totalFee,
    required this.courseIntaks,
    required this.courseEligible,
    required this.universityId,
    required this.universityName,
    required this.universityCountry,
    required this.universityState,
    required this.universityCity,
    required this.universityEstablishedYear,
    required this.universityRank,
    required this.universityInternationalFee,
    required this.universityBrochure,
    required this.aboutUniversity,
    this.logoImage,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        courseId: json["courseId"] ?? 0,
        courseName: json["courseName"] ?? 'No Course Name',
        courseDescription: json["courseDescription"] ?? 'No Description',
        courseSyllabusPdf: json["courseSyllabusPdf"],
        courseLevel: json["courseLevel"] ?? 'No Level',
        courseSubject: json["courseSubject"] ?? 'No Subject',
        courseDuration: json["CourseDuration"] ?? 'No Duration',
        totalFee: json["totalFee"] ?? 'No Fee',
        courseIntaks: json["courseIntaks"] != null
            ? List<CourseIntake>.from(
                json["courseIntaks"].map((x) => CourseIntake.fromJson(x)))
            : [],
        courseEligible: json["courseEligible"] != null
            ? List<CourseEligibility>.from(json["courseEligible"]
                .map((x) => CourseEligibility.fromJson(x)))
            : [],
        universityId: json["universityId"] ?? 0,
        universityName: json["universityName"] ?? 'No University',
        universityCountry: json["universityCountry"] ?? 'No Country',
        universityState: json["universityState"] ?? 'No State',
        universityCity: json["universityCity"] ?? 'No City',
        universityEstablishedYear:
            json["universityEstablishedYear"] ?? 'No Date',
        universityRank: json["universityRank"] ?? 'No Rank',
        universityInternationalFee: json["universityInternationalFee"] ?? 0,
        universityBrochure: json["universityBrochure"] ?? 'No Brochure',
        aboutUniversity: json["aboutUniversity"] ?? 'No About',
        logoImage: json["logoImage"],
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "courseDescription": courseDescription,
        "courseSyllabusPdf": courseSyllabusPdf,
        "courseLevel": courseLevel,
        "courseSubject": courseSubject,
        "CourseDuration": courseDuration,
        "totalFee": totalFee,
        "courseIntaks": List<dynamic>.from(courseIntaks.map((x) => x.toJson())),
        "courseEligible":
            List<dynamic>.from(courseEligible.map((x) => x.toJson())),
        "universityId": universityId,
        "universityName": universityName,
        "universityCountry": universityCountry,
        "universityState": universityState,
        "universityCity": universityCity,
        "universityEstablishedYear": universityEstablishedYear,
        "universityRank": universityRank,
        "universityInternationalFee": universityInternationalFee,
        "universityBrochure": universityBrochure,
        "aboutUniversity": aboutUniversity,
        "logoImage": logoImage,
      };

  factory CourseData.empty() => CourseData(
        courseId: 0,
        courseName: 'No Course Name',
        courseDescription: 'No Description',
        courseSyllabusPdf: null,
        courseLevel: 'No Level',
        courseSubject: 'No Subject',
        courseDuration: 'No Duration',
        totalFee: 'No Fee',
        courseIntaks: [],
        courseEligible: [],
        universityId: 0,
        universityName: 'No University',
        universityCountry: 'No Country',
        universityState: 'No State',
        universityCity: 'No City',
        universityEstablishedYear: 'No Date',
        universityRank: 'No Rank',
        universityInternationalFee: 0,
        universityBrochure: 'No Brochure',
        aboutUniversity: 'No About',
        logoImage: null,
      );
}

class CourseIntake {
  int id;
  String courseId;
  String intakeDate;
  String intakeDurationDate;
  String createdAt;
  String updatedAt;

  CourseIntake({
    required this.id,
    required this.courseId,
    required this.intakeDate,
    required this.intakeDurationDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseIntake.fromJson(Map<String, dynamic> json) => CourseIntake(
        id: json["id"] ?? 0,
        courseId: json["courseId"] ?? '',
        intakeDate: json["intakeDate"] ?? '',
        intakeDurationDate: json["intakeDurationDate"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "intakeDate": intakeDate,
        "intakeDurationDate": intakeDurationDate,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class CourseEligibility {
  int id;
  String courseId;
  String board;
  String boardScore;
  String createdAt;
  String updatedAt;

  CourseEligibility({
    required this.id,
    required this.courseId,
    required this.board,
    required this.boardScore,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseEligibility.fromJson(Map<String, dynamic> json) =>
      CourseEligibility(
        id: json["id"] ?? 0,
        courseId: json["courseId"] ?? '',
        board: json["board"] ?? '',
        boardScore: json["boardScore"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "board": board,
        "boardScore": boardScore,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
