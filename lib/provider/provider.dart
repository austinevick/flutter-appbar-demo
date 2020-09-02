import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_appbar_demo/model/student.dart';

class AppProvider with ChangeNotifier {
  List<Students> _students = [
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
  UnmodifiableListView get students => UnmodifiableListView(_students);

  selecteditem() {
    return students
        .where((element) => element.isSelected = element.isSelected)
        .toList()
        .length;
  }
}
