import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget{
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Schedule'),
        centerTitle: true,
        backgroundColor: Colors.green,
    ),
  );
}