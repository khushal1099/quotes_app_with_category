import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_category/controller/home_controller.dart';
import 'package:quotes_app_with_category/helpers/db_helper.dart';
import 'package:quotes_app_with_category/view/favorite.dart';
import 'package:quotes_app_with_category/view/random_quotes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    _controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(RandomQuotes());
          },
          icon: Icon(Icons.wifi_protected_setup_rounded),
        ),
        title: Text("Home"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Favorite());
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
            ),
            Text(
              "Awesome quotes from our community",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              ()=> Container(
                height: height * 0.040,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _controller.qList.isNotEmpty
                      ? _controller.qList[0].categories?.length
                      : 0,
                  itemBuilder: (context, index) {
                    var ql = _controller.qList[0].categories;
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          _controller.cindex.value =
                              index; // Update the index on tap
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(),
                            color: _controller.cindex.value == index
                                ? Colors.black
                                : Colors.black38, // Set color based on index
                          ),
                          child: Center(
                            child: Text(
                              ql?[index] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ), // Text color
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  return Obx(
                    () => IndexedStack(
                      index: _controller.cindex.value,
                      children: [
                        ListView.builder(
                          itemCount: _controller.qList.isNotEmpty
                              ? _controller.qList[0].love?.length ?? 0
                              : 0,
                          itemBuilder: (context, index) {
                            var loveList = _controller.qList[0].love;

                            return Stack(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.only(
                                      top: 30, left: 15, right: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(_controller.qList[0].loveImage??''),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      loveList![index],
                                      style: TextStyle(fontSize: 25),
                                    ), // Handle null value with a placeholder
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () async{
                                      var quote = _controller.qList[0].love![index];
                                      DbHelper helper = DbHelper();
                                      // await helper.insertFavorite(quote,'Love',_controller.qList[0].loveImage.toString());
                                      bool quoteExists = await helper.checkquote(quote);

                                      if (quoteExists) {
                                        // Show snackbar if the quote is already in the database
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote is already in favorites'),
                                          ),
                                        );
                                      } else {
                                        // Insert the quote into the database
                                        await helper.insertFavorite(quote,'Love',image: _controller.qList[0].loveImage??'');

                                        // Show a snackbar after inserting the quote
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote added to favorites'),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                        Icons.favorite_border),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: _controller.qList.isNotEmpty
                              ? _controller.qList[0].calm?.length ?? 0
                              : 0,
                          itemBuilder: (context, index) {
                            var loveList = _controller.qList[0].calm;

                            return Stack(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.only(
                                      top: 30, left: 15, right: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(_controller.qList[0].calmImage??''),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      loveList![index],
                                      style: TextStyle(fontSize: 25),
                                    ), // Handle null value with a placeholder
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () async{
                                      var quote = _controller.qList[0].calm![index];
                                      DbHelper helper = DbHelper();
                                      // await helper.insertFavorite(quote,'Calm',image: _controller.qList[0].calmImage??'');
                                      bool quoteExists = await helper.checkquote(quote);

                                      if (quoteExists) {
                                        // Show snackbar if the quote is already in the database
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote is already in favorites'),
                                          ),
                                        );
                                      } else {
                                        // Insert the quote into the database
                                        await helper.insertFavorite(quote,'Calm',image: _controller.qList[0].calmImage??'');

                                        // Show a snackbar after inserting the quote
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote added to favorites'),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: _controller.qList.isNotEmpty
                              ? _controller.qList[0].sad?.length ?? 0
                              : 0,
                          itemBuilder: (context, index) {
                            var loveList = _controller.qList[0].sad;

                            return Stack(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.only(
                                      top: 10, left: 40, right: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(_controller.qList[0].sadImage??''),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      loveList![index],
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ), // Handle null value with a placeholder
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () async{
                                      var quote = _controller.qList[0].sad![index];
                                      DbHelper helper = DbHelper();
                                      // await helper.insertFavorite(quote,'Sad',image: _controller.qList[0].sadImage??'');
                                      bool quoteExists = await helper.checkquote(quote);

                                      if (quoteExists) {
                                        // Show snackbar if the quote is already in the database
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote is already in favorites'),
                                          ),
                                        );
                                      } else {
                                        // Insert the quote into the database
                                        await helper.insertFavorite(quote,'Sad',image: _controller.qList[0].sadImage??'');

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
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: _controller.qList.isNotEmpty
                              ? _controller.qList[0].time?.length ?? 0
                              : 0,
                          itemBuilder: (context, index) {
                            var loveList = _controller.qList[0].time;

                            return Stack(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.only(
                                      top: 20, left: 15, right: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(_controller.qList[0].timeImage??''),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      loveList![index],
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ), // Handle null value with a placeholder
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () async{
                                      var quote = _controller.qList[0].time![index];
                                      DbHelper helper = DbHelper();
                                      // await helper.insertFavorite(quote,'Time',image: _controller.qList[0].timeImage);
                                      bool quoteExists = await helper.checkquote(quote);

                                      if (quoteExists) {
                                        // Show snackbar if the quote is already in the database
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote is already in favorites'),
                                          ),
                                        );
                                      } else {
                                        // Insert the quote into the database
                                        await helper.insertFavorite(quote,'Time',image: _controller.qList[0].timeImage??'');

                                        // Show a snackbar after inserting the quote
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote added to favorites'),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: _controller.qList.isNotEmpty
                              ? _controller.qList[0].future?.length ?? 0
                              : 0,
                          itemBuilder: (context, index) {
                            var loveList = _controller.qList[0].future;

                            return Stack(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.only(
                                      top: 30, left: 15, right: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(_controller.qList[0].futureImage??''),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      loveList![index],
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ), // Handle null value with a placeholder
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () async{
                                      var quote = _controller.qList[0].future![index];
                                      DbHelper helper = DbHelper();
                                      // await helper.insertFavorite(quote,'Future',image: _controller.qList[0].futureImage);
                                      bool quoteExists = await helper.checkquote(quote);

                                      if (quoteExists) {
                                        // Show snackbar if the quote is already in the database
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote is already in favorites'),
                                          ),
                                        );
                                      } else {
                                        // Insert the quote into the database
                                        await helper.insertFavorite(quote,'Future',image: _controller.qList[0].futureImage??'');

                                        // Show a snackbar after inserting the quote
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote added to favorites'),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.favorite_border),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: _controller.qList.isNotEmpty
                              ? _controller.qList[0].relationship?.length ?? 0
                              : 0,
                          itemBuilder: (context, index) {
                            var loveList = _controller.qList[0].relationship;

                            return Stack(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.only(
                                      top: 30, left: 15, right: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(_controller.qList[0].relationshipImage??''),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      loveList![index],
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ), // Handle null value with a placeholder
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () async{
                                      var quote = _controller.qList[0].relationship![index];
                                      DbHelper helper = DbHelper();
                                      // await helper.insertFavorite(quote,'Relationship',image: _controller.qList[0].relationshipImage);
                                      bool quoteExists = await helper.checkquote(quote);

                                      if (quoteExists) {
                                        // Show snackbar if the quote is already in the database
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Quote is already in favorites'),
                                          ),
                                        );
                                      } else {
                                        // Insert the quote into the database
                                        await helper.insertFavorite(quote,'Relationship',image: _controller.qList[0].relationshipImage??'');

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
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
