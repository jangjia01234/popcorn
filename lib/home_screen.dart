import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poporn/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> popularData = [];
  List<dynamic> nowData = [];
  List<dynamic> soonData = [];

  List<dynamic> carouselImagesList = [];

  @override
  void initState() {
    super.initState();
    getPopularData();
    getNowData();
    getSoonData();
  }

  void getPopularData() async {
    final response = await http
        .get(Uri.parse('https://movies-api.nomadcoders.workers.dev/popular'));

    if (response.statusCode == 200) {
      popularData = jsonDecode(response.body)["results"];

      popularData.asMap().entries.forEach((entry) {
        var data = entry.value;
        var image = data["poster_path"];

        carouselImagesList.add("https://image.tmdb.org/t/p/w500/$image}");
      });
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

  void getNowData() async {
    final response = await http.get(
        Uri.parse('https://movies-api.nomadcoders.workers.dev/now-playing'));

    if (response.statusCode == 200) {
      nowData = jsonDecode(response.body)["results"];
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

  void getSoonData() async {
    final response = await http.get(
        Uri.parse('https://movies-api.nomadcoders.workers.dev/coming-soon'));

    if (response.statusCode == 200) {
      soonData = jsonDecode(response.body)["results"];
    } else {
      print('요청 실패: ${response.statusCode}');
    }
  }

  void onTapMoviePoster({
    required String title,
    required String poster,
    required double rate,
    required String overview,
    required List genres,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MovieDetailScreen(
          title: title,
          poster: poster,
          rate: rate,
          overview: overview,
          genres: genres,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = carouselImagesList
        .map((item) => GestureDetector(
              // onTap: onTapMoviePoster(title: item.title),
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Icon(
              Icons.incomplete_circle_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 6),
            Text(
              "Popcorn",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 5),
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.white38,
              size: 26,
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Most Popular",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var data in popularData)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onTapMoviePoster(
                                  title: data['title'],
                                  poster:
                                      "https://image.tmdb.org/t/p/w500/${data["poster_path"]}",
                                  rate: data['vote_average'],
                                  overview: data['overview'],
                                  genres: data["genre_ids"],
                                );
                              },
                              child: SizedBox(
                                height: 200,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${data["poster_path"]}"),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Now Playing",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var data in nowData)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onTapMoviePoster(
                                  title: data['title'],
                                  poster:
                                      "https://image.tmdb.org/t/p/w500/${data["poster_path"]}",
                                  rate: data['vote_average'],
                                  overview: data['overview'],
                                  genres: data["genre_ids"],
                                );
                              },
                              child: SizedBox(
                                height: 200,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${data["poster_path"]}"),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var data in soonData)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onTapMoviePoster(
                                  title: data['title'],
                                  poster:
                                      "https://image.tmdb.org/t/p/w500/${data["poster_path"]}",
                                  rate: data['vote_average'],
                                  overview: data['overview'],
                                  genres: data["genre_ids"],
                                );
                              },
                              child: SizedBox(
                                height: 200,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${data["poster_path"]}"),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
