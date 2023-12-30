import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    List<Album> albums = data.map((json) => Album.fromJson(json)).toList();

    return albums;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Album>> deleteAlbum(String id, List<Album> currentAlbums) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    if (response.body.trim() == '{}') {
      print("Album is Deleted");
      return currentAlbums.where((album) => album.id.toString() != id).toList();
    } else {
      List<dynamic> data = jsonDecode(response.body);
      List<Album> albums = data.map((json) => Album.fromJson(json)).toList();
      return albums;
    }
  } else {
    throw Exception('Failed to delete album.');
  }
}

Future<List<Album>> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("Album Created");
    List<dynamic> data = jsonDecode(response.body);
    List<Album> albums = data.map((json) => Album.fromJson(json)).toList();
    return albums;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;
  List<Album> currentAlbums = [];
  TextEditingController mycontroller1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          flexibleSpace: Container(
            color: Colors.blue,
            child: Column(children: <Widget>[
              const SizedBox(height: 8),
              const Center(
                child: Text("Album Data",
                    style: TextStyle(fontSize: 26, color: Colors.black)),
              ),
              const SizedBox(height: 5),
              Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: TextField(
                          textAlign: TextAlign.left,
                          controller: mycontroller1,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              hintStyle: new TextStyle(color: Colors.black38),
                              hintText: "Enter Title"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        onPressed: () {
                          createAlbum(mycontroller1.text.toString());
                          mycontroller1.clear();
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  )),
            ]),
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                currentAlbums = snapshot.data!; ////
                return ListView.builder(
                  itemCount: currentAlbums.length, ////
                  itemBuilder: (context, index) {
                    Album album = currentAlbums[index]; ////
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(album.title),
                        subtitle: Text("ID: ${album.id}"),
                        selectedColor: Color.fromARGB(0, 47, 1, 73),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            /////
                            try {
                              // Pass the current list of albums to the deleteAlbum function.
                              futureAlbum = deleteAlbum(
                                  album.id.toString(), currentAlbums);
                              setState(() {});
                            } catch (e) {
                              Text('Error deleting album: $e');
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
