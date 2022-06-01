//ignore_for_file: unused_import, use_key_in_widget_constructors_in_immutables,prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:userlist/models/user.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: Home()),
  );
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<User>>? file;
  final userListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    file = getFileList();
  }

  Future<List<User>> getFileList() async {
    var url = 'https://datafence.000webhostapp.com/list2.php';
    http.Response response = await http.get(Uri.parse(url));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<User> file = items.map<User>((json) {
      return User.fromJson(json);
    }).toList();
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: userListKey,
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: file,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    // onTap: () {
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => Details()),
                    //);
                    //},
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
