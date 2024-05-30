import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'mapsdetailpage.dart';

class MapsListPage extends StatefulWidget {
  @override
  _MapsListPageState createState() => _MapsListPageState();
}

class _MapsListPageState extends State<MapsListPage> {
  List maps = [];

  @override
  void initState() {
    super.initState();
    fetchMaps();
  }

  fetchMaps() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/maps'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        maps = data['data'];
      });
    } else {
      throw Exception('Failed to load maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Maps')),
      body: maps.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.6, 
                mainAxisSpacing: 30.0,  
                crossAxisSpacing: 30.0, 
              ),
              itemCount: maps.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapDetailPage(mapUuid: maps[index]['uuid']),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 50.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          maps[index]['splash'],
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 30),
                        Text(
                          maps[index]['displayName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
