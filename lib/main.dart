import 'package:assesment_task/ui/MovieListScreen.dart';
import 'package:assesment_task/util/Constants.dart';
import 'package:flutter/material.dart';

//this is the entry point of our app
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: MovieListScreen(),
        //calling screen to show all movie list
      ),
    );
  }
}