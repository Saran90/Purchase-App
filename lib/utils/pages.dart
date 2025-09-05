import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:purchase_app/features/login/login_binding.dart';
import 'package:purchase_app/features/login/login_screen.dart';
import 'package:purchase_app/features/purchase_bill/add/add_purchase_bill_binding.dart';
import 'package:purchase_app/features/purchase_bill/add/add_purchase_bill_screen.dart';
import 'package:purchase_app/features/purchase_bill/add_item/add_purchase_item_binding.dart';
import 'package:purchase_app/features/purchase_bill/add_item/add_purchase_item_screen.dart';
import 'package:purchase_app/utils/routes.dart';

import '../features/splash/splash_screen.dart';

final routes = [
  GetPage(
    name: '/',
    page:
        () => const Directionality(
          textDirection: TextDirection.ltr,
          child: SplashScreen(),
        ),
  ),
  GetPage(
    name: loginRoute,
    binding: LoginBinding(),
    page:
        () => Directionality(
          textDirection: TextDirection.ltr,
          child: LoginScreen(),
        ),
  ),
  GetPage(
    name: addPurchaseBillRoute,
    binding: AddPurchaseBillBinding(),
    page:
        () => Directionality(
          textDirection: TextDirection.ltr,
          child: AddPurchaseBillScreen(),
        ),
  ),
  GetPage(
    name: addPurchaseItemRoute,
    binding: AddPurchaseItemBinding(),
    page:
        () => Directionality(
          textDirection: TextDirection.ltr,
          child: AddPurchaseItemScreen(),
        ),
  ),
];
