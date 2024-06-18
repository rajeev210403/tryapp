import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPage extends StatefulWidget {
  final String jsonFilePath;

  InputPage({required this.jsonFilePath});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  List<dynamic> fields = [];
  bool isLoading = true;
  String pageTitle = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      String jsonString = await rootBundle.loadString(widget.jsonFilePath);
      Map<String, dynamic> jsonData = json.decode(jsonString);

      if (jsonData.isNotEmpty) {
        setState(() {
          pageTitle = jsonData.keys.first;
          fields = jsonData[pageTitle];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // Handle empty JSON data case
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to load data from JSON file.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Error loading data: $e");
      setState(() {
        isLoading = false;
      });
      // Handle error loading JSON data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load data: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget buildInputField(Map<String, dynamic> field) {
    Widget inputWidget;

    switch (field['type']) {
      case 'Text':
        inputWidget = buildTextField(field);
        break;
      case 'Email':
        inputWidget = buildTextField(field, keyboardType: TextInputType.emailAddress);
        break;
      case 'Dropdown':
        inputWidget = buildDropdownField(field);
        break;
      case 'LargeText':
        inputWidget = buildLargeTextField(field);
        break;
      default:
        inputWidget = buildTextField(field);
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
          inputWidget,
        ],
      ),
    );
  }

  Widget buildTextField(Map<String, dynamic> field, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: field['label'],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }

  Widget buildDropdownField(Map<String, dynamic> field) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField<String>(
        value: null, // Set initial value or null if no initial value
        onChanged: (String? value) {
          // Handle dropdown value change
        },
        decoration: InputDecoration(
          labelText: field['label'],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        items: (field['values'] as List<dynamic>).map<DropdownMenuItem<String>>(
              (dynamic value) {
            return DropdownMenuItem<String>(
              value: value.toString(),
              child: Text(value.toString()),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buildLargeTextField(Map<String, dynamic> field) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        maxLines: 5, // Adjust the number of lines as needed
        decoration: InputDecoration(
          labelText: field['label'],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[100],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
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
          : fields.isEmpty
          ? Center(child: Text('No fields found'))
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

