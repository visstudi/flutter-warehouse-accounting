import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class _ScannerOverlayPainter extends CustomPainter {
  final Rect scanWindow;

  _ScannerOverlayPainter({required this.scanWindow});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    final paint = Paint()..color = Colors.black.withAlpha(150);
    canvas.drawPaint(paint);

    final cutoutPaint = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(scanWindow, Radius.circular(20)),
      cutoutPaint,
    );

    canvas.restore();

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(scanWindow, Radius.circular(20)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class QrScannerPage extends StatefulWidget {
  const new({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _scannerController = MobileScannerController();

  bool _isScanned = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double boxSize = 250;
          final scanWindow = Rect.fromLTWH(
            (constraints.maxWidth - boxSize) / 2,
            (constraints.maxHeight - boxSize) / 2,
            boxSize,
            boxSize,
          );

          return Stack(
            children: [
              MobileScanner(
                scanWindow: scanWindow,
                controller: _scannerController,
                onDetect: (capture) {
                  if (_isScanned) return;

                  for (final barcode in capture.barcodes) {
                    final String? rawValue = barcode.rawValue;

                    if (rawValue != null) {
                      if (RegExp(r'^.+;.*$').hasMatch(rawValue)) {
                        _isScanned = true;

                        List<String> splittedRawValue = rawValue.split(';');

                        Navigator.pop(context, (
                          splittedRawValue[0],
                          splittedRawValue[1],
                        ));
                      }
                    }
                  }
                },
              ),
              CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _ScannerOverlayPainter(scanWindow: scanWindow),
              ),
              Align(
                alignment: Alignment(0, 0.5),
                child: FloatingActionButton(
                  child: Icon(Icons.flashlight_on),
                  onPressed: () => _scannerController.toggleTorch(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
