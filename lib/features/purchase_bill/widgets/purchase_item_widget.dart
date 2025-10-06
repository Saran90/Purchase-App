import 'package:flutter/material.dart';
import 'package:purchase_app/features/purchase_bill/models/purchase_item.dart';

import '../../../utils/messages.dart';

class PurchaseItemWidget extends StatelessWidget {
  const PurchaseItemWidget({
    super.key,
    required this.purchaseItem,
    required this.isImported,
    required this.onDeleteClicked,
  });

  final PurchaseItem purchaseItem;
  final Function() onDeleteClicked;
  final bool isImported;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
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
                            'assets/icons/ic_product.png',
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
                                  purchaseItem.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Quantity: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white60,
                                      ),
                                    ),
                                    Text(
                                      purchaseItem.quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ],
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
                          '$rupeeIcon ${purchaseItem.price}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Free: ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white60,
                              ),
                            ),
                            Text(
                              purchaseItem.freeQuantity.toString(),
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
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.yellow,
                  width: 20,
                  child: Center(
                    child: Text(
                      '${purchaseItem.rowNumber}',
                      style: TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !isImported,
          child: Row(
            children: [
              const SizedBox(width: 5),
              IconButton(
                onPressed: onDeleteClicked,
                icon: Icon(Icons.delete, color: Colors.red, size: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
