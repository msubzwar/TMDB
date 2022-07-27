import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:http/http.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  String sessionId = "";
  int userID = 0;

  UserCubit() : super(UserInitial());

  void init(String username, String password) async {
    String requestToken =
        "https://api.themoviedb.org/3/authentication/token/new?api_key=a57b939075e0dfa4c2f854bd09d6621a";
    final response = await http.get(Uri.parse(requestToken));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      String token = map["request_token"];

      String userAuthUri =
          "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=a57b939075e0dfa4c2f854bd09d6621a";

      dynamic responseSession = await http.post(
        Uri.parse(userAuthUri),
        body: {
          "request_token": token,
          "username": username,
          "password": password
        },
      );
      if (responseSession.statusCode == 200) {
        Map<String, dynamic> map = json.decode(responseSession.body);

        String requestToken = map["request_token"];
        String sessionUrl =
            "https://api.themoviedb.org/3/authentication/session/new?api_key=a57b939075e0dfa4c2f854bd09d6621a";

        Response sessionResponse = await http.post(
          Uri.parse(sessionUrl),
          body: {"request_token": requestToken},
        );

        if (sessionResponse.statusCode == 200) {
          Map<String, dynamic> map = json.decode(sessionResponse.body);
          sessionId = map["session_id"];

          emit(UserLoggedin());
        }
      }
      if (responseSession.statusCode == 400 ||
          responseSession.statusCode == 401) {
        Map<String, dynamic> map = json.decode(responseSession.body);
      }
    }
  }

  getUserDetails() async {
    String accountDetailString =
        "https://api.themoviedb.org/3/account?api_key=a57b939075e0dfa4c2f854bd09d6621a&session_id=$sessionId";
    Response accountDetailResponse = await http.post(
      Uri.parse(accountDetailString),
    );

    Map<String, dynamic> userDetails = json.decode(accountDetailResponse.body);

    userID = userDetails["id"] ?? 123;
  }

  updateReview(int id, double rating) async {
    rating = rating * 2;

    String reviewUrl =
        "https://api.themoviedb.org/3/movie/$id/rating?api_key=a57b939075e0dfa4c2f854bd09d6621a";
    Response response = await http.post(
      Uri.parse(reviewUrl),
      body: {
        "value": rating.toString(),
        "session_id": sessionId,
      },
    );
  }

  likeMovie(int id) async {
    String likeMovieUrl =
        "https://api.themoviedb.org/3/account/{account_id}/favorite?api_key=a57b939075e0dfa4c2f854bd09d6621a&session_id=$sessionId";
    print(likeMovieUrl);
    Response response = await http.post(
      Uri.parse(likeMovieUrl),
      body: {
        "media_type": "movie",
        "media_id": id.toString(),
        "favorite": true.toString(),
      },
    );
    print(response.body);
  }
}
