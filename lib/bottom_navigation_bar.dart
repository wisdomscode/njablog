import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:njablog2/screens/api_posts_screen.dart';
import 'package:njablog2/screens/home_screen.dart';
import 'package:njablog2/screens/users_screen.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
// 2. Declear the pageIndex as 0 and other pages as an array
// In the HomePage class declares an int variable as pageIndex initialize it to 0.
//Every time, we open the app we start at the first page.

  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const ApiPostsScreen(),
    const UsersScreen(),
    const Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[pageIndex],
      ),
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.green.shade700,
        animationDuration: const Duration(milliseconds: 300),
        height: 50,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.newspaper, size: 30, color: Colors.white),
          Icon(Icons.people, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() => pageIndex = index);
        },
      ),
    );
  }
}
