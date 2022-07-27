import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb/business_logic/cubit/movie_cubit/movie_cubit.dart';
import 'package:tmdb/views/widgets/movieCard.dart';

import '../business_logic/cubit/user_cubit/cubit/user_cubit.dart';
import '../models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = BlocProvider.of<MovieCubit>(context);
    movieCubit.getRecommnededMovies(movie.id);

    List<Movie> recommendedMovies =
        BlocProvider.of<MovieCubit>(context).state.recommendedMovies;

    double reviewRating = 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0x44000000).withOpacity(0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: movie.backdrop_path == ""
                  ? const Image(
                      image: AssetImage("assets/movie.png"),
                    )
                  : Image.network(
                      movie.backdropPath(),
                      loadingBuilder: ((context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : SizedBox(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.white,
                                    highlightColor: Colors.black,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                    ),
                                  ),
                                )),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      child: Row(
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: false,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "TMDB Rating: ",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          movie.getRating().toString(),
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          " Language: ",
                          style: TextStyle(fontSize: 10),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.capsLanguage(),
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    "Overview: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 10.0),
              child: Text(
                movie.overview,
                maxLines: 5,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0),
                  child: Text(
                    "Recommended ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            MovieCards(
              movies: recommendedMovies,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                review(context, reviewRating),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<UserCubit>(context).likeMovie(movie.id),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("Like"),
                        Icon(
                          Icons.thumb_up,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding review(BuildContext context, double reviewRating) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("IMDb Review"),
                content: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    reviewRating = rating;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<UserCubit>(context)
                          .updateReview(movie.id, reviewRating);

                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay"),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Text("Do a Review"),
        ),
      ),
    );
  }
}
