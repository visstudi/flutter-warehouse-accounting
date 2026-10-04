import 'package:flutter/material.dart';
import 'package:sandbox_app1/components/goods_tile.dart';
import 'package:sandbox_app1/models/goods.dart';
import 'package:sandbox_app1/pages/add_goods_page.dart';
import 'package:sandbox_app1/pages/goods_page.dart';

class GoodsList extends StatefulWidget {
  const new({super.key});

  @override
  State<GoodsList> createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {
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
                physics: BouncingScrollPhysics(),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddGoodsPage()),
        ),
      ),
    );
  }
}
