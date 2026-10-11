import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const new({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController scannerController = MobileScannerController();

  bool _isScanned = false;

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MobileScanner(
        controller: scannerController,
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
    );
  }
}
