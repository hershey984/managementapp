import 'package:app/add_proj.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Home Page'),
      backgroundColor: Color.fromRGBO(61, 51, 13, 1),
      foregroundColor: Colors.white,
      toolbarHeight: 120,
    ),
    
    body: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          color: Color.fromARGB(141, 250, 240, 230),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: (){
              }, child: Text(
                'Active Projects'
              ))
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          color: Color.fromARGB(141, 250, 240, 230),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: (){
              }, child: Text(
                'Upcoming Projects'
              ))
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              // Navigate to the form where users can add a new project
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
