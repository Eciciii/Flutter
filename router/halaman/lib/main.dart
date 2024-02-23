import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Router Example',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman detail saat tombol ditekan
            Navigator.pushNamed(context, '/detail');
          },
          child: Text('Go to Detail Page'),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Kembali ke halaman beranda saat tombol ditekan
            Navigator.pop(context);
          },
          child: Text('Go back to Home Page'),
        ),
      ),
    );
  }
}
