import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/data_providers/items_data_provider.dart';
import 'package:srv_test/data_providers/users_data_provider.dart';
import 'package:srv_test/models/item_model.dart';

final usersDataProvider = Provider<UsersDataProvider>((ref) {
  return UsersDataProvider();
});

final itemsDataProvider = Provider<ItemsDataProvider>((ref) {
  return ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider));
});

final itemsProvider =
    StateNotifierProvider<ItemsNotifier, List<ItemModel>>((ref) {
  return ItemsNotifier();
});

class ItemsNotifier extends StateNotifier<List<ItemModel>> {
  ItemsNotifier() : super([]);
  Future<List<ItemModel>> getItems(WidgetRef ref, bool isFavoritesOnly) async {
    return ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider))
        .getItems(isFavoritesOnly);
  }

  updateFavoriteStatus(ItemModel changingItem) {
    List<ItemModel> resultState = [];

    for (var item in state) {
      if (changingItem != item) {
        resultState.add(item);
      } else {
        resultState.add(item.copyWith());
      }
    }

    state = resultState;
  }
}

final currentUserProvider = Provider.autoDispose((ref) {
  return ref.watch(usersDataProvider).getCurrentUser();
});
