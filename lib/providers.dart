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

  Future<List<ItemModel>> getItems(WidgetRef ref) async {
    return ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider))
        .getItems(false);
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

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<ItemModel>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<ItemModel>> {
  FavoritesNotifier() : super([]);

  Future<void> fetchData(WidgetRef ref) async {
    state =
        await ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider))
            .getItems(true);
  }

  Future<List<ItemModel>> getFavorites(WidgetRef ref) async {
    return ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider))
        .getItems(true);
  }

  void updateFavorites(ItemModel changingItem) {
    List<ItemModel> resultFavorites = [];

    if (state.contains(changingItem)) {
      for (ItemModel item in state) {
        if (item != changingItem) {
          resultFavorites.add(item);
        }
      }

      state = resultFavorites;
    } else {
      for (ItemModel item in state) {
        resultFavorites.add(item);
      }

      resultFavorites.add(changingItem);

      state = resultFavorites;
    }
  }
}

final currentUserProvider = Provider.autoDispose((ref) {
  return ref.watch(usersDataProvider).getCurrentUser();
});
