import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:njablog2/models/post_model.dart';
import 'package:njablog2/screens/api_post_detail.dart';

class ApiPostsScreen extends StatefulWidget {
  const ApiPostsScreen({super.key});

  @override
  State<ApiPostsScreen> createState() => _ApiPostsScreenState();
}

class _ApiPostsScreenState extends State<ApiPostsScreen> {
  Future getAPIPosts() async {
    String url = "https://jsonplaceholder.typicode.com/posts";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    List<Post> posts = [];

    for (var p in jsonData) {
      Post post = Post(p['userId'], p['id'], p['title'], p['body']);

      posts.add(post);
    }

    // print('################## USERS ##############');
    // print(posts.length);

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAPIPosts(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Post post = snapshot.data[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ApiPostDetailScreen(
                            postInfo: post,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(post.title[0]),
                          ),
                          title: Text("${post.id}, ${post.title}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.body),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
