import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectRequestPage extends StatefulWidget {
  @override
  _ProjectRequestPageState createState() => _ProjectRequestPageState();
}

class _ProjectRequestPageState extends State<ProjectRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String? _projectType = 'upcoming'; //default value for this
  String? _selectedProject; 
  final TextEditingController _resourceController = TextEditingController();

  // List to store fetched projects
  List<String> _projects = [];

  String userId = 'KHU3gYnBZtgfSLDSeRJ6UhGFHAt1';  

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  
  Future<void> _fetchProjects() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')  // Collection of users
          .doc(userId)           // User's document ID
          .collection('projects') // Projects subcollection
          .where('status', isEqualTo: _projectType)  
          .get();

      setState(() {
        _projects = snapshot.docs.map((doc) => doc['projectName'] as String).toList();
      });
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }

  // Handlingform submission
  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
     
      print('Project Type: $_projectType');
      print('Selected Project: $_selectedProject');
      print('Requested Resources: ${_resourceController.text}');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Resource request submitted!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Resources'),
        backgroundColor: Color.fromRGBO(61, 51, 13, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _projectType,
                decoration: InputDecoration(labelText: 'Project Type'),
                onChanged: (value) {
                  setState(() {
                    _projectType = value;
                    _fetchProjects(); 
                  });
                },
                items: [
                  DropdownMenuItem(child: Text('Upcoming'), value: 'upcoming'),
                  DropdownMenuItem(child: Text('Ongoing'), value: 'ongoing'),
                ],
              ),
              SizedBox(height: 20),

             
              DropdownButtonFormField<String>(
                value: _selectedProject,
                decoration: InputDecoration(labelText: 'Select Project'),
                onChanged: (value) {
                  setState(() {
                    _selectedProject = value;
                  });
                },
                items: _projects.isNotEmpty
                    ? _projects.map((project) {
                        return DropdownMenuItem(child: Text(project), value: project);
                      }).toList()
                    : [DropdownMenuItem(child: Text('No Projects Found'), value: null)],
              ),
              SizedBox(height: 20),

            
              TextFormField(
                controller: _resourceController,
                decoration: InputDecoration(labelText: 'Resources Needed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the resources needed.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

            
              ElevatedButton(
                onPressed: _submitRequest,
                child: Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
