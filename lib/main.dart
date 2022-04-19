import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getUserData() async {
    var response = await http.get(
      Uri.https('jsonplaceholder.typicode.com', 'users'),
    );
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API менен иштоо'),
      ),
      body: Center(
        child: Container(
          child: Card(
            child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(child: Text("Loading...")),
                  );
                } else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data[index].name,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(snapshot.data[index].userName),
                          trailing: Text(snapshot.data[index].email),
                        );
                      });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}
