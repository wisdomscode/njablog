import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:njablog2/widgets/text_widget.dart';

class BlogCardWidget extends StatelessWidget {
  const BlogCardWidget({
    Key? key,
    required this.image,
    required this.author,
    required this.dateCreated,
    required this.title,
    required this.likes,
    required this.comments,
    required this.category,
    this.color,
  }) : super(key: key);

  final String image;
  final String author;
  final String dateCreated;
  final String title;
  final int likes;
  final int comments;
  final String category;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 120,
                    margin: const EdgeInsets.only(
                      left: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    // child: Text('Roger'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          MyTextWidget(
                            text: author,
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                          Row(
                            children: [
                              MyTextWidget(
                                text: category,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                              Spacer(),
                              MyTextWidget(
                                text: dateCreated,
                                fontWeight: FontWeight.bold,
                                size: 12,
                              ),
                            ],
                          ),
                          MyTextWidget(
                            text: title,
                            fontWeight: FontWeight.bold,
                            size: 16,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  MyTextWidget(
                                    text: '${likes}k',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.thumb_up,
                                      color: Colors.green.shade700,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                              // const SizedBox(width: 20),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.insert_comment,
                                      color: Colors.green.shade700,
                                      size: 18,
                                    ),
                                  ),
                                  MyTextWidget(
                                    text: '${comments}k',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
