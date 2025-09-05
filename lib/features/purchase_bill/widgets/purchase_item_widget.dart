import 'package:flutter/material.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';

class PurchaseItemWidget extends StatelessWidget {
  const PurchaseItemWidget({super.key, required this.purchaseItem});

  final PurchaseItem purchaseItem;

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
          Row(
            children: [
              Image.asset(
                'assets/icons/ic_product.png',
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    purchaseItem.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text('Quantity: ', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white60
                      ),),
                      Text(
                        purchaseItem.quantity.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white60,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                '₹${purchaseItem.price}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text('Count: ', style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white60
                  ),),
                  Text(
                    purchaseItem.count.toString(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white60,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
