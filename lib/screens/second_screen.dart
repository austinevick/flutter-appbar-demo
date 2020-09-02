import 'package:flutter/material.dart';
import 'package:flutter_appbar_demo/model/student.dart';
import 'package:flutter_appbar_demo/provider/provider.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  final Students students;

  const SecondScreen({Key key, this.students}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<AppProvider>(context);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            actions: [
              FlatButton(
                onPressed: () {},
                child: Text(
                  'select all',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              student.selecteditem() > 1
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.place,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
            ],
            title: Text('${student.selecteditem()}')),
        body: Center(
            child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: ListTile(
                  subtitle: Text(
                    students.location,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  leading: CircleAvatar(
                    child: Text(students.name.substring(0, 1)),
                  ),
                  title: Text(
                    students.name,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ),
          ),
        ])));
  }
}
