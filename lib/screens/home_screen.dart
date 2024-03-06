import 'package:flutter/material.dart';
import 'package:njablog2/models/dommy_post.dart';
import 'package:njablog2/widgets/blog_card_widget.dart';
import 'package:njablog2/widgets/text_widget.dart';

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

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];
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
          child: Column(
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => PostDetailPage(post: post),
                        //   ),
                        // );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
