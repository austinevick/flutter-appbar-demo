import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Students> students = [
    Students(name: 'Lagos', location: 'Ikeja'),
    Students(name: 'FCT', location: 'Abuja'),
    Students(name: 'Kaduna', location: 'Kaduna'),
    Students(name: 'Akwa Ibom', location: 'Uyo'),
    Students(name: 'Enugu', location: 'Enugu'),
    Students(name: 'Oyo', location: 'Ibadan'),
    Students(name: 'Lagos', location: 'Ikeja'),
    Students(name: 'FCT', location: 'Abuja'),
    Students(name: 'Kaduna', location: 'Kaduna'),
  ];
  var isSelected = false;
  defaultAppBar() => AppBar(
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
      );

  selectedAppbar() => AppBar(
      backgroundColor: Colors.purple,
      actions: [
        selecteditem() > 1
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
      leading: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            isSelected = false;
            students.indexWhere((element) => element.isSelected = false);
          });
        },
      ),
      title: Text('${selecteditem()}'));

  selecteditem() {
    return students
        .where((element) => element.isSelected = element.isSelected)
        .toList()
        .length;
  }

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    handleScroll();
    super.initState();
  }

  bool isScrolled = false;

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() => isScrolled = true);
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() => isScrolled = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSelected ? selectedAppbar() : defaultAppBar(),
      body: AnimatedSwitcher(
          transitionBuilder: (widget, animation) => ScaleTransition(
                scale: animation,
                child: widget,
              ),
          duration: Duration(seconds: 1),
          child: students.isEmpty
              ? Container(
                  color: Colors.purple,
                  child: Center(child: Text('Names of states\nappear here')),
                )
              : Center(
                  child: ListView(
                    controller: scrollController,
                    children: List.generate(
                      students.length,
                      (index) => Center(
                          child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                            color: students[index].isSelected
                                ? Colors.green
                                : Colors.white,
                            child: ListTile(
                                subtitle: Text(
                                  students[index].location,
                                  style: TextStyle(
                                    color: students[index].isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: students[index].isSelected
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(
                                              () => students.removeAt(index));
                                          if (students.isEmpty) {
                                            setState(() => isSelected = false);
                                          }
                                        },
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    if (selecteditem() > 0) {
                                      students[index].isSelected =
                                          !students[index].isSelected;
                                    }
                                  });
                                  if (selecteditem() < 1) {
                                    setState(() {
                                      isSelected = false;
                                    });
                                  }
                                },
                                onLongPress: () {
                                  setState(() {
                                    students[index].isSelected = true;
                                    isSelected = true;
                                  });
                                },
                                leading: students[index].isSelected
                                    ? CircleAvatar(
                                        child: Icon(Icons.check),
                                      )
                                    : CircleAvatar(
                                        child: Text(students[index]
                                            .name
                                            .substring(0, 1)),
                                      ),
                                title: Text(
                                  students[index].name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: students[index].isSelected
                                          ? Colors.white
                                          : Colors.black),
                                ))),
                      )),
                    ),
                  ),
                )),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: isScrolled
            ? FloatingActionButton.extended(
                onPressed: () {}, label: Text('Add State'))
            : FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
      ),
    );
  }
}

class Students {
  String name;
  String location;
  bool isSelected;
  Students({this.location, this.isSelected = false, this.name});
}
