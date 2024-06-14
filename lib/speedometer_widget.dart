import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpeedometerWidget extends StatefulWidget {
  final double progress; // Progress from 0.0 to 1.0
  final List<String> stages;

  SpeedometerWidget({
    required this.progress,
    required this.stages,
  });

  @override
  _SpeedometerWidgetState createState() => _SpeedometerWidgetState();
}

class _SpeedometerWidgetState extends State<SpeedometerWidget> {
  ui.Image? plantImage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final ByteData data = await rootBundle.load('assets/images/plant.png');
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo fi = await codec.getNextFrame();
    setState(() {
      plantImage = fi.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate current stage based on progress
    int currentStageIndex = (widget.progress * (widget.stages.length - 1)).round();
    String currentStage = widget.stages[currentStageIndex];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 10.0),
          Container(
            width: 250,
            height: 300, // Increased height to accommodate stages text
            child: CustomPaint(
              painter: SpeedometerPainter(
                widget.progress,
                widget.stages,
                plantImage,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '$currentStage Stage',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'During the $currentStage phase, growers often engage in fertilisation or triage actions.',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Container(
            width: 1000,
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          ),
          SizedBox(height: 20.0),
          Text(
            'COLLECT DATA TO FIELDS',
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Add your functionality here
          //   },
          //   style: ElevatedButton.styleFrom(
          //     // primary: Colors.green[800],,,
          //     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20.0),
          //     ),
          //   ),
          //   child: Text(
          //     'COLLECT DATA TO FIELDS',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 16.0,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class SpeedometerPainter extends CustomPainter {
  final double progress;
  final List<String> stages;
  final ui.Image? plantImage;

  SpeedometerPainter(this.progress, this.stages, this.plantImage);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double centerX = width / 2;
    double centerY = height / 2;
    double radius = width / 2 - 20;

    Paint trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.round;

    // Draw the track
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3 * pi / 4,
      3 * pi / 2,
      false,
      trackPaint,
    );

    // Draw the progress
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3 * pi / 4,
      3 * pi / 2 * progress,
      false,
      progressPaint,
    );

    // Draw center plant image if available
    if (plantImage != null) {
      double imageSize = radius * 1.4; // Ensuring the image covers the inside part of the speedometer
      canvas.save();
      canvas.clipPath(Path()..addOval(Rect.fromCircle(center: Offset(centerX, centerY), radius: imageSize / 2)));
      canvas.drawImageRect(
        plantImage!,
        Rect.fromLTWH(0, 0, plantImage!.width.toDouble(), plantImage!.height.toDouble()),
        Rect.fromLTWH(centerX - imageSize / 2, centerY - imageSize / 2, imageSize, imageSize),
        Paint(),
      );
      canvas.restore();
    }

    // Draw stages text
    double angleStep = 3 * pi / 2 / (stages.length - 1);
    for (int i = 0; i < stages.length; i++) {
      final stageText = stages[i];
      final textPainter = TextPainter(
        text: TextSpan(text: stageText, style: TextStyle(color: Colors.black, fontSize: 12)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      );
      textPainter.layout();

      double textAngle = 3 * pi / 4 + i * angleStep;
      double textX = centerX + (radius + 30) * cos(textAngle);
      double textY = centerY + (radius + 30) * sin(textAngle);
      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(textAngle + pi / 2);
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }

    // Draw current stage dot
    double dotAngle = 3 * pi / 4 + progress * 3 * pi / 2;
    double dotX = centerX + radius * cos(dotAngle);
    double dotY = centerY + radius * sin(dotAngle);
    Paint dotPaint = Paint()..color = Colors.orange;
    canvas.drawCircle(Offset(dotX, dotY), 8, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
