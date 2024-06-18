import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LegalScreen extends StatefulWidget {
  final String jsonFilePath;

  LegalScreen({required this.jsonFilePath});

  @override
  _LegalScreenState createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  late Future<Map<String, dynamic>> _legalData;

  @override
  void initState() {
    super.initState();
    _legalData = _loadLegalData();
  }

  Future<Map<String, dynamic>> _loadLegalData() async {
    String jsonString = await rootBundle.loadString(widget.jsonFilePath);
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: _legalData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Text(snapshot.data!['title'], style: TextStyle(color: Colors.black));
              } else {
                return Text('Error', style: TextStyle(color: Colors.black));
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green[900]),
      ),
      backgroundColor: Colors.grey[100], // Set the background color to match SettingsScreen
      body: FutureBuilder<Map<String, dynamic>>(
        future: _legalData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    if (data.containsKey('effective_date'))
                      Text('Effective date: ${data['effective_date']}', style: TextStyle(fontSize: 16, color: Colors.black)),
                    const SizedBox(height: 10),
                    ...data['sections'].map<Widget>((section) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section['heading'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              section['content'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Error loading data', style: TextStyle(color: Colors.black)));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
