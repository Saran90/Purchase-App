import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:purchase_app/api/api_client.dart';
import 'package:purchase_app/api/purchase/models/add_purchase_request.dart';
import 'package:purchase_app/api/purchase/models/add_purchase_response.dart';
import 'package:purchase_app/api/purchase/models/delete_purchase_request.dart';
import 'package:purchase_app/api/purchase/models/delete_purchase_response.dart';
import 'package:purchase_app/api/purchase/models/get_product_by_barcode_response.dart';
import 'package:purchase_app/api/purchase/models/get_products_response.dart';
import 'package:purchase_app/api/purchase/models/get_purchase_bills_response.dart';
import 'package:purchase_app/api/purchase/models/get_suppliers_response.dart';
import 'package:purchase_app/api/purchase/models/purchase_response.dart';

import '../../data/error/failures.dart';
import '../endpoints.dart';
import '../error_response.dart';

class PurchaseApi extends ApiClient {
  PurchaseApi({required baseUrl})
    : super(baseUrl: apiBaseUrl, isAuthenticated: true);

  Future<Either<Failure, AddPurchaseResponse?>> addPurchase(
    AddPurchaseRequest request,
  ) async {
    try {
      print('Request: ${request.toJson()}');
      var response = await post(
        addPurchaseUrl,
        request.toJson(),
        contentType: 'application/json',
      );
      if (response.isOk) {
        AddPurchaseResponse purchaseResponse = AddPurchaseResponse.fromJson(
          response.body,
        );
        return Right(purchaseResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Purchase Call: $exception');
      if (exception is DioException) {
        debugPrint('Purchase Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  Future<Either<Failure, DeletePurchaseResponse?>> deletePurchase(
    DeletePurchaseRequest request,
  ) async {
    try {
      var response = await post(
        '$deletePurchaseUrl?purchaseId=${request.purchaseId}',
        {},
      );
      if (response.isOk) {
        DeletePurchaseResponse purchaseResponse =
            DeletePurchaseResponse.fromJson(response.body);
        return Right(purchaseResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Purchase Call: $exception');
      if (exception is DioException) {
        debugPrint('Purchase Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  Future<Either<Failure, PurchaseResponse?>> getPurchaseById(int id) async {
    try {
      var response = await get('$getPurchaseByIdUrl?purchaseId=$id');
      if (response.isOk) {
        PurchaseResponse purchaseResponse = PurchaseResponse.fromJson(
          response.body,
        );
        return Right(purchaseResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Purchase Call: $exception');
      if (exception is DioException) {
        debugPrint('Purchase Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  Future<Either<Failure, GetProductByBarcodeResponse?>> getProductByBarcode(
    String barcode,
  ) async {
    try {
      var response = await get('$getProductByCodeUrl?barCode=$barcode');
      if (response.isOk) {
        GetProductByBarcodeResponse productByBarcodeResponse =
            GetProductByBarcodeResponse.fromJson(response.body);
        return Right(productByBarcodeResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Product By Barcode Call: $exception');
      if (exception is DioException) {
        debugPrint('Product By Barcode Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  Future<Either<Failure, GetSuppliersResponse?>> getSuppliers({
    required String name,
  }) async {
    try {
      var response = await get(suppliersUrl, query: {'name': name});
      if (response.isOk) {
        GetSuppliersResponse suppliersResponse = GetSuppliersResponse.fromJson(
          response.body,
        );
        return Right(suppliersResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Suppliers Call: $exception');
      if (exception is DioException) {
        debugPrint('Suppliers Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  Future<Either<Failure, GetProductsResponse?>> getProducts({
    required String name,
  }) async {
    try {
      var response = await get(productsUrl, query: {'name': name});
      if (response.isOk) {
        GetProductsResponse productsResponse = GetProductsResponse.fromJson(
          response.body,
        );
        return Right(productsResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Products Call: $exception');
      if (exception is DioException) {
        debugPrint('Products Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  Future<Either<Failure, GetPurchaseBillsResponse?>> getPurchaseBills({
    int? supplierId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      var response = await get(
        getPurchasesUrl,
        query: {
          if (supplierId != null) 'supplierId': supplierId,
          if (startDate != null) 'strFromDate': startDate,
          if (endDate != null) 'strTillDate': endDate,
        },
      );
      if (response.isOk) {
        GetPurchaseBillsResponse purchaseBillsResponse =
            GetPurchaseBillsResponse.fromJson(response.body);
        return Right(purchaseBillsResponse);
      } else if (response.statusCode == 401) {
        return Left(AuthFailure());
      } else {
        ErrorResponse? errorResponse = ErrorResponse.fromJson(response.body);
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
    } catch (exception) {
      debugPrint('Purchase Bills Call: $exception');
      if (exception is DioException) {
        debugPrint('Purchase Bills Call Exception: ${exception.message}');
        ErrorResponse? errorResponse = ErrorResponse.fromJson(
          exception.response?.data,
        );
        return Left(APIFailure<ErrorResponse>(error: errorResponse));
      }
      return Left(ServerFailure(message: exception.toString()));
    }
  }
}
