import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubit/movie_cubit/movie_cubit.dart';
import 'package:tmdb/business_logic/cubit/user_cubit/cubit/user_cubit.dart';
import 'package:tmdb/views/signin.dart';
import 'views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieCubit()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 20, 17, 17),
            textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white),
                bodyLarge: TextStyle(color: Colors.white)),
            primarySwatch: Colors.red,
            backgroundColor: Colors.red,
          ),
          home: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoggedin) {
                return const MyHomePage(title: "TMBD");
              } else {
                return const SignIn();
              }
            },
          )),
    );
  }
}
