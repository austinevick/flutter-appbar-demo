import 'package:flutter/material.dart';
import 'package:flutter_appbar_demo/provider/provider.dart';
import 'package:flutter_appbar_demo/screens/second_screen.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              labelText: 'Search....',
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true),
        ),
      ),
      body: AnimatedSwitcher(
          transitionBuilder: (widget, animation) => ScaleTransition(
                scale: animation,
                child: widget,
              ),
          duration: Duration(seconds: 1),
          child: student.students.isEmpty
              ? Container(
                  color: Colors.purple,
                  child: Center(
                      child: Text('Names of states\nappear here',
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                )
              : Center(
                  child: ListView(
                    children: List.generate(
                      student.students.length,
                      (index) => Center(
                          child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                            color: student.students[index].isSelected
                                ? Colors.green
                                : Colors.white,
                            child: ListTile(
                                subtitle: Text(
                                  student.students[index].location,
                                  style: TextStyle(
                                    color: student.students[index].isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: student.students[index].isSelected
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() =>
                                              student.students.removeAt(index));
                                        },
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    if (student.selecteditem() > 0) {
                                      student.students[index].isSelected =
                                          !student.students[index].isSelected;
                                    }
                                  });
                                },
                                onLongPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SecondScreen(
                                            students: student.students[index],
                                          )));
                                },
                                leading: student.students[index].isSelected
                                    ? CircleAvatar(
                                        child: Icon(Icons.check),
                                      )
                                    : CircleAvatar(
                                        child: Text(student.students[index].name
                                            .substring(0, 1)),
                                      ),
                                title: Text(
                                  student.students[index].name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: student.students[index].isSelected
                                          ? Colors.white
                                          : Colors.black),
                                ))),
                      )),
                    ),
                  ),
                )),
    );
  }
}
