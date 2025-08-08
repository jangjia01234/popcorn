import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("가장 인기있는 영화"),
            Text("상영중인 영화"),
            Text("곧 개봉할 영화"),
          ],
        ),
      ),
    );
  }
}
