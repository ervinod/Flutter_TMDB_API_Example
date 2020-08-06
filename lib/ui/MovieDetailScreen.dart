import 'package:assesment_task/util/Constants.dart';
import 'package:flutter/material.dart';


class MovieDetailScreen extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final double movieId;

  //setting default values in default costructor
  MovieDetailScreen({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  //list to hold movie list data
  final List<String> genresList = List<String>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                title: Text(widget.title),
                floating: true,
                pinned: false,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  Constants.IMAGE_PREFIX_W500+"${widget.posterUrl}",
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 50.0,
                  alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87
                        ),
                      ),
                    ),
                  ],
                ),

                Container(margin: EdgeInsets.only(top: 10.0, bottom: 8.0)),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star_half,
                          color: Colors.brown,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 1.0, right: 1.0),
                        ),
                        Text(
                          widget.voteAverage+" / 10",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13.0),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.brown,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 1.0, right: 1.0),
                        ),
                        Text(
                          widget.releaseDate,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(widget.description,
                  style: TextStyle(height:1.5, fontSize: 18, color: Colors.black45,),),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),

               Row(children: <Widget>[
                 Chip(
                   label: Text('Hollywood'),
                 ),
                 Container(margin: EdgeInsets.only(left: 8.0, right: 8.0)),
                 Chip(
                   label: Text('English'),
                 ),
               ],),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),

                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
