import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:quotes_app_with_category/controller/random_controller.dart';
import 'package:quotes_app_with_category/helpers/db_helper.dart';
import 'package:quotes_app_with_category/model/random_model.dart';

class RandomQuotes extends StatefulWidget {
  const RandomQuotes({Key? key}) : super(key: key);

  @override
  State<RandomQuotes> createState() => _RandomQuotesState();
}

class _RandomQuotesState extends State<RandomQuotes> {
  RandomController rc = Get.put(RandomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Quotes"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (rc.random.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: rc.random.length,
              itemBuilder: (context, index) {
                Rx<RandomQuote> ran = rc.random[index].obs;
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black54,
                            ),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  ran.value.content ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              onPressed: () async{
                                var sample = rc.random[rc.cIndex];
                                String? quoteContent = sample.content; // Get the quote content from the RandomQuote object
                                DbHelper helper = DbHelper();
                                bool quoteExists = await helper.checkquote(quoteContent!);

                                if (quoteExists) {
                                  // Show snackbar if the quote is already in the database
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Quote is already in favorites'),
                                    ),
                                  );
                                } else {
                                  // Insert the quote into the database
                                  helper.insertFavorite(quoteContent, "${sample.tags}");
                                  // Show a snackbar after inserting the quote
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Quote added to favorites'),
                                    ),
                                  );
                                }

                              },
                              icon: Icon(
                                Icons.favorite_border,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          // Call the function to fetch new random quote
                          rc.getApi();
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
