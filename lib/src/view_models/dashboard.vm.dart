import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardViewModel extends BaseViewModel {
  final indexPage = 0.obs;
  final page = PageController();

  changePage(int index) {
    indexPage(index);
    page.jumpToPage(index);
  }
}
