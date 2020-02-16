import 'package:flutter/cupertino.dart';

class Lesson {
  String _name;
  double _letterValue;
  int _credit;
  Color color;

  String get name => _name;

  set name(String value) => _name = value;

  double get letterValue => _letterValue;

  set letterValue(double value) => _letterValue = value;

  int get credit => _credit;

  set credit(int value) => _credit = value;

  Lesson(this._name, this._letterValue, this._credit, this.color);
}
