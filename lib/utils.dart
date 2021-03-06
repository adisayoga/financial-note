/*
 * Copyright (c) 2017. All rights reserved.
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential.
 *
 * Written by:
 *   - Adi Sayoga <adisayoga@gmail.com>
 */

library utils;

import 'package:financial_note/data.dart';
import 'package:intl/intl.dart';


/// Parse double from dynamic variable.
double parseDouble(dynamic value) {
  try {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String && value.trim() != '') return double.parse(value);
    return 0.0;
  } catch (e) {
    return 0.0;
  }
}

/// Parse integer from dynamic variable.
int parseInt(dynamic value) {
  try {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String && value.trim() != '') return int.parse(value);
    return 0;
  } catch (e) {
    return 0;
  }
}

/// Parse DateTime from dynamic variable.
DateTime parseDate(dynamic value) {
  try {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String && value.trim() != '') return DateTime.parse(value);
    return null;
  } catch (e) {
    return null;
  }
}

/// Parse String from dynamic value.
String parseString(dynamic value) {
  return value?.toString();
}

/// Parse bool from dynamic value.
bool parseBool(dynamic value) {
  try {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String && value.toLowerCase() == 'true') return true;
    if (value is num && value > 0) return true;
    return false;
  } catch (e) {
    return false;
  }
}

/// Get value dari Map, return def jika key missing pada map.
T valueOf<T>(Map<String, T> map, String key, [T defaultValue]) {
  if (map == null || !map.containsKey(key)) return defaultValue;
  return map[key];
}

String formatCurrency(dynamic number, {int decimalDigits = 0, String symbol}) {
  if (number == 0) return '-';
  final formatter = new NumberFormat.currency(
    symbol: symbol,
    decimalDigits: decimalDigits
  );
  final absNum = number < 0 ? -number : number;
  //if (absNum >= 1000000000) return formatter.format(number / 1000000000) + 'B';
  //if (absNum >= 1000000) return formatter.format(number / 1000000) + 'M';
  if (absNum >= 1000) return formatter.format(number / 1000) + 'k';
  return formatter.format(number);
}

String formatDate(DateTime date, [String pattern = 'yyyy-MM-dd HH:mm:ss']) {
  final formatter = new DateFormat(pattern);
  return formatter.format(date);
}

/// Short function untuk membuat uri.
Uri getUri(String host, String path,
          {String schema: kUriScheme, Map<String, dynamic> params}) {
  return new Uri(
    scheme: schema,
    host: host,
    path: path,
    queryParameters: params,
  );
}

/// Compare date
int compareDate(DateTime a, DateTime b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return a.compareTo(b);
}
