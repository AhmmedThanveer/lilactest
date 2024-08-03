// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:lilacmachinetest/Helper/SharedprefrenceHelper.dart';
import 'package:lilacmachinetest/Models/Featurecourselistmodel.dart';
import 'package:lilacmachinetest/View/Screens/Coursedetail%20Screen/coursedetailscreen.dart';
import 'dart:convert';

import 'package:lilacmachinetest/provider/Apiservice.dart';

class FeaturedcourselistScreen extends StatefulWidget {
  const FeaturedcourselistScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FeaturedcourselistScreenState createState() =>
      _FeaturedcourselistScreenState();
}

class _FeaturedcourselistScreenState extends State<FeaturedcourselistScreen> {
  List<CourseList> _courses = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _skipValue = 0;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    final token = await Sharedpreferencehelper().getAuthToken();
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            '${ApiService.baseUrl}/api/landing/home/featuredCourse?skipValue=$_skipValue'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = Featurecourselist.fromJson(json.decode(response.body));
        setState(() {
          _isLoading = false;
          _hasMore = data.data.isNotEmpty;
          _courses.addAll(data.data);
          _skipValue += data
              .data.length; // Increment skipValue by number of items fetched
        });
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasMore = false; // Stop loading if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios_rounded),
        title: const Text(
          'Featured Courses',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          SvgPicture.asset(
            'assets/svgs/Group 3919.svg',
            // ignore: deprecated_member_use
            color: const Color.fromARGB(255, 138, 138, 153),
          ),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            'assets/svgs/settings.svg',
            color: const Color.fromARGB(255, 138, 138, 153),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!_isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchCourses();
          }
          return false;
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount:
              _courses.length + 1, // Add one more for the loading indicator
          itemBuilder: (context, index) {
            if (index == _courses.length) {
              // Show loading indicator at the end of the grid
              return _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(); // Empty widget when no more items
            }

            final course = _courses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // ignore: prefer_const_constructors
                    builder: (context) => Coursedetailscreen(
                      courseId: 25,
                      universityId: 12,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Shadow position
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0)),
                          child: Image.network(
                            course.images.first,
                            fit: BoxFit.cover,
                            height: screenH / 7,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 78,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '₹ ${course.courseFee}',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 78,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    course.universityName,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 9,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 70,
                        //   left: 8,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         course.universityNameuniversity,
                        //         style: TextStyle(
                        //             fontFamily: 'Poppins',
                        //             fontSize: 12,
                        //             color: Colors.grey),
                        //       ),
                        //       Text(
                        //         course.courseTitle,
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontFamily: 'Inter',
                        //             fontSize: 12,
                        //             color: Colors.white),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 4),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/museum 1.svg',
                            color: const Color.fromARGB(255, 8, 8, 8),
                            height: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${course.universityName} university',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        course.courseTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
