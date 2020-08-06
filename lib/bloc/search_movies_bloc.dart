import 'package:assesment_task/models/movie_model.dart';
import 'package:assesment_task/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchMoviesBloc {

  //creating repository instance for making network call
  final _repository = Repository();

  //creating subject of publish type to notify fetching list data
  final _moviesFetcher = PublishSubject<MovieModel>();

  //stream to fet movie list
  Stream<MovieModel> get allMovies => _moviesFetcher.stream;

  //Fetching all movie list with entered keyword
  searchAllMovies(String query) async {
    MovieModel itemModel = await _repository.searchMoviesList(query);
    _moviesFetcher.sink.add(itemModel); 
  }

  //clear stream data
  dispose() {
    _moviesFetcher?.drain();
  }
}
final bloc = SearchMoviesBloc();