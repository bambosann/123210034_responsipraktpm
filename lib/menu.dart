import 'package:flutter/material.dart';
import 'agentslistpage.dart';
import 'mapslistpage.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Page',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AgentsListPage()));
              },
              icon: Icon(
                Icons.person,
                size: 120, 
                color: Colors.red,
              ),
              label: Text('Agents'),
            ),
            SizedBox(height: 120),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapsListPage()));
              },
              icon: Icon(
                Icons.map,
                size: 120, 
                color: Colors.red, 
              ),
              label: Text('Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
