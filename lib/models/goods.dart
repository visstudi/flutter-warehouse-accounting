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
