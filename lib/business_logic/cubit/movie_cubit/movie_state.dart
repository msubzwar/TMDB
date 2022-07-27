part of 'movie_cubit.dart';

class MovieState {
  late List<Movie> popularMovies = [];
  late List<Movie> topMovies = [];
  late List<Movie> recommendedMovies = [];
  late List<Movie> myRatedMovies = [];
  late List<Movie> searchMovies = [];

  MovieState(
      {popularMovies,
      topMovies,
      recommendedMovies,
      myRatedMovies,
      searchMovie});
}

class MovieLoadingState extends MovieState {}

class MovieTopMovieLoadingState extends MovieState {}

class MoviesLoadedState extends MovieState {}
