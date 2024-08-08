import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/main.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/widgets/item_card.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('items_screen_title'),
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: ref.watch(itemsDataProvider).getItems(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (!snapshot.hasData || index >= (snapshot.data?.length ?? 0)) {
                return null;
              }

              final item = snapshot.data![index];

              return ListTile(
                title: ItemCard(
                  item: item,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
