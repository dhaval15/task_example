import 'dart:collection';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:task/src/models/models.dart';

class CartApi {
  static final auth = FirebaseAuth.instance;
  static final database = FirebaseDatabase.instance;
  static final storage = FirebaseStorage.instance;

  Future<void> insertCategory(Category category) {
    final userId = auth.currentUser.uid;
    final reference = database
        .reference()
        .child('task_data')
        .child(userId)
        .child('categories')
        .push();
    category.id = reference.key;
    return reference.set(category.toJson());
  }

  Future<void> editCategoryName(Category category) {
    final userId = auth.currentUser.uid;
    return database
        .reference()
        .child('task_data')
        .child(userId)
        .child('categories')
        .child(category.id)
        .child('name')
        .set(category.name);
  }

  Future<List<Category>> getCategories() async {
    final userId = auth.currentUser.uid;
    final reference = database
        .reference()
        .child('task_data')
        .child(userId)
        .child('categories');
    final snapshot = await reference.once();
    if (snapshot.value != null) {
      return HashMap.from(snapshot.value).values.map((value) {
        return Category.fromJson(value);
      }).toList();
    }
    return [];
  }

  Future<List<Item>> getItems(String categoryId) async {
    final userId = auth.currentUser.uid;
    final reference = database
        .reference()
        .child('task_data')
        .child(userId)
        .child('categories')
        .child(categoryId)
        .child('items');
    final snapshot = await reference.once();
    if (snapshot.value != null) {
      return HashMap.from(snapshot.value)
          .values
          .map((data) => Item.fromJson(data))
          .toList();
    }
    return [];
  }

  Future<String> getImage(Item item) async {
    final userId = auth.currentUser.uid;
    return storage
        .ref()
        .child(userId)
        .child(item.categotyId)
        .child(item.id)
        .getDownloadURL();
  }

  Future<void> deleteCategory(Category category) async {
    final userId = auth.currentUser.uid;
    await database
        .reference()
        .child('task_data')
        .child(userId)
        .child('categories')
        .child(category.id)
        .set(null);
    await storage.ref().child(userId).child(category.id).listAll().then((list) {
      list.items.forEach((item) {
        item.delete();
      });
    });
  }

  Future addItem(Item item, File image) async {
    final userId = auth.currentUser.uid;
    final reference = database
        .reference()
        .child('task_data')
        .child(userId)
        .child('categories')
        .child(item.categotyId)
        .child('items')
        .push();
    item.id = reference.key;
    await reference.set(item.toJson());
    await storage
        .ref()
        .child(userId)
        .child(item.categotyId)
        .child(item.id)
        .putFile(image);
  }
}
