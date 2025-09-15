import 'package:flutter/material.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_bill.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';
import 'package:purchase_app/utils/extensions.dart';

class PurchaseItemWidget extends StatelessWidget {
  const PurchaseItemWidget({super.key, required this.purchaseBill});

  final PurchaseBill purchaseBill;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/ic_bill.png',
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        purchaseBill.invoiceNo ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        purchaseBill.supplierName ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                '₹${purchaseBill.billAmount}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                purchaseBill.purchaseDate?.toDDMMYYYY() ?? '',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
