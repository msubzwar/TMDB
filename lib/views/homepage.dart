import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubit/movie_cubit/movie_cubit.dart';
import 'package:tmdb/business_logic/cubit/user_cubit/cubit/user_cubit.dart';
import 'package:tmdb/views/search.dart';
import 'package:tmdb/views/widgets/movieCard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = BlocProvider.of<MovieCubit>(context);
    movieCubit.init(BlocProvider.of<UserCubit>(context).sessionId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const Search())),
              icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, top: 12.0),
                    child: Text(
                      "Popular Movies This Week",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              MovieCards(
                movies: movieCubit.state.popularMovies,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, top: 12.0),
                    child: Text(
                      "Top Movies",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              MovieCards(
                movies: movieCubit.state.topMovies,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, top: 12.0),
                    child: Text(
                      "My Rated Movies",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              MovieCards(
                movies: movieCubit.state.myRatedMovies,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
