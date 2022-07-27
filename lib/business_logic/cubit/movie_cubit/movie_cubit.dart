import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/api/api.dart';

import '../../../models/movie.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  String apiKey = API.apiKey;

  MovieCubit()
      : super(
          MovieState(
            popularMovies: <Movie>[],
            topMovies: <Movie>[],
            recommendedMovies: <Movie>[],
            myRatedMovies: <Movie>[],
            searchMovie: <Movie>[],
          ),
        );

  void init(String sessionId) async {
    emit(MovieLoadingState());
    await getPopularMovies();
    await getTopMovies();
    await getMyRatedMovie(sessionId);
    emit(MoviesLoadedState());
  }

  getPopularMovies() async {
    String popularApi =
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1";
    final response = await http.get(Uri.parse(popularApi));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      for (var movie in map["results"]) {
        Movie mov = Movie.fromMap(movie);
        state.popularMovies.add(mov);
      }
    } else {
      print("error");
    }
  }

  getTopMovies() async {
    String topMoviesAPI =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";
    final response = await http.get(Uri.parse(topMoviesAPI));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      for (var movie in map["results"]) {
        Movie topMov = Movie.fromMap(movie);
        state.topMovies.add(topMov);
      }
    } else {
      print("Top Movies error");
      print(response.statusCode);
    }
  }

  getRecommnededMovies(int movieId) async {
    emit(MovieLoadingState());
    String recommendedUrl =
        "https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$apiKey&language=en-US&page=1";
    final response = await http.get(Uri.parse(recommendedUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      for (var movie in map["results"]) {
        Movie recommendedMovie = Movie.fromMap(movie);
        state.recommendedMovies.add(recommendedMovie);
      }

      emit(MoviesLoadedState());
    } else {
      print("error");
      print(response.body);
    }
  }

  getMyRatedMovie(String sessionId) async {
    String myRatedMovies =
        "https://api.themoviedb.org/3/account/{account_id}/rated/movies?api_key=$apiKey&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=1";
    final response = await http.get(Uri.parse(myRatedMovies));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      for (var movie in map["results"]) {
        Movie myRatedMovie = Movie.fromMap(movie);
        state.myRatedMovies.add(myRatedMovie);
      }
    } else {
      print("error");
      print(response.body);
    }
  }
}
