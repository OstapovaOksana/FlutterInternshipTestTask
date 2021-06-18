import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterinternshiptesttask/search.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://raw.githubusercontent.com/ababicheva/FlutterInternshipTestTask/main/recipes.json"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode(response.body);
    });

    data.sort((a, b) {
      return a["id"].compareTo(b["id"]);
    });

    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("My Recipes"),
          backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: () {
              showSearch(
                  context: context, delegate: Search(data));
            },
          ),
        ],
      ),
      body: new ListView.separated(
          itemCount: data == null ? 0 : data.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index){
            return new Container(
                padding: EdgeInsets.only(top:15),
                child: Row(
                  children: [
                    Image.network(data[index]["picture"], height: 80, width: 120, fit: BoxFit.fill),
                    Expanded(child: ListTile(
                      title: Text(
                        data[index]["name"],
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      subtitle: Text(data[index]["description"]),
                      trailing: Text(
                        data[index]["id"].toString(),
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16),
                      ),

                    )
                    )

                  ],
                )
            );
          },
        ),

    );
  }
}