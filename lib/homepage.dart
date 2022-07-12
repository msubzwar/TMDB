import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Top Movies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        MovieCards(),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Popular Movies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        MovieCards(),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MovieCards extends StatelessWidget {
  const MovieCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  for (int i = 0; i < 10; i++)
                    Container(
                      width: 200,
                      height: 300,
                      child: Card(
                        color: Colors.red,
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Movie Title",
                            ),
                            Text("TMDb Rating: yyyy"),
                            Text("cast"),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
