import 'dart:math';

import 'package:flutter/material.dart';
import './model/Lesson.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "App",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: CalculatePoint());
  }
}

class CalculatePoint extends StatefulWidget {
  @override
  _CalculatePointState createState() => _CalculatePointState();
}

class _CalculatePointState extends State<CalculatePoint> {
  double _average = 0.0;
  String _lessonName;
  static int _counter = 0;
  int _lessonCredit = 1;
  double _lessonValue = 4; // AA = 4 , BA = 3.50
  List<Lesson> _allLesson = [];
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
      ),
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
        centerTitle: true,
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return _allField(orientation);
      }),
    );
  }

  Widget _allField(var orientation) {
    return Container(
      child: Column(
        children: <Widget>[
          // orientation == Orientation.portrait
          //     ? (_staticField(orientation))
          //     : _portraitField(),
          _staticField(orientation),
          _dynamicField(),
          //_dynamicField(),
        ],
      ),
    );
  }

  Widget _portraitField() {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidate: false,
                      validator: (_value) {
                        if (_value.length > 0) {
                          return null;
                        } else {
                          return "Ders Adı Boş Olamaz!";
                        }
                      },
                      onSaved: (_value) {
                        _lessonName = _value;
                        setState(() {
                          _allLesson.add(Lesson(_lessonName, _lessonValue,
                              _lessonCredit, generateRandomColor()));
                          _average = 0;
                          _calculateAverage();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Ders adı giriniz!",
                        labelText: "Ders Adı",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 5)),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: _lessonCreditItem(),
                              value: _lessonCredit,
                              onChanged: (_value) {
                                setState(() {
                                  _lessonCredit = _value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<double>(
                              items: _lessonLetterValues(),
                              onChanged: (_value) {
                                setState(() {
                                  _lessonValue = _value;
                                });
                              },
                              value: _lessonValue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(width: 2, color: Colors.purple),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Ortalama: ",
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        TextSpan(
                          text: _allLesson.length == 0
                              ? "Ders eklenmedi"
                              : "${_average.toStringAsFixed(3)}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ]),
                      // style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ],
              )),
        ),
        Expanded(
          child: Text("Merhaba"),
        ),
      ],
    ));
  }

  Widget _staticField(var orientation) {
    return Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidate: false,
                validator: (_value) {
                  if (_value.length > 0) {
                    return null;
                  } else {
                    return "Ders Adı Boş Olamaz!";
                  }
                },
                onSaved: (_value) {
                  _lessonName = _value;
                  setState(() {
                    _allLesson.add(Lesson(_lessonName, _lessonValue,
                        _lessonCredit, generateRandomColor()));
                    _average = 0;
                    _calculateAverage();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Ders adı giriniz!",
                  labelText: "Ders Adı",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        items: _lessonCreditItem(),
                        value: _lessonCredit,
                        onChanged: (_value) {
                          setState(() {
                            _lessonCredit = _value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<double>(
                        items: _lessonLetterValues(),
                        onChanged: (_value) {
                          setState(() {
                            _lessonValue = _value;
                          });
                        },
                        value: _lessonValue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 80),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(width: 2, color: Colors.purple),
                ),
              ),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: "Ortalama: ",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  TextSpan(
                    text: _allLesson.length == 0
                        ? "Ders eklenmedi"
                        : "${_average.toStringAsFixed(3)}",
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ]),
                // style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            // _dynamicField(),
          ],
        ));
  }

  _calculateAverage() {
    double _sumPoint = 0;
    double _sumCredit = 0;

    for (var lesson in _allLesson) {
      var credit = lesson.credit;
      var value = lesson.letterValue;
      _sumPoint = _sumPoint + (value * credit);
      _sumCredit += credit;
    }
    _average = _sumPoint / _sumCredit;
  }

  List<DropdownMenuItem<double>> _lessonLetterValues() {
    List<DropdownMenuItem<double>> _values = [];
    _values.add(
      DropdownMenuItem(
        child: Text(
          "AA",
          style: TextStyle(fontSize: 30),
        ),
        value: 4,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "BA",
          style: TextStyle(fontSize: 30),
        ),
        value: 3.5,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "BB",
          style: TextStyle(fontSize: 30),
        ),
        value: 3,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "CB",
          style: TextStyle(fontSize: 30),
        ),
        value: 2.5,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "CC",
          style: TextStyle(fontSize: 30),
        ),
        value: 2,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "DC",
          style: TextStyle(fontSize: 30),
        ),
        value: 1.5,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "DD",
          style: TextStyle(fontSize: 30),
        ),
        value: 1,
      ),
    );
    _values.add(
      DropdownMenuItem(
        child: Text(
          "FF",
          style: TextStyle(fontSize: 30),
        ),
        value: 0,
      ),
    );

    return _values;
  }

  List<DropdownMenuItem<int>> _lessonCreditItem() {
    List<DropdownMenuItem<int>> _credits = [];
    for (int i = 1; i <= 10; i++) {
      _credits.add(DropdownMenuItem(
        value: i,
        child: Text(
          "$i credit",
          style: TextStyle(fontSize: 30),
        ),
      ));
    }

    return _credits;
  }

  Widget _dynamicField() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: _createList,
        itemCount: _allLesson.length,
      ),
    );
  }

  Widget _createList(BuildContext context, int index) {
    _counter++;
    // Color randomColor = generateRandomColor();
    debugPrint(_counter.toString());
    return Dismissible(
      key: Key("$_counter"),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          _allLesson.removeAt(index);
          _calculateAverage();
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: _allLesson[index].color, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.done, size: 36, color: _allLesson[index].color),
            trailing: Icon(
              Icons.delete,
              color: _allLesson[index].color,
            ),
            title: Text(_allLesson[index].name),
            subtitle: Text(_allLesson[index].credit.toString() +
                " kredi " +
                _allLesson[index].letterValue.toString() +
                " ders not değeri "),
          ),
        ),
      ),
    );
  }

  Color generateRandomColor() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}
