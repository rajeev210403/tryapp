import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Map<String, dynamic>? jsonData;
  List<dynamic> fields = [];
  bool isLoading = true;
  String pageTitle = '';

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('assets/jsonfiles/adding_a_grower.json');
      final data = json.decode(response) as Map<String, dynamic>;
      setState(() {
        jsonData = data;
        if (data.isNotEmpty) {
          pageTitle = data.keys.first;
          fields = data[pageTitle];
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error loading JSON data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildInputField(Map<String, dynamic> field) {
    TextInputType inputType;
    switch (field['type']) {
      case 'Text':
        inputType = TextInputType.text;
        break;
      case 'Email':
        inputType = TextInputType.emailAddress;
        break;
      case 'Number':
        inputType = TextInputType.number;
        break;
      default:
        inputType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field['fieldname'],
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              keyboardType: inputType,
              decoration: InputDecoration(
                labelText: field['label'],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjusted height for app bar
        child: AppBar(
          backgroundColor: Colors.grey[100],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Handle back action
                },
              ),
              Expanded(
                child: Text(
                  pageTitle.isNotEmpty ? pageTitle : 'Loading...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), // Increased font size
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  // Handle close action
                },
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : jsonData == null
          ? Center(child: Text('Failed to load data'))
          : Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: fields.length,
              itemBuilder: (context, index) {
                return buildInputField(fields[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[100],
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit action
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: InputPage(),
));
