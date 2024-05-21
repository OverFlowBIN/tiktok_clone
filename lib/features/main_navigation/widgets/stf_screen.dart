import 'package:flutter/material.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void increase() {
    setState(() {
     _clicks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("$_clicks", style: TextStyle(fontSize: 49),), TextButton(onPressed: increase, child: Text('+'),),],
      ),
    );
  }
}
