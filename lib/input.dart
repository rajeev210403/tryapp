import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final List<TextEditingController> _controllers = List.generate(10, (_) => TextEditingController());
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_checkIfAllFieldsAreFilled);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_checkIfAllFieldsAreFilled);
      controller.dispose();
    }
    super.dispose();
  }

  void _checkIfAllFieldsAreFilled() {
    bool allFilled = _controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      _isButtonEnabled = allFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200], // Set background color of the screen
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              // Top Segment
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconButton(Icons.arrow_back, () {
                      // Implement back functionality
                    }),
                    Text(
                      'Title Heading',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    _iconButton(Icons.close, () {
                      // Implement close functionality
                    }),
                  ],
                ),
              ),
              // Middle Segment (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: List.generate(10, (index) => _inputField('Field $index', _controllers[index])),
                    ),
                  ),
                ),
              ),
              // Bottom Segment
              Container(
                width: double.infinity,
                color: Colors.grey[200], // Set background color of the bottom segment
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9, // 90% of the screen width
                    height: 50.0, // The height should be half of the width for perfect semicircles
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? () {
                        // Implement submit functionality
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled ? Colors.blue : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25.0), // Half of the height
                            right: Radius.circular(25.0), // Half of the height
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      ),
                      child: Text(
                        'Complete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300], // Light grey shade
        ),
        child: Icon(icon, size: 30),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, // Set background color of the input boxes to white
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
