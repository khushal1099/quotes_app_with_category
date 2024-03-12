import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quotes_app_with_category/helpers/db_helper.dart';

class FavoriteController extends GetxController {
  RxList<Map<String, String>> favlist = <Map<String, String>>[].obs;

  @override // Add @override annotation
  void onInit() {
    super.onInit();
    fetchfavQuotes();
  }

  Future<void> fetchfavQuotes() async {
    DbHelper helper = DbHelper();
    await helper.initDb();
    List<Map<String, dynamic>> favoritequotes = await helper.getquotes();
    favlist.assignAll(
      favoritequotes.map(
        (e) {
          return {
            'id': e['id'].toString(),
            'favquotes': e['favquotes'],
            'category': e['category'],
            'image': e['image'] != null ? e['image'] as String : '',
          };
        },
      ),
    );
    favlist.refresh();
  }

  Future<void> removefavQuotes(String id) async {
    DbHelper dbh = DbHelper();
    await dbh.initDb();
    await dbh.removeFavorite(id);
    await fetchfavQuotes();
  }
}
