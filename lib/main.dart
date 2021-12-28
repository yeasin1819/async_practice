import 'dart:convert';

import 'package:async_practice/secondScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int main() {
  runApp(MyApp());
  return 0;
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("PageRoute"),
          centerTitle: true,
        ),
        body: FirstPage(),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Map> dataList = [];
  List<int> test = [1, 2, 3];
  getData() async {
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
    if (response.statusCode == 200) {
      dataList = jsonDecode(response.body);
    } else
      print("Error...!");
    //print(dataList[0]['userId'].toString());
  }

  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return dataList.isNotEmpty ? SingleChildScrollView(
        child: Column(
      children: [
        ListTile(
          title: Text("User ID: " + dataList[0]['userId']),
          subtitle: Text(dataList[0]['title']),
          leading: Icon(Icons.account_circle, color: Colors.blue),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      ],
    )) :
    Container( 
      child: Text("Data Not Found"),
    );
  }
}
