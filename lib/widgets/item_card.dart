import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/main.dart';
import 'package:srv_test/models/item_model.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.item});

  final ItemModel item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.item.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.item.title),
            trailing: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return InkWell(
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.red,
                  ),
                  onTap: () {
                    ref.read(itemsDataProvider).updateItem(
                          widget.item,
                          !isFavorite,
                        );

                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                );
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
                  return const Center(child: Text('Loading...'));
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
}
