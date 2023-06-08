import 'package:mart/consts/colors.dart';
import 'package:mart/src/ar_category_list.dart/itemmodel.dart';
import 'package:mart/src/screen.dart/arview.dart';
import 'package:flutter/material.dart';

class ItemsListScreen extends StatelessWidget {
  List<ItemModel> items = [
    ItemModel(
      'Double Bed',
      'Double Bed With 2 Lampls',
      'assets/items/bed.png',
      12,
    ),
    ItemModel(
      'Dinner Table',
      'Dinner Table For Your Home',
      'assets/items/dinner_table.png',
      12,
    ),
    ItemModel(
      'Sofa Yellow',
      'Sofa Yellow For Your Home',
      'assets/items/sofa_grey.png',
      12,
    ),
    ItemModel(
      'Table',
      'Table For Your Home',
      'assets/items/table.png',
      12,
    ),
    ItemModel(
      'Pc Table',
      'Pc table For Your Home',
      'assets/items/pc_table.png',
      12,
    ),
    ItemModel(
      'Chair',
      'chair For Your Home',
      'assets/items/rot_chair.png',
      12,
    ),
    ItemModel(
      'Single Sofa',
      'chair For Your Home',
      'assets/items/single_sofa.png',
      12,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'AR',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  Text(
                    'Furniture',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArviewScreen(
                                    itemImg: items[index].pic,
                                  ),
                                ));
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.asset(
                                  "${items[index].pic}",
                                  width: 60,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      items[index].name,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      items[index].detail,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 60,
                                child: Text(
                                  items[index].price.toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: redColor),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: items.length,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
