import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({required this.title, required this.amount, required this.date});
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Move mock data inside the build method
    final List<Transaction> transactions = [
      Transaction(title: 'Groceries', amount: 45.99, date: DateTime(2025, 6, 10)),
      Transaction(title: 'Electric Bill', amount: 90.00, date: DateTime(2025, 6, 9)),
      Transaction(title: 'Internet', amount: 30.50, date: DateTime(2025, 6, 8)),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Transaction History")),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            title: Text(tx.title),
            subtitle: Text("${tx.date.toLocal()}".split(' ')[0]),
            trailing: Text("\$${tx.amount.toStringAsFixed(2)}"),
          );
        },
      ),
    );
  }
}
