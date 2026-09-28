import 'package:flutter/material.dart';
import 'package:sandbox_app1/components/goods_tile.dart';
import 'package:sandbox_app1/models/goods.dart';
import 'package:sandbox_app1/pages/goods_page.dart';

class GoodsList extends StatelessWidget {
  new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Text(
                "Список товаров",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),

            Expanded(
              child: ListView.separated(
                itemCount: tempGoodsList.length,
                itemBuilder: (context, index) {
                  return GoodsTile(
                    goods: tempGoodsList[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GoodsPage(goods: tempGoodsList[index]),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
