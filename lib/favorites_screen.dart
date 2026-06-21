import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:subspace_relay_mobile/services/favorites.dart';

class FavoritesScreen extends HookConsumerWidget {
  final String currentBrokerUrl;
  final String currentDiscoveryPublicKey;
  final String currentName;

  const FavoritesScreen({
    super.key,
    this.currentBrokerUrl = '',
    this.currentDiscoveryPublicKey = '',
    this.currentName = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add favorite',
            onPressed: () => _showAddDialog(context, ref),
          ),
        ],
      ),
      body: favorites.when(
        data: (entries) => entries.isEmpty
            ? Center(child: Text('No favorites yet.\nTap + to add one.', textAlign: TextAlign.center))
            : ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Dismissible(
                    key: Key(entry.id),
                    direction: DismissDirection.endToStart,
                    background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 16), child: Icon(Icons.delete, color: Colors.white)),
                    onDismissed: (_) => ref.read(favoritesListProvider.notifier).remove(entry.id),
                    child: ListTile(
                      leading: Icon(Icons.star, color: Colors.amber),
                      title: Text(entry.name, overflow: TextOverflow.ellipsis),
                      subtitle: Text(Uri.tryParse(entry.brokerUrl)?.host ?? entry.brokerUrl, style: Theme.of(context).textTheme.bodySmall),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, size: 20),
                        onPressed: () => _showEditDialog(context, ref, entry),
                      ),
                      onTap: () => Navigator.pop(context, entry),
                    ),
                  );
                },
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Failed to load favorites')),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final host = Uri.tryParse(currentBrokerUrl)?.host ?? currentBrokerUrl;
    final nameTextController = TextEditingController(text: currentName.isNotEmpty ? currentName : host);
    final brokerTextController = TextEditingController(text: currentBrokerUrl);
    final discoveryTextController = TextEditingController(text: currentDiscoveryPublicKey);

    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add Favorite'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameTextController, autofocus: true, decoration: InputDecoration(labelText: 'Name')),
                SizedBox(height: 8),
                TextField(controller: brokerTextController, decoration: InputDecoration(labelText: 'Broker URL')),
                SizedBox(height: 8),
                TextField(controller: discoveryTextController, decoration: InputDecoration(labelText: 'Discovery Public Key')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Save')),
          ],
        ),
      );

      if (result == true && nameTextController.text.isNotEmpty) {
        await ref.read(favoritesListProvider.notifier).add(
              name: nameTextController.text,
              brokerUrl: brokerTextController.text,
              discoveryPublicKey: discoveryTextController.text,
            );
      }
    } finally {
      nameTextController.dispose();
      brokerTextController.dispose();
      discoveryTextController.dispose();
    }
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref, Favorite entry) async {
    final nameTextController = TextEditingController(text: entry.name);
    final brokerTextController = TextEditingController(text: entry.brokerUrl);
    final discoveryTextController = TextEditingController(text: entry.discoveryPublicKey);

    try {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Favorite'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameTextController, decoration: InputDecoration(labelText: 'Name')),
                SizedBox(height: 8),
                TextField(controller: brokerTextController, decoration: InputDecoration(labelText: 'Broker URL')),
                SizedBox(height: 8),
                TextField(controller: discoveryTextController, decoration: InputDecoration(labelText: 'Discovery Public Key')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Save')),
          ],
        ),
      );

      if (result == true) {
        await ref.read(favoritesListProvider.notifier).updateFavorite(
              entry.copyWith(
                name: nameTextController.text.isNotEmpty ? nameTextController.text : entry.name,
                brokerUrl: brokerTextController.text,
                discoveryPublicKey: discoveryTextController.text,
              ),
            );
      }
    } finally {
      nameTextController.dispose();
      brokerTextController.dispose();
      discoveryTextController.dispose();
    }
  }
}
