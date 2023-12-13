// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetData {
  String location;

  //constructor

  GetData(this.location) {
    location = location;
  }

  String temp = '';
  String feelslike = '';
  String desc = '';
  String windSpeed = '';
  String humidity = '';
  String visibility = '';
  String icon = '';

  Future<void> getData() async {
    try {
      var response = await http.get(Uri.parse(
          "http://api.weatherstack.com/current?access_key=9b7bf45e80cda954aad0eb8f677fb654&query=$location"));
      Map data = jsonDecode(response.body);

      Map currentTemp = (data["current"]);
      //get wind speed

      int getwindspeed = currentTemp["wind_speed"];

      //GEtting temp and humidity

      int gettemp = currentTemp["temperature"];
      int gethumidity = currentTemp["humidity"];

      // //getting des
      List getdesc = currentTemp["weather_descriptions"];
      String finaldesc = getdesc[0];
      int getfeelslike = currentTemp["feelslike"];

      //get visibility
      int getvisibility = currentTemp["visibility"];
      //get icon
      List gettticon = currentTemp["weather_icons"];
      String geticon = gettticon[0];

      Map nameeLocation = data["location"];
      String nameofLocation = nameeLocation["name"];
      //Assigning values
      temp = gettemp.toString();
      feelslike = getfeelslike.toString();
      desc = finaldesc;
      humidity = gethumidity.toString();
      windSpeed = getwindspeed.toString();
      visibility = getvisibility.toString();
      icon = geticon;
      location = nameofLocation;
    } catch (e) {
      temp = 'NA';
      feelslike = 'NA';
      desc = 'Invalid Location';
      windSpeed = 'NA';
      humidity = 'NA';
      visibility = 'NA';
      location = 'Na';
    }
  }
}
