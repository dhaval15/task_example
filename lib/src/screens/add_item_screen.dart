import 'package:flutter/material.dart';
import 'package:extras/extras.dart';
import 'package:task/src/api/api.dart';
import 'package:task/src/models/category.dart';
import 'package:task/src/models/models.dart';
import 'package:task/src/widgets/widgets.dart';

class AddItemScreen extends StatelessWidget {
  final Category category;
  final pickerKey = GlobalKey<ImagePickerWidgetState>();
  final controller = ValueNotifier<int>(1);

  AddItemScreen({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagePickerWidget(key: pickerKey),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Numer of Items'),
                  SizedBox(width: 8),
                  NumberPicker(controller: controller),
                ],
              ),
              SizedBox(height: 20),
              FlatButton(
                color: context.primary,
                onPressed: () async {
                  showDialog(
                      context: context, builder: (context) => LoadingDialog());
                  await CartApi().addItem(
                      Item(categotyId: category.id, count: controller.value),
                      pickerKey.currentState.image);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                },
                child: Text('Add').textColor(context.canvas),
              )
            ],
          ).center(),
        ),
      ),
    );
  }
}
