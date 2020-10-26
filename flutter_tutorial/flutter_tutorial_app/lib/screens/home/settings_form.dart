import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/models/user.dart';
import 'package:flutter_tutorial_app/services/database.dart';
import 'package:flutter_tutorial_app/shared/constants.dart';
import 'package:flutter_tutorial_app/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male', 'Female', 'Others'];

  String _currentName;
  String _currentGender;
  int _currentLevel;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentGender ?? userData.gender,
                      items: genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text('$gender'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentGender = val),
                    ),
                    SizedBox(height: 20.0),
                    Slider(
                        value: (_currentLevel ?? userData.level).toDouble(),
                        activeColor:
                            Colors.brown[_currentLevel ?? userData.level],
                        inactiveColor:
                            Colors.brown[_currentLevel ?? userData.level],
                        min: 100,
                        max: 900,
                        divisions: 8,
                        onChanged: (val) =>
                            setState(() => _currentLevel = val.round())),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: userData.uid)
                                .updateUserData(
                                    _currentName ?? userData.name,
                                    _currentGender ?? userData.gender,
                                    _currentLevel ?? userData.level);
                            Navigator.pop(context);
                          }
                        })
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
