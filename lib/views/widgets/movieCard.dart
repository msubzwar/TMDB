import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb/business_logic/cubit/user_cubit/cubit/user_cubit.dart';

import '../../business_logic/cubit/movie_cubit/movie_cubit.dart';
import '../../models/movie.dart';
import '../movieDetailPage.dart';

class MovieCards extends StatelessWidget {
  final List<Movie> movies;

  const MovieCards({
    Key? key,
    required this.movies,
  }) : super(key: key);

  smallDetails(Movie movie, BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(200, 200, 200, 200),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: Text(movie.overview),
        ),
      ],
    );
    Text(movie.overview);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MoviesLoadedState) {
            return Row(
              children: [
                for (Movie movie in movies)
                  GestureDetector(
                    onLongPress: () => smallDetails(movie, context),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: movie,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            width: 160,
                            height: 240,
                            child: Stack(
                              children: [
                                movie.poster_path == ""
                                    ? const Image(
                                        height: 235,
                                        width: 160,
                                        image: AssetImage("assets/movie.png"),
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        movie.posterPath(),
                                        loadingBuilder: ((context, child,
                                                loadingProgress) =>
                                            loadingProgress == null
                                                ? child
                                                : Container(
                                                    width: 160.0,
                                                    height: 235.0,
                                                    color: Colors.black,
                                                    child: Shimmer.fromColors(
                                                      period: const Duration(
                                                          seconds: 1),
                                                      direction:
                                                          ShimmerDirection.ltr,
                                                      baseColor: Colors.white,
                                                      highlightColor:
                                                          Colors.black,
                                                      child: Container(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )),
                                      ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          220, 216, 63, 63),
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          movie.getRating().toString(),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 1.0, left: 2.0),
                                          child: Icon(
                                            Icons.star,
                                            color: Color.fromARGB(
                                                255, 248, 232, 7),
                                            size: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 160,
                            child: Column(
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                                Text(
                                  movie.getYearOfRelease(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          } else if (state is UserLoggedin) {
            return SizedBox(
              width: 160.0,
              height: 235.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: const SizedBox(
                  width: 200,
                  height: 300,
                ),
              ),
            );
          } else {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.black),
                  width: 160.0,
                  height: 235.0,
                  child: Shimmer.fromColors(
                    period: Duration(seconds: 2),
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.black),
                  width: 160.0,
                  height: 235.0,
                  child: Shimmer.fromColors(
                    period: Duration(seconds: 1),
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.white,
                    highlightColor: Colors.black,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.black),
                  width: 160.0,
                  height: 235.0,
                  child: Shimmer.fromColors(
                    period: Duration(seconds: 1),
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.black,
                    highlightColor: Colors.white,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
