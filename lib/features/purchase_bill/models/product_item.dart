class ProductItem {
  int id;
  String name;

  ProductItem({required this.id, required this.name});

  @override
  String toString() {
    return name.toString();
  }
}