import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/error_view.dart';
import 'package:srv_test/widgets/items_list_view.dart';
import 'package:srv_test/widgets/loading_view.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.read(favoritesProvider.notifier).fetchData(ref);

    final items = ref.watch(fetchItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.itemsTitle),
      ),
      body: items.when(
        data: (items) => ItemsListView(items: items, ref: ref),
        error: (error, _) => ErrorView(error: error),
        loading: () => const LoadingView(),
      ),
    );
  }
}
