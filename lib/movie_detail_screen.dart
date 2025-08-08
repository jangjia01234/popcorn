import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("영화의 포스터"),
            Text("영화의 제목"),
            Text("영화의 등급"),
            Text("영화의 개요"),
            Text("영화의 장르"),
          ],
        ),
      ),
    );
  }
}
