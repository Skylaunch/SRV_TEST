import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/data_providers/items_data_provider.dart';
import 'package:srv_test/data_providers/users_data_provider.dart';
import 'package:srv_test/models/item_model.dart';

final usersDataProvider = Provider<UsersDataProvider>((ref) {
  return UsersDataProvider();
});

final itemsDataProvider = Provider<ItemsDataProvider>((ref) {
  return ItemsDataProvider();
});

final fetchItemsProvider =
    FutureProvider.autoDispose.family<List<ItemModel>, bool>((
  ref,
  isFavoritesOnly,
) {
  final currentUser = ref.read(usersDataProvider).getCurrentUser();
  return ref.watch(itemsDataProvider).getItems(isFavoritesOnly, currentUser);
});
