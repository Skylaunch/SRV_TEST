import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/providers.dart';
import 'package:srv_test/widgets/error_view.dart';
import 'package:srv_test/widgets/items_list_view.dart';
import 'package:srv_test/widgets/loading_view.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favortites = ref.watch(fetchFavoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.favoritesTitle),
      ),
      body: favortites.when(
          data: (items) => ItemsListView(items: items, ref: ref),
          error: (error, _) => ErrorView(error: error),
          loading: () => const LoadingView()),
    );
  }
}
