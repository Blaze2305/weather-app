import 'package:flutter/material.dart';

import 'ui/home.dart';

void main(){
  runApp(MaterialApp(
    title: "Weather App",
    initialRoute: '/',
    routes: {
      '/':(_)=>Home(),
    })
  );
}



