import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Biodata',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
      ),
      home: const MyHomePage(title: 'My Biodata'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool showName = true; // Set default to true
  bool showNPM = true; // Set default to true
  bool showBio = true; // Set default to true

  bool clickedWidget1 = false;
  bool clickedWidget2 = false;
  bool clickedWidget3 = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showWidget(String widgetName) {
    setState(() {
      if (widgetName == 'Widget 1') {
        clickedWidget1 = !clickedWidget1;
        showName = clickedWidget1;
      } else if (widgetName == 'Widget 2') {
        clickedWidget2 = !clickedWidget2;
        showNPM = clickedWidget2;
      } else if (widgetName == 'Widget 3') {
        clickedWidget3 = !clickedWidget3;
        showBio = clickedWidget3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Bagian Biodata
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (showName)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Nama:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Eci Astria',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                if (showNPM)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'NPM:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '22554010004',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                if (showBio)
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Bio:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Saya suka mendengarkan musik dan bermain game',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Tiga Widget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showWidget('Widget 1');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  color: clickedWidget1 ? Colors.blue : Colors.grey,
                  child: Text(
                    'NAMA',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showWidget('Widget 2');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  color: clickedWidget2 ? Colors.green : Colors.grey,
                  child: Text(
                    'NPM',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showWidget('Widget 3');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  color: clickedWidget3 ? Colors.orange : Colors.grey,
                  child: Text(
                    'BIO',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
