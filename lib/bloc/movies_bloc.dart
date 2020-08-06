
import 'package:assesment_task/bloc/validation.dart';
import 'package:assesment_task/models/movie_model.dart';
import 'package:assesment_task/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Object with Validation{

  //creating repository instance for making network call
  final _repository = Repository();

  //creating subject of publish type to notify fetching list data
  final _moviesFetcher = PublishSubject<MovieModel>();

  // retrieve data from stream
  //The transform is used to check whenever there is some changed in your textfield and done some validation
  Stream<String> get searchStream => _searchQuery.stream.transform(validateQuery);
  var _searchQuery = BehaviorSubject<String>();

  // add data to stream
  Stream<bool> get submitValid => searchStream.map((email) => true);
  Function(String) get changeQuery => _searchQuery.sink.add;
  Stream<MovieModel> get allMovies => _moviesFetcher.stream;

  //Fetching all movie list
  fetchAllMovies() async {
    MovieModel itemModel = await _repository.fetchMoviesList();
    _moviesFetcher.sink.add(itemModel); 
  }

  clearBloc() {
    _searchQuery.sink.add(null);
  }

  //clear stream data
  dispose() {
    _moviesFetcher?.close();
    _searchQuery.close();
  }
}
final bloc = MoviesBloc();