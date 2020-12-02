import 'package:flutter/material.dart';
import 'package:extras/extras.dart';
import 'package:task/src/api/api.dart';
import 'package:task/src/models/models.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: '');
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Category',
              style: context.headline6,
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 8),
                FlatButton(
                  color: context.primary,
                  child: Text('Add').textColor(context.canvas),
                  onPressed: () async {
                    await CartApi()
                        .insertCategory(Category(name: controller.text));
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditCategoryDialog extends StatelessWidget {
  final Category category;
  const EditCategoryDialog({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: category.name);
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Category',
              style: context.headline6,
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 8),
                FlatButton(
                  child: Text('Edit').textColor(context.canvas),
                  color: context.primary,
                  onPressed: () async {
                    await CartApi()
                        .editCategoryName(category..name = controller.text);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
