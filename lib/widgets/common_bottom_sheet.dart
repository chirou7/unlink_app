import 'package:flutter/material.dart';

class CommonBottomSheet {
  static void showRadioList(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String value,
    required Function(String) onChanged,
  }) {}
  static void showInput(
    BuildContext context, {
    required String title,
    required String hint,
    required String value,
    required Function(String) onChanged,
  }) {}
  static void showNumberPicker(
    BuildContext context, {
    required String title,
    required int initialValue,
    required int min,
    required int max,
    required Function(int) onSelected,
  }) {}
  static void showDatePicker(
    BuildContext context, {
    required String title,
    required DateTime initialDate,
    required Function(DateTime) onSelected,
    Function()? onCancel,
    Widget? customBottomWidget,
  }) {}
}
