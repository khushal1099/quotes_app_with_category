import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_category/controller/favorite_controller.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  FavoriteController favController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return favController.favlist.isEmpty
              ? Center(child: Text("No Favorite Quotes"))
              : ListView.builder(
                  itemCount: favController.favlist.length,
                  itemBuilder: (context, index) {
                    var fav = favController.favlist[index];
                    return Stack(
                      children: [
                        Container(
                          height: 200,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding:
                              EdgeInsets.only(top: 30, left: 15, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[
                                200], // Background color for the container
                            image: DecorationImage(
                              image: AssetImage(fav['image'].toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${fav['favquotes']}",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              favController.removefavQuotes(fav['id'] ?? '');

                            },
                            icon: const Icon(Icons.close),
                            // Icon for removing quote from favorites
                            color: Colors.red, // Color of the icon
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15),
                          padding: EdgeInsets.all(7),
                          height: MediaQuery.of(context).size.height * 0.040,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow),
                          child: Text(
                            "${fav['category']}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
