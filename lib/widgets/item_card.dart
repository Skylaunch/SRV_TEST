import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/item_model.dart';
import 'package:srv_test/models/user_model.dart';
import 'package:srv_test/providers.dart';

class ItemCard extends ConsumerStatefulWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.currentUser,
  });

  final ItemModel item;
  final UserModel? currentUser;

  @override
  ConsumerState<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends ConsumerState<ItemCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = widget.currentUser?.isItemFavorite(widget.item.key!) ?? false;

    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.item.title),
            trailing: InkWell(
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: Colors.red,
              ),
              onTap: () async {
                await _updateUser(ref);

                _updateFavorites(ref);

                ref.read(currentUserProvider.notifier).setUser(ref);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                widget.item.imagePath,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: Text(AppTexts.loading));
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(widget.item.description),
          ),
        ],
      ),
    );
  }

  Future<void> _updateUser(WidgetRef ref) async {
    return ref.read(itemsDataProvider).updateUser(widget.item);
  }

  void _updateFavorites(WidgetRef ref) {
    ref.watch(favoritesProvider.notifier).updateFavorites(widget.item);
  }
}
