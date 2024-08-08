import 'package:firebase_database/firebase_database.dart';
import 'package:srv_test/models/item_model.dart';

class ItemsDataProvider {
  Future<List<ItemModel>> getItems() async {
    final unprocessedItems =
        await FirebaseDatabase.instance.ref().child("Items").once();

    List<ItemModel> resultItems = [];

    for (var unprocessedItem in unprocessedItems.snapshot.children) {
      final itemAsJson = unprocessedItem.value as Map<Object?, Object?>;

      final title = itemAsJson['title'] as String;
      final description = itemAsJson['description'] as String;
      final imagePath = itemAsJson['imagePath'] as String;
      final isFavorite = itemAsJson['isFavorive'] == 'true';

      resultItems.add(
        ItemModel(
          title: title,
          description: description,
          imagePath: imagePath,
          isFavorite: isFavorite,
        ),
      );
    }

    return resultItems;
  }

  Future<void> updateItem(ItemModel updatingItem, bool isFavoriteNew) async {
    final unprocessedItems =
        await FirebaseDatabase.instance.ref().child("Items").once();

    String? key;
    for (var unprocessedItem in unprocessedItems.snapshot.children) {
      final itemAsJson = unprocessedItem.value as Map<Object?, Object?>;

      if (itemAsJson['title'] == updatingItem.title &&
          itemAsJson['description'] == updatingItem.description) {
        key = unprocessedItem.key;
      }
    }

    if (key == null) {
      return;
    }

    final Map<String, String> updaitedFavoriteStatus = {
      'isFavorive': isFavoriteNew.toString(),
    };

    FirebaseDatabase.instance
        .ref()
        .child("Items")
        .child(key)
        .update(updaitedFavoriteStatus);
  }
}
