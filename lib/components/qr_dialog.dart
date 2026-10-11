import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRDialog {
  static void showQRDialog(
    BuildContext context,
    String name,
    String description,
  ) {
    AlertDialog qr = AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox(
        width: 300,
        child: QrImageView(
          data: "$name;$description",
          version: QrVersions.auto,
          backgroundColor: Colors.grey[200] ?? Colors.grey,
        ),
      ),
    );

    showDialog(context: context, builder: (context) => qr);
  }
}
