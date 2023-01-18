import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futurebuilder_api_app/Screens/userboi.dart';
import 'package:futurebuilder_api_app/models/Users.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fulure builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> getUser() async {
    var url = Uri.parse('https://randomuser.me/api/?results=20');
    late http.Response response;
    List<User> users = [];
    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        Map peopleData = jsonDecode(response.body);
        List peopleList = peopleData["results"];

        for (var item in peopleList) {
          String Email = item["email"].toString();
          String Name =
              (item["name"]["first"] + " " + item["name"]["last"]).toString();
          String Id = item["id"]["value"].toString();
          String img = item["picture"]["thumbnail"].toString();
          User user = User(Id, Name, Email, img);
          users.add(user);
        }
      } else {
        return Future.error('somthing went wrong!,${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString() + "broo..");
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("app")),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("wating.."),
            );
          } else {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString() + 'haaaa');
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].avatar)),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].email),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return UserBio(user: snapshot.data![index]);
                        },
                      ));
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
