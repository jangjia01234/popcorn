import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void getData() async {
    // var url = Uri.https(
    //   'https://movies-api.nomadcoders.workers.dev',
    //   '/popular',
    // );
    //
    // var response = await http.get(url);

    // print(response);

    final response = await http
        .get(Uri.parse('https://movies-api.nomadcoders.workers.dev/popular'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

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
            ElevatedButton(
              onPressed: getData,
              child: Text(
                "button",
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                  backgroundColor: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
