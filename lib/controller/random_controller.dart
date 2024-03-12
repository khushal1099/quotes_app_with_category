import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app_with_category/helpers/db_helper.dart';
import 'package:quotes_app_with_category/model/random_model.dart';

class RandomController extends GetxController {
  RxList<RandomQuote> random = <RandomQuote>[].obs;
  int cIndex = 0;
  RxString quote = "".obs;

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  void getApi() async {
    try {
      var response = await http.get(Uri.parse("https://api.quotable.io/quotes/random"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List; // Parse response as a list
        List<RandomQuote> quotes = jsonData.map((quoteJson) => RandomQuote.fromJson(quoteJson)).toList();
        random.value = quotes.obs; // Update the observable list with the new quotes
        if (quotes.isNotEmpty) {
          quote.value = quotes.first.content ?? ''; // Update the current quote value
          update();
          print("LENGTH==> ${random.length}");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

}
