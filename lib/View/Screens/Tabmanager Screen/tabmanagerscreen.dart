import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lilacmachinetest/View/Screens/CoursesList%20Screen/featuredcourselistscreen.dart';
import 'package:lilacmachinetest/View/Screens/Home%20Screen/homescreen.dart';

class Tabmanagerscreen extends StatefulWidget {
  const Tabmanagerscreen({super.key});

  @override
  State<Tabmanagerscreen> createState() => _TabmanagerscreenState();
}

class _TabmanagerscreenState extends State<Tabmanagerscreen> {
  List<String> navIcons = [
    'assets/svgs/home.svg',
    'assets/svgs/bank.svg',
    'assets/svgs/Group 4092.svg',
    'assets/svgs/teacher.svg',
    'assets/svgs/Group 4091.svg',
  ];
  // Define the screens for each tab
  List<Widget> screens = [
    HomeScreen(),
    AbcScreen(),
    SearchScreen(),
    FeaturedcourselistScreen(),
    UnitScreen(),
  ];

  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: navbar(),
    );
  }

  Widget navbar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
        color: const Color(0xFF141E3C),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navIcons.asMap().entries.map((entry) {
          int index = entry.key;
          String iconPath = entry.value;
          bool isSelected = selectedIndex == index;
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          isSelected ? Colors.white : const Color(0xFF141E3C),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 3,
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFF49B1A),
                                  Color(0xFFFF7B39),
                                  Color(0xFFFF4E52),
                                  Color(0xFFF80080),
                                  Color(0xFFAC018B),
                                  Color(0xFF820090),
                                ],
                                stops: [
                                  0.0661,
                                  0.3781,
                                  0.7192,
                                  1.0788,
                                  1.42,
                                  1.7704,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              iconPath,
                              color: Colors.white,
                            ),
                          )
                        : SvgPicture.asset(
                            iconPath,
                            color: const Color.fromARGB(255, 138, 138, 153),
                          ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
