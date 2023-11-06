import 'package:flutter/material.dart';
import 'package:semana12_1/utils/dbhelper.dart';
import 'models/list_items.dart';
import 'models/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //DBHelper helper = DBHelper();
    //helper.testDB();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShowList(),)
    );
  }
}

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  DBHelper helper = DBHelper();
  List<ShoppingList> shoppingList = [];

  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
      itemCount: (shoppingList != null)? shoppingList.length : 0,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text(shoppingList[index].name),
          );
      }
    );
  }
  
  Future showData() async {
    await helper.openDb();

    shoppingList = await helper.getLists();

    setState(() {
      shoppingList = shoppingList;
    });
  }
}