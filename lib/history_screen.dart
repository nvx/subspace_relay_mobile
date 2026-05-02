import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:subspace_relay_mobile/services/history.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(connectionHistoryProvider);

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('History')),
      body: history.when(
        data: (entries) => entries.isEmpty
            ? Center(child: Text('No history yet'))
            : ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  final host = Uri.tryParse(entry.brokerUrl)?.host ?? entry.brokerUrl;
                  return Dismissible(
                    key: Key(entry.id),
                    direction: DismissDirection.endToStart,
                    background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 16), child: Icon(Icons.delete, color: Colors.white)),
                    onDismissed: (_) => ref.read(connectionHistoryProvider.notifier).remove(entry.id),
                    child: ListTile(
                      title: Text(entry.name, overflow: TextOverflow.ellipsis),
                      subtitle: Text('${entry.mode.displayName} · $host\n${DateFormat('MMM d, h:mm:ss a').format(entry.timestamp)}', style: Theme.of(context).textTheme.bodySmall),
                      isThreeLine: true,
                      trailing: entry.log.isNotEmpty ? Icon(Icons.article_outlined, size: 18) : null,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _HistoryDetailScreen(entry: entry))),
                    ),
                  );
                },
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Failed to load history')),
      ),
    );
  }
}

class _HistoryDetailScreen extends StatelessWidget {
  final HistoryEntry entry;
  const _HistoryDetailScreen({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(entry.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow('Broker', entry.brokerUrl),
              if (entry.discoveryPublicKey.isNotEmpty) _infoRow('Discovery Key', entry.discoveryPublicKey),
              if (entry.relayId.isNotEmpty) _infoRow('Relay ID', entry.relayId),
              _infoRow('Mode', entry.mode.displayName),
              _infoRow('Time', DateFormat('MMM d, y h:mm:ss a').format(entry.timestamp)),
              SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: null,
                        initialValue: entry.log.isNotEmpty ? entry.log : '(no log recorded)',
                        decoration: InputDecoration(border: InputBorder.none, labelText: 'Remote Log'),
                        readOnly: true,
                        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text('$label:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          Expanded(child: SelectableText(value, style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
