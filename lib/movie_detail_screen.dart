import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "",
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
          children: [
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    imgList[0],
                    fit: BoxFit.cover,
                  ),
                  Icon(
                    Icons.play_circle_outline_rounded,
                    color: Colors.white60,
                    size: 60,
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Title",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "✭ 4.7",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "2022",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white38,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "13+",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text("영화의 개요"),
                        Text("영화의 장르"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
