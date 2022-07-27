import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubit/movie_cubit/movie_cubit.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController(text: "");
    List<String> litems = [];
    return Scaffold(
      appBar: AppBar(
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: search,
              onSubmitted: (text) {
                litems.add(text);
                search.clear();
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: ((context, movieState) {
          return ListView.builder(
            itemCount: movieState.searchMovies.length,
            itemBuilder: ((context, index) => Card(
                  color: Colors.blueAccent,
                  child: Text("Movie"),
                )),
          );
        }),
      ),
    );
  }
}
