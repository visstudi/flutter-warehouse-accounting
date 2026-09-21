import 'package:flutter/material.dart';
import 'package:sandbox_app1/models/goods.dart';

class GoodsPage extends StatelessWidget {
  const new({super.key, required this._goods});

  final Goods _goods;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Text(
                _goods.name,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),

            AspectRatio(aspectRatio: 1, child: Image.asset(_goods.imagePath)),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Статус:", style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: _goods.status == GoodsStatus.free
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      _goods.status == GoodsStatus.free ? "Свободен" : "Занят",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Expanded(
              child: Text(_goods.description, overflow: TextOverflow.clip),
            ),
          ],
        ),
      ),
    );
  }
}
