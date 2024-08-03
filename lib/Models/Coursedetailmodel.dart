class CoursedetailModel {
  bool status;
  String message;
  Data data;

  CoursedetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CoursedetailModel.fromJson(Map<String, dynamic> json) =>
      CoursedetailModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int courseId;
  String courseName;
  String courseDescription;
  String courseSyllabus;
  String courseSyllabusPdf;
  String courseLevel;
  String courseSubject;
  String courseDuration;
  String totalFee;
  List<CourseIntak> courseIntaks;
  List<dynamic> courseEligible;
  int universityId;
  String universityName;
  String universityCountry;
  String universityState;
  String universityCity;
  DateTime universityEstablishedYear;
  String universityRank;
  int universityInternationalFee;
  String universityBrochure;
  String aboutUniversity;
  String logoImage;
  dynamic documentRequired;
  List<dynamic> eligibileCerteriaEntrance;
  dynamic eligibileCerteriaFind;
  String placement;

  Data({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.courseSyllabus,
    required this.courseSyllabusPdf,
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
    required this.logoImage,
    required this.documentRequired,
    required this.eligibileCerteriaEntrance,
    required this.eligibileCerteriaFind,
    required this.placement,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        courseId: json["courseId"],
        courseName: json["courseName"],
        courseDescription: json["courseDescription"],
        courseSyllabus: json["courseSyllabus"],
        courseSyllabusPdf: json["courseSyllabusPdf"],
        courseLevel: json["courseLevel"],
        courseSubject: json["courseSubject"],
        courseDuration: json["CourseDuration"],
        totalFee: json["totalFee"],
        courseIntaks: List<CourseIntak>.from(
            json["courseIntaks"].map((x) => CourseIntak.fromJson(x))),
        courseEligible:
            List<dynamic>.from(json["courseEligible"].map((x) => x)),
        universityId: json["universityId"],
        universityName: json["universityName"],
        universityCountry: json["universityCountry"],
        universityState: json["universityState"],
        universityCity: json["universityCity"],
        universityEstablishedYear:
            DateTime.parse(json["universityEstablishedYear"]),
        universityRank: json["universityRank"],
        universityInternationalFee: json["universityInternationalFee"],
        universityBrochure: json["universityBrochure"],
        aboutUniversity: json["aboutUniversity"],
        logoImage: json["logoImage"],
        documentRequired: json["documentRequired"],
        eligibileCerteriaEntrance:
            List<dynamic>.from(json["eligibileCerteriaEntrance"].map((x) => x)),
        eligibileCerteriaFind: json["eligibileCerteriaFind"],
        placement: json["placement"],
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "courseDescription": courseDescription,
        "courseSyllabus": courseSyllabus,
        "courseSyllabusPdf": courseSyllabusPdf,
        "courseLevel": courseLevel,
        "courseSubject": courseSubject,
        "CourseDuration": courseDuration,
        "totalFee": totalFee,
        "courseIntaks": List<dynamic>.from(courseIntaks.map((x) => x.toJson())),
        "courseEligible": List<dynamic>.from(courseEligible.map((x) => x)),
        "universityId": universityId,
        "universityName": universityName,
        "universityCountry": universityCountry,
        "universityState": universityState,
        "universityCity": universityCity,
        "universityEstablishedYear":
            "${universityEstablishedYear.year.toString().padLeft(4, '0')}-${universityEstablishedYear.month.toString().padLeft(2, '0')}-${universityEstablishedYear.day.toString().padLeft(2, '0')}",
        "universityRank": universityRank,
        "universityInternationalFee": universityInternationalFee,
        "universityBrochure": universityBrochure,
        "aboutUniversity": aboutUniversity,
        "logoImage": logoImage,
        "documentRequired": documentRequired,
        "eligibileCerteriaEntrance":
            List<dynamic>.from(eligibileCerteriaEntrance.map((x) => x)),
        "eligibileCerteriaFind": eligibileCerteriaFind,
        "placement": placement,
      };
}

class CourseIntak {
  int id;
  String courseId;
  String intakeDate;
  String intakeDurationDate;
  DateTime createdAt;
  DateTime updatedAt;

  CourseIntak({
    required this.id,
    required this.courseId,
    required this.intakeDate,
    required this.intakeDurationDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseIntak.fromJson(Map<String, dynamic> json) => CourseIntak(
        id: json["id"],
        courseId: json["courseId"],
        intakeDate: json["intakeDate"],
        intakeDurationDate: json["intakeDurationDate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "intakeDate": intakeDate,
        "intakeDurationDate": intakeDurationDate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
