import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '355b98afbe23246c3ed6ad8765f20e0d';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTViOThhZmJlMjMyNDZjM2VkNmFkODc2NWYyMGUwZCIsInN1YiI6IjYxZWMyMzY4ZWEzN2UwMDA5ZTgyMWQyOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bga_KkegUI-jDPS1n2tKSew1p_MbrSM7W0lNL8QfH8w';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: modified_text(text: 'Movie Buzz ❤️'),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: ListView(
          children: [
            TV(tv: tv),
            TrendingMovies(
              trending: trendingmovies,
            ),
            TopRatedMovies(
              toprated: topratedmovies,
            ),
          ],
        ));
  }
}
