import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/user_model.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/item_card.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key, required this.currentUser});

  final UserModel? currentUser;

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = ref.watch(fetchItemsProvider(true));

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.favoritesTitle),
      ),
      body: favoritesProvider.when(
        data: (data) {
          return data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];

                    return ListTile(
                      title: ItemCard(
                        currentUser: widget.currentUser,
                        item: item,
                        onUnfavoriteCustomTap: () {
                          setState(() {
                            data.remove(item);
                          });
                        },
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
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
