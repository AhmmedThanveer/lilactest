import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'home_screen.dart';  // Import your screen widgets
// import 'abc_screen.dart';
// import 'search_screen.dart';
// import 'alarm_screen.dart';
// import 'unit_screen.dart';

// import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Home Screen', style: TextStyle(fontSize: 24)));
  }
}

class AbcScreen extends StatelessWidget {
  const AbcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Bank Screen', style: TextStyle(fontSize: 24)));
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Support Screen', style: TextStyle(fontSize: 24)));
  }
}

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Cousrses Screen', style: TextStyle(fontSize: 24)));
  }
}

class UnitScreen extends StatelessWidget {
  const UnitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Note Screen', style: TextStyle(fontSize: 24)));
  }
}
