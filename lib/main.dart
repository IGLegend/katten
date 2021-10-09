import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List data;
//  List imagesUrl = [];

  List imagesUrl=["https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/images/cats/cat-1.jpg",
      "https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/images/cats/cat-2.jpg",
  "https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/images/cats/cat-3.jpg",
  "https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/images/cats/cat-4.jpg",
  "https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/images/cats/cat-5.jpg",
  "https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/images/cats/cat-6.jpg"];


  @override
  void initState() {
    super.initState();
//    fetchDataFromApi();
  }

  Future<String> fetchDataFromApi() async {
    var url=Uri.https("s3-us-west-2.amazonaws.com", "/appsdeveloperblog.com/tutorials/files/cats.json");
    var jsonData = await http.get(url);
    var fetchData = jsonDecode(jsonData.body);

    setState(() {
      data = fetchData;
      data.forEach((element) {
        imagesUrl.add(element['url']);
      });
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Katten'),
        centerTitle: true,
      ),
      body:
      GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: imagesUrl.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            imagesUrl[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}