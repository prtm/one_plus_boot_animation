import 'package:flutter/material.dart';
import 'package:oneplus_animation/logo.dart';
import 'package:oneplus_animation/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Plus Demo',
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'One Plus Animation Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool animationStarted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: OnePlusLogo(),
      ),
    );
  }
}
