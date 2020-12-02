import 'package:flutter/material.dart';
import 'package:extras/extras.dart';
import 'package:task/src/api/api.dart';
import 'package:task/src/models/models.dart';
import 'package:task/src/screens/home_screen.dart';
import 'package:task/src/screens/screens.dart';
import 'package:task/src/widgets/widgets.dart';

import 'item_view.dart';

enum CategoryAction { editName, delete }

class CategoryView extends StatelessWidget {
  final Category category;

  const CategoryView({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                category.name,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ).padding(left: 12),
              SizedBox().expand(),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  final result = await Navigator.of(context)
                      .pushNamed(Screens.ADD_ITEM, arguments: category);
                  if (result != null && result) {
                    CategoryList.of(context).reload();
                  }
                },
              ),
              PopupMenuButton<CategoryAction>(
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text('Edit Name'),
                    value: CategoryAction.editName,
                  ),
                  PopupMenuItem(
                    child: Text('Delete Category'),
                    value: CategoryAction.delete,
                  ),
                ],
                onSelected: (CategoryAction action) async {
                  switch (action) {
                    case CategoryAction.editName:
                      {
                        final result = await showDialog(
                          context: context,
                          builder: (context) =>
                              EditCategoryDialog(category: category),
                        );
                        if (result != null && result)
                          CategoryList.of(context).reload();
                      }
                      break;
                    case CategoryAction.delete:
                      {
                        await CartApi().deleteCategory(category);
                        CategoryList.of(context).reload();
                      }
                      break;
                  }
                },
              ),
            ],
          ),
          ItemList(
            categoryId: category.id,
          )
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final String categoryId;

  const ItemList({Key key, this.categoryId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: CartApi().getItems(categoryId),
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data.length > 0
              ? ListItemView(
                  scrollDirection: Axis.horizontal,
                  items: snapshot.data,
                  separator: SizedBox(
                    width: 12,
                  ),
                  itemBuilder: (context, item, _) => ItemView(item: item),
                ).restrict(height: 310)
              : Text('No Items').center()
          : CircularProgressIndicator(),
    );
  }
}
