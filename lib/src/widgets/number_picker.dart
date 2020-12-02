import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class NumberPicker extends StatelessWidget {
  final ValueNotifier<int> controller;
  final int maxValue;
  final int minValue;

  const NumberPicker(
      {Key key, this.controller, this.maxValue = 10, this.minValue = 1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomNumberPicker(
      maxValue: maxValue,
      onValue: (value) {
        controller.value = value;
      },
      initialValue: controller.value,
      minValue: minValue,
    );
  }
}
