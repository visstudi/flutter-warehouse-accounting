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

List<Goods> tempGoodsList = [
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
