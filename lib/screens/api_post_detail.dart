import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:njablog2/models/comment_model.dart';
import 'package:njablog2/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiPostDetailScreen extends StatefulWidget {
  const ApiPostDetailScreen({super.key, required this.postInfo});

  final Post postInfo;

  @override
  State<ApiPostDetailScreen> createState() => _ApiPostDetailScreenState();
}

class _ApiPostDetailScreenState extends State<ApiPostDetailScreen> {
  // get all comments for this post
  Future<List<CommentModel>> getPostComments() async {
    List<CommentModel> postComments = [];

    var postId = widget.postInfo.id;

    var url = "https://jsonplaceholder.typicode.com/posts/${postId}/comments";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      for (var comment in responseBody) {
        postComments.add(CommentModel.fromJson(comment));
      }
    } else {
      throw Exception('Error occured');
    }

    // print('############     Comments #####################');
    // print(postComments.length);
    return postComments;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getPostComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.green.shade700,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        // iconTheme: IconThemeData(color: Colors.green.shade700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/meditate-blog.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Authored ',
                      style: const TextStyle(color: Colors.black26, fontSize: 16),
                      children: [
                        TextSpan(text: 'by ', style: const TextStyle(color: Colors.red)),
                        TextSpan(
                          text: 'Jacob Smith',
                          style: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '2 months ago',
                    style: const TextStyle(color: Colors.black26, fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "General",
                    style: TextStyle(color: Colors.green.shade300, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.postInfo.title,
                    style: const TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.postInfo.body,
                    style: const TextStyle(color: Colors.black38, fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 35),

                  // Comment

                  Divider(),
                  Text(
                    'Comments',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                    future: getPostComments(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              CommentModel comment = snapshot.data![index];

                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.name!,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      comment.email!,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    Text(comment.body!),
                                    Divider(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            });
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
