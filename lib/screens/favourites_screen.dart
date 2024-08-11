import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/item_card.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.favoritesTitle),
      ),
      body: FutureBuilder(
        future: _getItems(ref),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? snapshot.data!.isNotEmpty
                    ? FavoritesListView(favorites: snapshot.data!, ref: ref)
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
    return ref.watch(favoritesProvider.notifier).getFavorites(ref);
  }
}

class FavoritesListView extends StatelessWidget {
  const FavoritesListView({
    super.key,
    required this.favorites,
    required this.ref,
  });

  final List<ItemModel> favorites;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (BuildContext context, int index) {
        final item = favorites[index];

        return ListTile(
          title: ItemCard(
            item: item,
            currentUser: ref.watch(currentUserProvider),
          ),
        );
      },
    );
  }
}
