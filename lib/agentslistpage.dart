import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'agentsdetailpage.dart';

class AgentsListPage extends StatefulWidget {
  @override
  _AgentsListPageState createState() => _AgentsListPageState();
}

class _AgentsListPageState extends State<AgentsListPage> {
  List agents = [];

  @override
  void initState() {
    super.initState();
    fetchAgents();
  }

  fetchAgents() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        agents = data['data'];
      });
    } else {
      throw Exception('Failed to load agents');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agents')),
      body: agents.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: agents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(agents[index]['displayName']),

                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(agents[index]['displayIcon']),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailAgentPage(uuid: agents[index]['uuid']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
