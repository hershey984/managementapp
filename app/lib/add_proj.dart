import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewProjectPage extends StatefulWidget {
  const NewProjectPage({super.key});

  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _status = 'upcoming'; 

  Future<void> _addProject() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || userId.isEmpty) {
      print('Error: User ID is null or empty.');
      return;
    }

    if (_projectNameController.text.isEmpty ||
        _startDateController.text.isEmpty ||
        _endDateController.text.isEmpty) {
      print('Error: Project fields cannot be empty.');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('projects')
          .add({
            'projectName': _projectNameController.text,
            'startDate': _startDateController.text,
            'endDate': _endDateController.text,
            'status': _status,
          });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Project added successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      print("Error adding project: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Project'),
        backgroundColor: Color.fromRGBO(61, 51, 13, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _projectNameController,
                decoration: InputDecoration(labelText: 'Project Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the project name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: 'Project Status'),
                items: [
                  DropdownMenuItem(child: Text('Upcoming'), value: 'upcoming'),
                  DropdownMenuItem(child: Text('Ongoing'), value: 'ongoing'),
                  DropdownMenuItem(child: Text('Completed'), value: 'completed'),
                ],
                onChanged: (newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProject,
                child: Text('Add Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
