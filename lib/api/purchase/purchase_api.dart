import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:purchase_app/api/api_client.dart';
import 'package:purchase_app/api/purchase/models/add_purchase_request.dart';
import 'package:purchase_app/api/purchase/models/add_purchase_response.dart';
import 'package:purchase_app/api/purchase/models/delete_purchase_request.dart';
import 'package:purchase_app/api/purchase/models/delete_purchase_response.dart';
import 'package:purchase_app/api/purchase/models/purchase_response.dart';

import '../../data/error/failures.dart';
import '../endpoints.dart';
import '../error_response.dart';

class AuthApi extends ApiClient {
  AuthApi({required baseUrl}) : super(baseUrl: apiBaseUrl);

  Future<Either<Failure, AddPurchaseResponse?>> addPurchase(
    AddPurchaseRequest request,
  ) async {
    try {
      var response = await post(addPurchaseUrl, request.toJson());
      if (response.isOk) {
        AddPurchaseResponse purchaseResponse = AddPurchaseResponse.fromJson(
          response.body,
        );
        return Right(purchaseResponse);
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
      var response = await post(deletePurchaseUrl, request.toJson());
      if (response.isOk) {
        DeletePurchaseResponse purchaseResponse =
            DeletePurchaseResponse.fromJson(response.body);
        return Right(purchaseResponse);
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
      var response = await get(getPurchaseByIdUrl, query: {'purchaseId': id});
      if (response.isOk) {
        PurchaseResponse purchaseResponse = PurchaseResponse.fromJson(
          response.body,
        );
        return Right(purchaseResponse);
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
}
