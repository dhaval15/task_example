import 'package:firebase_auth/firebase_auth.dart';
import 'package:extras/extras.dart';
import 'package:flutter/material.dart';
import 'package:task/src/api/api.dart';
import 'package:task/src/models/models.dart';
import 'package:task/src/screens/screens.dart';
import 'package:task/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final categoryKey = GlobalKey<CategoryListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
        title: IconButton(
          icon: Icon(Icons.settings_brightness),
          onPressed: () {},
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Logout',
                child: Text('Logout'),
              )
            ],
            onSelected: (String entry) async {
              if (entry == 'Logout') {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed(Screens.LOGIN);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: CategoryList(
            key: categoryKey,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(),
          );
          if (result != null && result) {
            categoryKey.currentState.reload();
          }
        },
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  const CategoryList({Key key}) : super(key: key);

  static CategoryListState of(BuildContext context) =>
      context.findAncestorStateOfType<CategoryListState>();

  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: CartApi().getCategories(),
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => CategoryView(
                category: snapshot.data[index],
              ),
            )
          : CircularProgressIndicator().center(),
    );
  }
}
