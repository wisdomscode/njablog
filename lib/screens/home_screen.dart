import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:njablog2/models/dommy_post.dart';
import 'package:njablog2/screens/post_detail_screen.dart';
import 'package:njablog2/widgets/blog_card_widget.dart';
import 'package:njablog2/widgets/text_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void handleClick(int item) {
    switch (item) {
      case 0:
        print('profile');
        break;
      case 1:
        print('Setting');

        break;
      case 2:
        print('Logout');

        break;
    }
  }

  List<String> categories = [
    'All',
    'Sports',
    'Politics',
    'Entertainment',
    'Business',
    'Fashion',
    'Life Style',
  ];

  late String selectedCategory;

  Future<List> fetchBlogPost() async {
    List allBlogPosts = [];

    // var url = "http://localhost:8000/blogposts/";
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(
      Uri.parse(url),
      // headers: {
      //   "Access-Control-Allow-Origin": "*",
      //   'Content-Type': 'application/json',
      //   'Accept': '*/*',
      // },
    );

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      // print(resBody);

      setState(() {
        allBlogPosts = resBody;
      });
    } else {
      throw Exception('Failed to load posts');
    }
    print('############### 200 #################');

    print(allBlogPosts);
    return allBlogPosts;
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];

    fetchBlogPost();
  }

  @override
  Widget build(BuildContext context) {
    final customBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green.shade100,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(30),
    );
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(backgroundColor: Colors.transparent, actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/profile2.jpg'),
              radius: 28,
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Profile')),
              const PopupMenuItem<int>(value: 1, child: Text('Settings')),
              const PopupMenuItem<int>(value: 2, child: Text('Logout')),
            ],
          ),
        ]),
        drawer: Drawer(
          backgroundColor: Colors.green.shade50,
          child: const Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20, bottom: 10.0, right: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: AssetImage('assets/images/profile2.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wisdom George'),
                        Text('wisdom@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Breaking News'),
                subtitle: Text('20'),
              ),
              ListTile(
                title: Text('Breaking News'),
                subtitle: Text('20'),
              ),
              ListTile(
                title: Text('Breaking News'),
                subtitle: Text('20'),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: MyTextWidget(
                  text: 'Nja Blogs',
                  color: Colors.green.shade700,
                  size: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.green.shade300,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 18.0),
                      child: Icon(Icons.tune),
                    ),
                    suffixIconColor: Colors.green.shade300,
                    focusedBorder: customBorder,
                    enabledBorder: customBorder,
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // categories
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedCategory == category ? Colors.green.shade700 : Colors.green.shade50,
                          label: Text(
                            category,
                            style: TextStyle(color: selectedCategory == category ? Colors.white : Colors.green.shade700),
                          ),
                          labelStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(color: selectedCategory == category ? Colors.green.shade700 : Colors.green.shade50),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),

              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> post = posts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(postData: post),
                          ),
                        );
                      },
                      child: BlogCardWidget(
                        author: post['author'],
                        image: post['image'],
                        title: post['title'],
                        dateCreated: post['dateCreated'],
                        likes: post['likes'],
                        comments: post['comments'],
                        category: post['category'],
                        color: Colors.green.shade600,
                      ),
                    );
                  },
                ),
              ),

              // FutureBuilder(
              //   future: fetchBlogPost(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator();
              //     } else if (snapshot.hasData) {
              //       return Expanded(
              //         child: ListView.builder(
              //           itemCount: snapshot.data!.length,
              //           itemBuilder: (context, index) {
              //             final post = snapshot.data![index];

              //             return GestureDetector(
              //               onTap: () {
              //                 // Navigator.of(context).push(
              //                 //   MaterialPageRoute(
              //                 //     builder: (context) => PostDetailPage(post: post),
              //                 //   ),
              //                 // );
              //               },
              //               child: BlogCardWidget(
              //                 author: "post['author']",
              //                 image: "post['image']",
              //                 title: post['title'],
              //                 dateCreated: "post['dateCreated']",
              //                 likes: 2,
              //                 comments: 3,
              //                 category: "Sports",
              //                 color: Colors.green.shade600,
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     } else {
              //       return const Text("No data available");
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
