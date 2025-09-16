class PurchaseItem {
  int id;
  int rowNumber;
  String name;
  String packaging;
  String barcode;
  double price;
  int quantity;
  int freeQuantity;

  PurchaseItem({
    required this.id,
    required this.rowNumber,
    required this.name,
    required this.packaging,
    required this.barcode,
    required this.price,
    required this.freeQuantity,
    required this.quantity,
  });
}
