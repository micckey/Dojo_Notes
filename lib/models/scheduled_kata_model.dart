import 'package:get/get.dart';

class ScheduledKata {
  final String name;
  RxBool isSelected;

  ScheduledKata(this.name) : isSelected = false.obs;
}