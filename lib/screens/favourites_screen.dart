import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/main.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/widgets/item_card.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.favoritesTitle),
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: ref.watch(itemsDataProvider).getItems(true),
        builder: (context, snapshot) {
          return snapshot.data != null && snapshot.data!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (!snapshot.hasData ||
                        index >= (snapshot.data?.length ?? 0)) {
                      return null;
                    }

                    final item = snapshot.data![index];

                    return ListTile(
                      title: ItemCard(
                        onUnfavorite: () {
                          setState(() {});
                        },
                        item: item,
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
        },
      ),
    );
  }
}
