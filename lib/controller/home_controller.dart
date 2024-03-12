import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_category/model/quotes_model.dart';

class HomeController extends GetxController {
  RxInt cindex = 0.obs;
  RxList<Quotes> qList = <Quotes>[].obs;
  Quotes? quotes;

  Future getData() async {
    var filedata = await rootBundle.loadString("lib/jsons/quotes_json.json");
    jsonDecode(filedata);
    qList.value = quotesFromJson(filedata);
  }


  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
