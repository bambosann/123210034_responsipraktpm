import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailAgentPage extends StatefulWidget {
  final String uuid;

  DetailAgentPage({required this.uuid});

  @override
  _DetailAgentPageState createState() => _DetailAgentPageState();
}

class _DetailAgentPageState extends State<DetailAgentPage> {
  Map agent = {};

  @override
  void initState() {
    super.initState();
    fetchAgentDetail();
  }

  fetchAgentDetail() async {
  final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents/${widget.uuid}'));
  if (response.statusCode == 200) {
    setState(() {
      agent = json.decode(response.body)['data'];
    });
  } else {
    throw Exception('Failed to load agent detail');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Agent Page'),
      ),
      body: agent.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${agent['displayName']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  if (agent.containsKey('displayIcon'))
                    Image.network(
                      agent['displayIcon'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 10),
                  Text('Description: ${agent['description']}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Role: ${agent['role']['displayName']}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Abilities:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ...agent['abilities'].map<Widget>((ability) {
                    return ListTile(
                      title: Text(ability['displayName']),
                      subtitle: Text(ability['description']),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}