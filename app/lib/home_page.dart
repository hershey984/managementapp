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
    // Getting the current user from Firebase Auth
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        // user is not reg this show a prompt to sign in
        body: Center(child: Text('Please sign in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color.fromRGBO(61, 51, 13, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(141, 250, 240, 230),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'data',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.email ?? 'No Email',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15),
              color: Color.fromARGB(141, 250, 240, 230),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Welcome User',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(61, 51, 13, 1),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Navigation cards
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('Upcoming Projects'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpcomingProjectsScreen(userId: user.uid),
                    ),
                  );
                },
                tileColor: Color.fromARGB(141, 250, 240, 230),
                leading: Icon(Icons.schedule, color: Color.fromRGBO(61, 51, 13, 1)),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('Request Resources for Project'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectRequestPage()),
                  );
                },
                tileColor: Color.fromARGB(141, 250, 240, 230),
                leading: Icon(Icons.add, color: Color.fromRGBO(61, 51, 13, 1)),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('Ongoing Projects'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OngoingProjectsScreen(userId: user.uid),
                    ),
                  );
                },
                tileColor: Color.fromARGB(141, 250, 240, 230),
                leading: Icon(Icons.work, color: Color.fromRGBO(61, 51, 13, 1)),
              ),
            ),
            SizedBox(height: 30),

            // Add new project button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewProjectPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Color.fromRGBO(61, 51, 13, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Add New Project',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
