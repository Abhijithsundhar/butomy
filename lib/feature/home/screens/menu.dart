import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbutomy/core/common/common.dart';
import 'package:techbutomy/feature/home/homecontrollor/homecontrollor.dart';
import 'package:techbutomy/feature/home/screens/homescreen.dart';
import 'package:techbutomy/model/categoryModel.dart';

// List<Product> dishList = [];

class Menu extends ConsumerStatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  int _selectedButtonIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 15), (timer) {
      // dishList.clear();
    });
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool _isExpanded(String categoryName) {
    // Implement logic to check if the category is expanded
    // based on your app's state management
    return false;
  }

  void _setExpanded(String categoryName, bool expanded) {
    // Implement logic to set the category as expanded or not
    // based on your app's state management
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(dataProvider).when(
      data: (data) {
        if (data != null) {
          final result = data;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Padding(
              padding:
              EdgeInsets.only(top: height * .02, left: width * .015),
              child: Column(
                children: [
                  Row(children: [
                    SizedBox(width: width * .03),
                    Text('Veg', style: TextStyle(fontSize: width * .035)),
                    SizedBox(width: width * .01),
                    Container(
                      height: height * .025,
                      width: width * .1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade600),
                        borderRadius: BorderRadius.circular(width * .04),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * .02),
                        child: Icon(Icons.circle,
                            color: Colors.green.shade600,
                            size: width * .04),
                      ),
                    ),
                    SizedBox(width: width * .01),
                    Text('Non Veg',
                        style: TextStyle(fontSize: width * .035)),
                    SizedBox(width: width * .01),
                    Container(
                      height: height * .025,
                      width: width * .1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade600),
                        borderRadius: BorderRadius.circular(width * .04),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * .02),
                        child: Icon(Icons.circle,
                            color: Colors.green.shade600,
                            size: width * .04),
                      ),
                    ),
                    SizedBox(width: width * .01),
                    Container(
                      height: height * .04,
                      width: width * .48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(width * .04),
                      ),
                      child: Row(
                        children: List.generate(3, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedButtonIndex = index;
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: width * .16,
                                  height: width * .084,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: _selectedButtonIndex == index
                                        ? Colors.yellow.shade600
                                        : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      index == 0
                                          ? "All"
                                          : index == 1
                                          ? "Buy Now"
                                          : "Pre Order",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * .03,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ]),
                  SizedBox(height: height * .02),
                  Expanded(
                    child: ListView.builder(
                      itemCount: result.category.length,
                      itemBuilder: (context, index) {
                        Category category1 = result.category[index];
                        return ExpansionTile(
                          title: Text(category1.name),
                          trailing: Icon(_isExpanded(category1.name)
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down),
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              _setExpanded(category1.name, expanded);
                            });
                          },
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: category1.product.length,
                              itemBuilder: (context, dishIndex) {
                                Product dish = category1.product[dishIndex];
                                return Container(
                                  height: height * .2,
                                  color: Colors.grey.shade200,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * .05,
                                            top: height * .05),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: height * .03,
                                              width: width * .2,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(12),
                                                  bottomRight:
                                                  Radius.circular(12),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                      width: width * .03),
                                                  Text(
                                                      dish.discount
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                          width * .035,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .white)),
                                                  Text('%',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize:
                                                          width * .035,
                                                          color: Colors
                                                              .white)),
                                                  SizedBox(
                                                      width: width * .005),
                                                  Text('OFF',
                                                      style: TextStyle(
                                                          fontSize:
                                                          width * .035,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .white)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: height * .005),
                                            Row(
                                              children: [
                                                Container(
                                                  height: height * .025,
                                                  width: width * .05,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .red.shade600),
                                                  ),
                                                  child: Icon(Icons.circle,
                                                      color: Colors
                                                          .red.shade600,
                                                      size: width * .025),
                                                ),
                                                SizedBox(
                                                    width: width * .01),
                                                SizedBox(
                                                  width: width * .3,
                                                  child: Text(
                                                    dish.name,
                                                    style: TextStyle(
                                                        fontSize:
                                                        width * .04,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text('(1 min qty)',
                                                style: TextStyle(
                                                    fontSize: width * .03,
                                                    color: Colors.grey)),
                                            Row(
                                              children: [
                                                Text(
                                                  '₹${dish.mrp.toString()}',
                                                  style: TextStyle(
                                                    fontSize: width * .04,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    decoration:
                                                    TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: width * .03),
                                                Text(
                                                  '₹${dish.price.toStringAsFixed(0)}',
                                                  style: TextStyle(
                                                      fontSize: width * .04,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: width * .28),
                                      Column(
                                        children: [
                                          SizedBox(height: height * .015),
                                          Container(
                                            width: width * .2,
                                            height: height * .1,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  width * .03),
                                              child: Image.asset(
                                                  'assets/images/bonda.jpeg',
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          SizedBox(height: height * .01),
                                          Container(
                                            width: width * .27,
                                            height: height * .045,
                                            decoration: BoxDecoration(
                                                color: Colors.teal.shade300,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (dish.count > 0) {
                                                      dish.count--;
                                                      print("object");
                                                      /// Remove the dish from the list when count is zero
                                                      // dishList.remove(dish);
                                                      final resultDish =
                                                      ref.watch(
                                                          dishListsProvider);
                                                      resultDish
                                                          .remove(dish);
                                                      ref
                                                          .read(
                                                          dishListsProvider
                                                              .notifier)
                                                          .update((state) =>
                                                      resultDish);
                                                      ref.read
                                                        (refBoool.notifier).update((state) => !state);
                                                      setState(() {

                                                      });
                                                    }
                                                  },
                                                  icon: Icon(Icons.remove),
                                                ),
                                                Consumer(builder:
                                                    (context, ref3, child) {
                                                  // ref3.watch(refBoool);
                                                  // print(ref3.watch(intCount));
                                                  return Text(dish.count
                                                      .toString());
                                                }),
                                                IconButton(
                                                  onPressed: () {
                                                    if (dish.count >= 0) {
                                                      print("object");
                                                      dish.count++;


                                                      /// Add the dish to list
                                                      // dishList.add(dish);
                                                      // print('dishList.length');
                                                      // print(dishList.length);
                                                      // print(dishList.first);
                                                      final resultDish =
                                                      ref.watch(
                                                          dishListsProvider);
                                                      resultDish.add(dish);
                                                      ref
                                                          .read(
                                                          dishListsProvider
                                                              .notifier)
                                                          .update((state) =>
                                                      resultDish);
                                                      ref.read
                                                        (refBoool.notifier).update((state) => !state);
                                                      setState(() {

                                                      });
                                                    }
                                                  },
                                                  icon: Icon(Icons.add),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            category1.product.length == 6
                                ? SizedBox(height: height * .185)
                                : SizedBox(height: height * .38)
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text("No data")),
          );
        }
      },
      error: (error, stackTrace) {
        print(error.toString());
        print(stackTrace);
        return Scaffold(
          body: Center(child: Text("Error loading data")),
        );
      },
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}