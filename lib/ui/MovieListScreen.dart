import 'package:assesment_task/bloc/movies_bloc.dart';
import 'package:assesment_task/models/movie_model.dart';
import 'package:assesment_task/util/Constants.dart';
import 'package:assesment_task/util/Helper.dart';
import 'package:flutter/material.dart';
import 'MovieDetailScreen.dart';
import 'SearchMovieList.dart';

class MovieListScreen extends StatefulWidget {

  @override
  MovieListScreenState createState() {
    return new MovieListScreenState();
  }
}

class MovieListScreenState extends State<MovieListScreen> {

  DateTime currentBackPressTime;
  //declaring node to manage texfield focus
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    //getting all movie list from api
    bloc.fetchAllMovies(context);
  }

  @override
  void dispose() {
    //this function will execute while screen is closed
    super.dispose();
    //releasing block resources here
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          appBar: MyCustomAppBarWidget(
            _searchFocus,
            height: 120,

          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder(
              stream: bloc.allMovies,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  //function to get UI for grid of movies
  Widget buildList(AsyncSnapshot<MovieModel> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: InkResponse(
            splashColor: Colors.red,
            enableFeedback: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png',
                image:Constants.IMAGE_PREFIX_W185+"${snapshot.data.results[index]
                    .poster_path}",
                fit: BoxFit.cover,
              ),
            ),
            onTap: () => goToMoviesDetailPage(snapshot.data, index),
          ),
        );
      },
    );
  }

  //navigating to movie details screen on item click
  goToMoviesDetailPage(MovieModel data, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailScreen( title: data.results[index].title,
        posterUrl: data.results[index].poster_path,
        description: data.results[index].overview,
        releaseDate: data.results[index].release_date,
        voteAverage: data.results[index].vote_average.toString(),
        movieId: data.results[index].id.toDouble())));

  }

  //function to check if back button pressed and show exit app message
  Future<bool> onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Helper.showShortToast(context, Constants.MSG_EXIT_APP);
      return Future.value(false);
    }
    return Future.value(true);
  }

}

//creating custom actionbar with search functionality
class MyCustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final FocusNode searchFocus;

  const MyCustomAppBarWidget(this.searchFocus, {
    Key key,
    @required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.searchStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: Row(children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          //handle click on icon
                        },
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            onChanged: bloc.changeQuery,
                            focusNode: searchFocus,
                            decoration: InputDecoration.collapsed(
                              hintText: Constants.SEARCH_MOVIE,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          searchFocus.unfocus();
                          if(snapshot.hasData){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchMovieList(query: snapshot.data)));
                          }else{
                            Helper.showShortToast(context, Constants.SEARCH_ERROR_MSG);
                          }
                        },
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}



