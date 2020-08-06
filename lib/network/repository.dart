import 'package:assesment_task/models/movie_detail.dart';
import 'package:assesment_task/models/movie_model.dart';

import 'movie_api_provider.dart';
import 'dart:async';


class Repository {

  final MovieApiProvider _movieApiProvider = MovieApiProvider();

  //get now playing movies
  Future<MovieModel> fetchMoviesList() => _movieApiProvider.fetchMovieList();

  //search movie
  Future<MovieModel> searchMoviesList(String query) => _movieApiProvider.searchMovieList(query);

  //fetch movie details
  Future<MovieDetail> fetchMovieDetail(int movieId) => _movieApiProvider.fetchMovieDetail(movieId);
  

}