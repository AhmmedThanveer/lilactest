import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:lilacmachinetest/Models/Coursedetailmodel.dart';
import 'package:lilacmachinetest/provider/Apiservice.dart';
import 'dart:convert';
import '../../../Helper/SharedprefrenceHelper.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
          '${ApiService.baseUrl}/api/lead/course/SearchPopularSingleCourseFinding?id=$courseId&universityId=$universityId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      print('id :${courseId}');
      print('id :${universityId}');
      return CoursedetailModel.fromJson(json.decode(response.body));
    } else {
      print('error');
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
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 17,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            size: 17,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 17,
                          color: Colors.black,
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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data found'));
              }

              final course = snapshot.data!.data;

              return SingleChildScrollView(
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
                      items: [
                        course.logoImage ??
                            'https://media.istockphoto.com/id/1998218861/photo/teacher-talking-to-a-group-of-students-in-the-classroom.jpg?s=1024x1024&w=is&k=20&c=LB-BHEuJbmAzBdb22Grye-ZXGuuIHby1q-cfmaWeKhw=', // Fallback image
                        // Add more images here if needed
                      ].map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(
                              'https://media.istockphoto.com/id/1998218861/photo/teacher-talking-to-a-group-of-students-in-the-classroom.jpg?s=1024x1024&w=is&k=20&c=LB-BHEuJbmAzBdb22Grye-ZXGuuIHby1q-cfmaWeKhw=',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        course.courseName ?? 'No Course Name',
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/museum 1.svg',
                            color: const Color.fromARGB(255, 25, 25, 26),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${course.universityName} university' ??
                                'No Course Name',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    DefaultTabController(
                      length: 5,
                      child: Column(
                        children: [
                          const TabBar(
                            isScrollable: true,
                            tabAlignment: TabAlignment.center,
                            physics: NeverScrollableScrollPhysics(),
                            tabs: [
                              Tab(text: 'Course'),
                              Tab(
                                  child: Text(
                                "Eligibility",
                              )),
                              Tab(text: 'University'),
                              Tab(text: 'Entrance'),
                              Tab(text: 'Syllabus'),
                            ],
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Color(0xFFFF1B6F),
                            indicatorWeight: 5,
                            labelColor: Colors.pink,
                            unselectedLabelColor: Color(0xFFD3D3D3),
                            dividerHeight: 4,
                            mouseCursor: SystemMouseCursors.click,
                            dividerColor: Color.fromARGB(255, 206, 203, 203),
                            labelStyle: TextStyle(
                              color: Color(0xFFFF1B6F),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          // Add more fields as needed
                          SizedBox(
                            height: 700,
                            child: TabBarView(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20),
                                    child: Text(
                                      course.courseDescription ??
                                          'No Description',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  course.courseEligible.isEmpty
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 30),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                              'assets/svgs/done.svg',
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              "Eligibility",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ]),
                                        ),
                                  course.courseEligible.isEmpty
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 20, right: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFF6F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28)),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 60,
                                                width: double.infinity,
                                                child: const Text(""),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFF6F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28)),
                                              ),
                                            ],
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, left: 30, top: 30),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/svgs/done.svg',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Course Intakes",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, left: 30, top: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 120,
                                          child: const Text(""),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFF6F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(28)),
                                        ),
                                        Container(
                                          height: 60,
                                          width: 120,
                                          child: const Text(""),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFF6F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(28)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 30),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/svgs/Group 3891.svg',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Course Duration",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20, right: 10),
                                    child: Column(
                                      children: [
                                        // Container(
                                        //   height: 60,
                                        //   width: double.infinity,
                                        //   decoration: BoxDecoration(
                                        //       color: Color(0xFFF6F5F5),
                                        //       borderRadius:
                                        //           BorderRadius.circular(28)),
                                        // ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 60,
                                          width: double.infinity,
                                          child: const Text(""),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFF6F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(28)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50,
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF141E3C),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: const Center(
                                          child: Text(
                                            "Get Admission",
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(child: tab,)
                  ]));
            },
          ),
        )
      ]),
    );
  }
}
