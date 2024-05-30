import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapDetailPage extends StatefulWidget {
  final String mapUuid;

  MapDetailPage({required this.mapUuid});

  @override
  _MapDetailPageState createState() => _MapDetailPageState();
}

class _MapDetailPageState extends State<MapDetailPage> {
  Map mapDetail = {};

  @override
  void initState() {
    super.initState();
    fetchMapDetail();
  }

  fetchMapDetail() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/maps/${widget.mapUuid}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mapDetail = data['data'];
      });
    } else {
      throw Exception('Failed to load map detail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mapDetail['displayName'] ?? 'Loading...')),
      body: mapDetail.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mapDetail['splash'] != null
                      ? Image.network(
                          mapDetail['splash'],
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )
                      : Placeholder(
                          fallbackHeight: 200,
                          color: Colors.grey,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      mapDetail['displayName'],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      mapDetail['description'] ?? 'No description available',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
