import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:purchase_app/api/api_client.dart';
import 'package:purchase_app/utils/messages.dart';

import '../../data/error/failures.dart';
import '../endpoints.dart';
import '../error_response.dart';

class ProductApi extends ApiClient {
  ProductApi({required baseUrl}) : super(baseUrl: apiBaseUrl);
}