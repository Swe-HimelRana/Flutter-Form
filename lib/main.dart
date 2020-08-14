import 'package:flutter/material.dart';

void main() => runApp(MyFormApp());

class MyFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Coding With Himel',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: FormScreen());
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String _name;
  int _age;
  String _email;
  String _password;
  String _confirmPassword;

//  This key should be set in from key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// Creating Name Field with validator
  _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required!';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

//  Creting age field with validator
  _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      validator: (String value) {
        int age = int.tryParse(value);

        if (age == null || age < 18) {
          return 'Your age must be 18 or more to register!';
        }
        return null;
      },
      onSaved: (String value) {
        int age = int.tryParse(value);
        _age = age;
      },
    );
  }

// Creating email field with validator
  _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String email) {
        if (!RegExp(
                r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email.trim())) {
          return 'Please input a valid email!';
        }
        return null;
      },
      onSaved: (String email) {
        _email = email;
      },
    );
  }

  _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      validator: (String password) {
        if (password.trim().length < 6) {
          return 'Password length must me 6 or more!';
        }
        return null;
      },
      onSaved: (String password) {
        _password = password.trim();
      },
      onChanged: (String value) {
        _confirmPassword = value.trim();
        print(_confirmPassword);
      },
    );
  }

  _buildConfirmPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      validator: (String password) {
        if (password.trim() != _confirmPassword) {
          return 'Confirm password not matched!';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Demo'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildEmail(),
              _buildAge(),
              _buildPassword(),
              _buildConfirmPassword(),
              SizedBox(height: 10),
              RaisedButton(
                child: Text('Register'),
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    {
                      _formKey.currentState.save(),
                      print(_name),
                      print(_email),
                      print(_password),
                      print(_age)
                    }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
