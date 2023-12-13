import 'package:flutter/material.dart';
import 'package:weather_app/views/home.dart';
import 'package:weather_app/views/loaction.dart';
import 'package:weather_app/views/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/loading': (context) => const Search(),
    },
  ));
}
