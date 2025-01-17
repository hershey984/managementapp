import 'package:app/Ongoingproj.dart';
import 'package:app/UpcomingProjectsPage.dart';
import 'package:app/add_proj.dart';
import 'package:app/projreq.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(child: Text('Please sign in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color.fromRGBO(61, 51, 13, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            color: Color.fromARGB(141, 250, 240, 230),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpcomingProjectsScreen(userId: user.uid),
                      ),
                    );
                  },
                  child: Text('Upcoming Projects'),
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(141, 250, 240, 230),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to the Project Request Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectRequestPage()),
                    );
                  },
                  child: Text('Request Resources for Project'),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            color: Color.fromARGB(141, 250, 240, 230),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OngoingProjectsScreen(userId: user.uid),
                      ),
                    );
                  },
                  child: Text('Ongoing Projects'),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewProjectPage()),
              );
            },
            child: Text('Add New Project'),
          ),
        ],
      ),
    );
  }
}
