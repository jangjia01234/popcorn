import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.poster,
    required this.rate,
    required this.overview,
    required this.genres,
    required this.year,
    required this.count,
  });

  final int id;
  final String title;
  final String poster;
  final double rate;
  final String overview;
  final List genres;
  final String year;
  final int count;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final List imgList = [
    "https://i.pinimg.com/736x/59/25/0c/59250c5d2643ac882b592e0604db7a15.jpg",
    "https://images.pexels.com/photos/3174435/pexels-photo-3174435.jpeg",
    "https://images.pexels.com/photos/33017020/pexels-photo-33017020.jpeg",
    "https://images.pexels.com/photos/27532726/pexels-photo-27532726.jpeg",
  ];

  List<dynamic> genresList = [];

  @override
  void initState() {
    super.initState();
    getGenres();
  }

  void getGenres() async {
    // id로 데이터 가져오기
    final response = await http.get(Uri.parse(
        'https://movies-api.nomadcoders.workers.dev/movie?id=${widget.id}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["genres"];

      data.asMap().entries.forEach((entry) {
        var value = entry.value;
        var name = value['name'];

        genresList.add(name);
      });

      setState(() {});
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        // TODO: Home에서 넘겨준 데이터로 [장르] 표시
        // genres(배열)
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.poster,
                  fit: BoxFit.fitWidth,
                ),
                // TODO: 하단 흐림 처리
              ],
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 480),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "✭ ${"${widget.rate}".substring(0, 3)}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "(${widget.count})",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            for (var genre in genresList)
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.white54,
                                      ),
                                    ),
                                    child: Text(
                                      genre,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                ],
                              ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "Overview",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          widget.overview,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
