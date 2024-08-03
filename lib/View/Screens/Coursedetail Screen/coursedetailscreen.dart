import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lilacmachinetest/Models/Coursedetailmodel.dart';
import 'dart:convert';
import '../../../Helper/SharedprefrenceHelper.dart';
// import 'coursedetailmodel.dart'; // Import your model class here
// import 'sharedprefrencehelper.dart'; // Import your Sharedprefrencehelper class here

class Coursedetailscreen extends StatelessWidget {
  final int courseId;
  final int universityId;

  const Coursedetailscreen({
    Key? key,
    required this.courseId,
    required this.universityId,
  }) : super(key: key);

  Future<CoursedetailModel> fetchCourseDetails() async {
    final token = await Sharedpreferencehelper().getAuthToken();
    final response = await http.get(
      Uri.parse(
          'https://test.gslstudent.lilacinfotech.com/api/lead/course/SearchPopularSingleCourseFinding?id=$courseId&universityId=$universityId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return CoursedetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size(100, 60),
            child: ClipRRect(
              child: AppBar(
                leadingWidth: 60,
                toolbarHeight: 60,
                backgroundColor: Colors.transparent,
                actions: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          size: 17,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            size: 17,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: CircleAvatar(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 17,
                          color: Colors.white,
                        )),
                  ),
                ),
                centerTitle: true,
                elevation: 0.0,
              ),
            ),
          ),
          body: FutureBuilder<CoursedetailModel>(
            future: fetchCourseDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data found'));
              }

              final course = snapshot.data!.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                        ),
                        items: course.courseIntaks.map((courseIntak) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network(
                                courseIntak
                                    .intakeDate, // Replace with actual image URL
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Text(
                        course.courseName,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        course.courseDescription,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Syllabus:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(course.courseSyllabus),
                      SizedBox(height: 16),
                      Text(
                        'Course Level: ${course.courseLevel}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Total Fee: ₹${course.totalFee}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'University Name: ${course.universityName}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Country: ${course.universityCountry}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'City: ${course.universityCity}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Placement: ${course.placement}',
                        style: TextStyle(fontSize: 16),
                      ),
                      // Add more fields as needed
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
      ),
    );
  }
}
