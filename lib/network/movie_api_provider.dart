import 'dart:async';

import 'package:assesment_task/models/movie_detail.dart';
import 'package:assesment_task/models/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MovieApiProvider {

  http.Client client = http.Client();
  //api key for TMDB database
  final _apiKey = '02acdc84e965c5895bf7a703cb81b20c';
  //base url for TMDB database
  final _baseUrl = "http://api.themoviedb.org/3";

  //function to hit all movies list api
  Future<MovieModel> fetchMovieList() async {
    final response = await client.get("$_baseUrl/movie/now_playing?api_key=$_apiKey");
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
       throw Exception('Failed to load movies list');
    } 
  }

  //function to hit search movie api
  Future<MovieModel> searchMovieList(String query) async {
    final response = await client.get("$_baseUrl/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=1&include_adult=false");
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search movie');
    }
  }

  //function to hit movie details api
  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final response = await client.get("$_baseUrl/$movieId?api_key=$_apiKey");
    debugPrint(response.body.toString());
    if(response.statusCode == 200) {
      return MovieDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to retrieve Movie Detail');
    }
  }
}