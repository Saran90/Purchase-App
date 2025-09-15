class ProductItem {
  int id;
  String name;
  String packing;
  double mrp;
  String barCode;

  ProductItem({
    required this.id,
    required this.name,
    required this.packing,
    required this.mrp,
    required this.barCode,
  });

  @override
  String toString() {
    return name.toString();
  }
}
