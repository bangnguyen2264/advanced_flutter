import 'package:clean_architecture/data/my_app.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState(){
    MyApp.instance.appState = 0;
  }

  void getAppState(){
    print(MyApp.instance.appState);
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}