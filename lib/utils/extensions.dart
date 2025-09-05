import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDDMMYYYY() {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(this);
  }
}

extension StringExtension on String {
  double? toDouble() {
    return double.tryParse(this);
  }
  int? toInt() {
    return int.tryParse(this);
  }
}