import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb/business_logic/cubit/user_cubit/cubit/user_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: "");
    TextEditingController passwordController = TextEditingController(text: "");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: Center(
                  child: Shimmer.fromColors(
                    period: const Duration(seconds: 1),
                    baseColor: Colors.white,
                    highlightColor: Colors.red,
                    child: const Text(
                      "TMDB Movies",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: usernameController,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.send,
                  decoration: const InputDecoration(
                    hintText: "username",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "*******",
                    border: UnderlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: const Center(
                    widthFactor: 4,
                    child: const Text("Log in"),
                  ),
                  onPressed: () {
                    BlocProvider.of<UserCubit>(context)
                        .init(usernameController.text, passwordController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
