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
    this.onUnfavoriteCustomTap,
    required this.currentUser,
  });

  final ItemModel item;
  final VoidCallback? onUnfavoriteCustomTap;
  final UserModel? currentUser;

  @override
  ConsumerState<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends ConsumerState<ItemCard> {
  late final bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.currentUser?.isItemFavorite(widget.item.key!) ?? false;
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                _updateUser(ref);

                _updateFavoriteStatus(ref);
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

  Future<void> _updateUser(WidgetRef ref) {
    return ref.read(itemsDataProvider).updateUser(
          widget.item,
        );
  }

  void _updateFavoriteStatus(WidgetRef ref) {
    ref.watch(itemsProvider.notifier).updateFavoriteStatus(widget.item);
  }
}
