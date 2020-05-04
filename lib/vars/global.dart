import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

var background_color_  = Colors.black;

var title_color_ = Colors.grey[400];

var drawer_color = Colors.white70;

String getUrl(double lat, double long,){
  String Api_key = '6baf6f6088bef809a0932d0f61ff653b';
  String url = "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&appid=$Api_key";
  return url;
}

Future<Map<String,dynamic>> getData(double lat,double long) async{
  String url = getUrl(lat, long);
  final response = await http.get(url);
  if(response.statusCode == 200){
    return json.decode(response.body);
  }else{
    return {"Status":"failed"};
  }
}


Future<Map<String,dynamic>> getCurrentLocation() async {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position pos = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  List<Placemark> p = await geolocator.placemarkFromCoordinates(pos.latitude, pos.longitude);
//  print(p[0].toJson());
  return {
    'position':pos,
    'loc':p[0]
  };
}

