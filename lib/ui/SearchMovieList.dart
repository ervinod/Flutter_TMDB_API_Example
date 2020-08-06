import 'package:assesment_task/bloc/search_movies_bloc.dart';
import 'package:assesment_task/models/movie_model.dart';
import 'package:flutter/material.dart';

import 'MovieDetailScreen.dart';

class SearchMovieList extends StatefulWidget {

  SearchMovieList({this.query});
  final String query;

  @override
  MovieListState createState() {
    return new MovieListState();
  }
}

class MovieListState extends State<SearchMovieList> {
  @override
  void initState() {
    super.initState();
      bloc.searchAllMovies(widget.query);
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
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Result'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: bloc.allMovies,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return createListViewUI(snapshot);
              } else if (snapshot.hasError) {
                print("Inside hasError");
                return Text(snapshot.error.toString());
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ),
      ),
    );
  }

  //navigating to movie details screen on item click
  goToMoviesDetailPage(item) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          MovieDetailScreen(
            title: item.title,
            posterUrl: item.poster_path,
            description: item.overview,
            releaseDate: item.release_date,
            voteAverage: item.vote_average.toString(),
            movieId: item.id.toDouble(),
          )
      ));
  }

  //function to get UI for list of movies
  Widget createListViewUI(AsyncSnapshot<MovieModel> snapshot) {
    if(snapshot.data.results.length==0){
      //check if no movies found and return message
      return Center(child: Text("Oops...No Movie Found", style: TextStyle(height:1.5, fontSize: 18, color: Colors.black45,),));
    }else{
      return ListView.builder(
          padding: EdgeInsets.only(bottom: 10),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: (snapshot.data.results.length),
          itemBuilder: (context, index) {
            return getItemWidget(snapshot.data.results[index]);
          });
    }
  }


  //this function will return UI for each item of list view
  Widget getItemWidget(item) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Material(
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () => goToMoviesDetailPage(item),
          child: ListTile(
            leading: Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                // Using ClipRRect for making round corners
                borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${item.poster_path}',
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            title: Text(item.title, style: TextStyle(
              fontSize: 18.0,
            ),),
            subtitle: Container(
                child: Row(children: <Widget>[
                  Icon(
                    Icons.star_half,
                    color: Colors.brown,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 1.0, right: 1.0),
                  ),
                  Text(
                    item.vote_average.toString()+" / 10",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],)
            )
          ),
        ),
      ),
    );
  }

}
