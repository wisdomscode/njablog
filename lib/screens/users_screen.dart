import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:njablog2/models/user_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Future getAllUsers() async {
    String url = "https://jsonplaceholder.typicode.com/users";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u['name'], u['email'], u['username'], u['address']['city']);

      users.add(user);
    }

    print('################## USERS ##############');
    print(users.length);

    return users;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: FutureBuilder(
          future: getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  User user = snapshot.data[index];

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(user.name[0]),
                    ),
                    title: Text(user.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.username),
                        Text(user.email),
                      ],
                    ),
                    trailing: Text(user.city),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
