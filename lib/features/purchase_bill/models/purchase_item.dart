class PurchaseItem {
  int? tempId;
  int id;
  int rowNumber;
  String name;
  String packaging;
  String barcode;
  String newBarcode;
  String hsnCode;
  double price;
  int quantity;
  int freeQuantity;
  double taxPercentage;
  bool isNew;

  PurchaseItem({
    required this.id,
    required this.rowNumber,
    required this.name,
    required this.packaging,
    required this.newBarcode,
    required this.barcode,
    required this.price,
    required this.freeQuantity,
    required this.quantity,
    required this.hsnCode,
    required this.taxPercentage,
    this.isNew = false,
    this.tempId
  });
}
