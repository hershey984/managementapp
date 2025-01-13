
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _submitForm() {
    if(_formkey.currentState!.validate()){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login Page')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please enter a username';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please enter a Email';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact', border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please enter a Contact';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: _submitForm,
               child: Text('Submit')
              ),
              
            ],
          )
        ),
      )
    );
  }
}
