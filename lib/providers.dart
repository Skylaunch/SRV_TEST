import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/data_providers/items_data_provider.dart';
import 'package:srv_test/data_providers/users_data_provider.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/models/user_model.dart';

// Load data async
final fetchItemsProvider = FutureProvider((ref) {
  return ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider))
      .getItems(false);
});

final fetchFavoritesProvider = FutureProvider((ref) {
  return ref.watch(favoritesProvider);
});

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotivier, UserModel?>((ref) {
  return CurrentUserNotivier(ref.read(usersDataProvider).getCurrentUser());
});

// Work with user and items
class CurrentUserNotivier extends StateNotifier<UserModel?> {
  CurrentUserNotivier(super.state);

  void setUser(WidgetRef ref) {
    state = ref.watch(usersDataProvider).getCurrentUser();
  }
}

final usersDataProvider = Provider<UsersDataProvider>((ref) {
  return UsersDataProvider();
});

final itemsDataProvider = Provider<ItemsDataProvider>((ref) {
  return ItemsDataProvider(usersDataProvider: ref.read(usersDataProvider));
});

// Work with favorites
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

  void updateFavorites(ItemModel changingItem) {
    state = state.contains(changingItem)
        ? state.where((item) => item != changingItem).toList()
        : (state..add(changingItem));
  }
}
