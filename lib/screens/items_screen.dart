import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/user_model.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/item_card.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key, required this.currentUser});
  final UserModel? currentUser;

  @override
  Widget build(BuildContext context, ref) {
    final items = ref.watch(fetchItemsProvider(false));

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.itemsTitle),
      ),
      body: items.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];

              return ListTile(
                title: ItemCard(
                  currentUser: currentUser,
                  item: item,
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
