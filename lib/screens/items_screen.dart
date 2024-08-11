import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/item_card.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.read(favoritesProvider.notifier).fetchData(ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.itemsTitle),
      ),
      body: FutureBuilder(
        future: _getItems(ref),
        builder: (context, data) => data.connectionState == ConnectionState.done
            ? data.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: data.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = data.data![index];

                      return ListTile(
                        title: ItemCard(
                          item: item,
                          currentUser: ref.watch(currentUserProvider),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      AppTexts.emptyFavoritesText,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<List<ItemModel>> _getItems(WidgetRef ref) {
    return ref.watch(itemsProvider.notifier).getItems(ref);
  }
}
