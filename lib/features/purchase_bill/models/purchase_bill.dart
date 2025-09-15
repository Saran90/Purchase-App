import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';

class PurchaseBill {
  int? purchaseId;
  int? purchaseNo;
  DateTime? purchaseDate;
  String? invoiceNo;
  DateTime? invoiceDate;
  int? supplierId;
  String? supplierName;
  bool? isImported;
  double? billAmount;
  List<PurchaseItem>? items;

  PurchaseBill({
    this.items,
    this.purchaseId,
    this.supplierId,
    this.billAmount,
    this.invoiceDate,
    this.invoiceNo,
    this.isImported,
    this.purchaseDate,
    this.purchaseNo,
    this.supplierName,
  });
}
