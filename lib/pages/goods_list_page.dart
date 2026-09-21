import 'package:flutter/material.dart';
import 'package:sandbox_app1/components/goods_tile.dart';
import 'package:sandbox_app1/models/goods.dart';
import 'package:sandbox_app1/pages/goods_page.dart';

class GoodsList extends StatelessWidget {
  new({super.key});

  final List<Goods> goods = [
    Goods(
      name: "name",
      description: "description",
      imagePath: "lib/images/photo_2026-04-14_21-58-29.jpg",
      status: GoodsStatus.free,
    ),
    Goods(
      name: "name2",
      description: "description2",
      imagePath: "lib/images/photo_2026-04-14_21-58-29.jpg",
      status: GoodsStatus.taken,
    ),
  ];

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
                itemCount: goods.length,
                itemBuilder: (context, index) {
                  return GoodsTile(
                    goods: goods[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoodsPage(goods: goods[index]),
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
