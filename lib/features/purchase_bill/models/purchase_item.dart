class PurchaseItem {
  int id;
  String name;
  String packaging;
  String barcode;
  double price;
  int quantity;
  int freeQuantity;
  int count;

  PurchaseItem({
    required this.id,
    required this.name,
    required this.packaging,
    required this.barcode,
    required this.price,
    required this.freeQuantity,
    required this.quantity,
    required this.count,
  });
}
