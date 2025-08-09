import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.poster,
    required this.rate,
    required this.overview,
    required this.genres,
  });

  final String title;
  final String poster;
  final double rate;
  final String overview;
  final List genres;

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
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 60),
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
                                    "✭ ${"${widget.rate}".substring(0, 3)}",
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
                          Text(
                            widget.overview,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "genre: ${widget.genres}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
