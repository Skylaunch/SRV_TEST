import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/item_card.dart';

class ItemsListView extends StatelessWidget {
  const ItemsListView({super.key, required this.items, required this.ref});

  final List<ItemModel> items;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];

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
          );
  }
}
