import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';
import 'package:getflutter/components/drawer/gf_drawer_header.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/vars/global.dart';

import 'weather.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<bool> isSelected_ = [true,false];
  int radiovalue_ = 0 ;
  String currentLocation = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
          style: TextStyle(
              color: title_color_,
              fontSize: 14)
          ,
        ),
        centerTitle: true,
        backgroundColor: background_color_,
      ),

      backgroundColor: Colors.black,

      drawer: GFDrawer(
        color: drawer_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: GFAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                size: 150,
                backgroundColor: Colors.transparent,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black,
                thickness: 0.25,
                height: 0,
                indent: 40,
                endIndent: 40,
              ),
            ),

            //Temperature
            // Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: GFListTile(
                  avatar: SvgPicture.asset(
                    'assets/svgs/thermometer.svg',
                    height: 30,
                    alignment: Alignment.center,
                  ),
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "°C",
                              style: TextStyle(
                                  fontSize: 25
                              ),
                            ),
                            Radio(
                              value: 0,
                              onChanged: handleRadioChange,
                              groupValue: radiovalue_,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "°F",
                              style: TextStyle(
                                  fontSize: 25
                              ),
                            ),
                            Radio(
                              value: 1,
                              onChanged: handleRadioChange,
                              groupValue: radiovalue_,
                            )
                          ],
                        ),
                      ),

                    ],
                  )
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                elevation: 5,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                child: Card(
                  child: GFListTile(
                      avatar: Icon(Icons.gps_fixed),
                      title: Text(currentLocation),
                    subTitle: Text(
                      'Click to change'
                    ),
                  ),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 5,
                ),
                onTap: getLoc,
              ),
            ),

          ],
        ),
        elevation: 30,
      ),

      body: Weather(),

    );
  }

  void handleRadioChange(int value) {
    setState(() {
      radiovalue_=value;
    });
  }

  void getLoc() async{
    final Map<String,dynamic> temp  =  await getCurrentLocation();
    debugPrint(temp.toString());
    setState(() {
      currentLocation = temp['loc'].locality;
    });
    final Map<String,dynamic> resp = await getData(temp['position'].latitude, temp['position'].longitude);
    debugPrint(resp['current'].toString());
    debugPrint(resp['lat'].toString()+'--------'+resp['lon'].toString());
  }
}
