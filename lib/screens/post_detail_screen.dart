import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.postData});

  final postData;

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
            Stack(
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
                      postData["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 50,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade50,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_outline),
                    ),
                  ),
                ),
              ],
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
                          text: postData["author"],
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
                    postData["dateCreated"],
                    style: const TextStyle(color: Colors.black26, fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    postData["category"],
                    style: TextStyle(color: Colors.green.shade300, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    postData["title"],
                    style: const TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    postData["description"],
                    style: const TextStyle(color: Colors.black38, fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A common use case for normalized images that have a square shape are e. g. lists that all have a thumbnail image. Independent of the actual size of the image and its proportions, you might want to display the image as a square shape with rounded borders.',
                    style: TextStyle(color: Colors.black38, fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.read_more,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(width: 20),
                            const Text('Read More'),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              'Get Premium',
                              style: TextStyle(color: Colors.green.shade600, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20),
                            const Icon(
                              Icons.close,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
