import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Button Demo',
      theme: ThemeData.dark(),
      home: Demo(),
    );
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedButton(
          onPressed: () {},
          enabled: true,
          color: Colors.blue,
          shadowDegree: ShadowDegree.light,
          child: Text(
            'Lingot Button',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
