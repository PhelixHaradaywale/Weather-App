import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main () => runApp(
    MaterialApp(
      title: "Weather App",
      home: Home(),
    )
);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather () async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Lagos&units=imperial&appid=99ebdc8e51f55a3dbdf72719e1a274d4"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }
  @override
  void initState () {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.search), onPressed: () {  },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurpleAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Nigeria",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                )
              ],
            ),

          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf, color: Colors.purple,),
                      title: Text("Temperature"),
                      trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading",),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud, color: Colors.pinkAccent),
                      title: Text("Weather"),
                      trailing: Text(description != null ? description.toString() : "Loading",),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun, color: Colors.amberAccent),
                      title: Text("Humidity"),
                      trailing: Text(humidity != null ? humidity.toString(): "Loading",),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind, color: Colors.lightGreen),
                      title: Text("Wind Speed"),
                      trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading",),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}