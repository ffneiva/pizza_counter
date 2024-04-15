import 'package:flutter/material.dart';

class PizzaCounterController with ChangeNotifier {
  static final PizzaCounterController _instance =
      PizzaCounterController._internal();

  factory PizzaCounterController() => _instance;

  PizzaCounterController._internal();

  late int _personCounter;
  late int? _lastPerson;
  late List<int> _groupCounter;
  late List<String> _groupName;

  int get personCounter => _personCounter;
  int? get lastPerson => _lastPerson;
  List<int> get groupCounter => _groupCounter;
  List<String> get groupName => _groupName;

  Future<void> loadPizzaCounter() async {
    _personCounter = 0;
    _lastPerson = null;
    _groupCounter = [];
    _groupName = [];

    notifyListeners();
  }

  void addPerson(String name) {
    if (!_groupName.contains(name)) {
      _groupName.add(name);
      _groupCounter.add(0);
    }
  }

  void editPerson(int index, String name) {
    if (index >= 0 && index < _groupCounter.length) {
      _groupName[index] = name;
    }
  }

  void removePerson(int index) {
    if (index >= 0 && index < _groupCounter.length) {
      _groupCounter.removeAt(index);
      _groupName.removeAt(index);
    }
  }

  void personAddCounter() {
    _personCounter++;
    notifyListeners();
  }

  void personRemoveCounter() {
    if (_personCounter > 0) {
      _personCounter--;
    }
    notifyListeners();
  }

  void personClearCounter() {
    _personCounter = 0;
    notifyListeners();
  }

  void groupAddCounter(int index) {
    if (index >= 0 && index < _groupCounter.length) {
      _groupCounter[index]++;
      _lastPerson = index;
    }
    notifyListeners();
  }

  void groupRemoveCounter(int index) {
    if (_groupCounter[index] > 0) {
      _groupCounter[index]--;
    }
    notifyListeners();
  }

  void groupRemoveLastCounter() {
    if (_lastPerson != null) {
      if (_groupCounter[_lastPerson!] > 0) {
        _groupCounter[_lastPerson!]--;
        _lastPerson = null;
      }
    }
    notifyListeners();
  }

  void groupClearCounter(int index) {
    _groupCounter[index] = 0;
    notifyListeners();
  }

  void groupClearAllCounter() {
    for (int i = 0; i < _groupCounter.length; i++) {
      _groupCounter[i] = 0;
    }
    notifyListeners();
  }
}
