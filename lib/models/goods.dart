import 'dart:collection';

import 'package:flutter/material.dart';

enum GoodsStatus { free, taken }

class Goods {
  final String name;
  final String description;
  final String imagePath;
  GoodsStatus status;

  Goods({
    required this.name,
    required this.description,
    required this.imagePath,
    this.status = GoodsStatus.free,
  });
}

class GoodsListModel extends ChangeNotifier {
  final List<Goods> _tempGoodsList = [
    Goods(
      name: "Товар 1",
      description: "Описание товара... Описание товара... Описание товара... Описание товара... Описание товара... ",
      imagePath: "lib/images/placeholder.png",
      status: GoodsStatus.free,
    ),
    Goods(
      name: "Товар 2",
      description: "Описание товара 2... Описание товара 2... Описание товара 2... Описание товара 2... Описание товара 2... ",
      imagePath: "lib/images/placeholder.png",
      status: GoodsStatus.taken,
    ),
    Goods(
      name: "Товар 3",
      description: "Описание товара 3... Описание товара 3... Описание товара 3... Описание товара 3... Описание товара 3... ",
      imagePath: "lib/images/placeholder.png",
      status: GoodsStatus.free,
    ),
  ];

  UnmodifiableListView<Goods> get tempGoodsList =>
      UnmodifiableListView(_tempGoodsList);

  int get length => _tempGoodsList.length;

  void add(Goods goods) {
    _tempGoodsList.add(goods);
    notifyListeners();
  }

  void remove(int index) {
    _tempGoodsList.removeAt(index);
    notifyListeners();
  }
}
