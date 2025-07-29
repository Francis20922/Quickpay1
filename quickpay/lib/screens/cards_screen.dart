import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  // Mock card data
  final List<Map<String, String>> cards = const [
    {
      'cardNumber': '**** **** **** 1234',
      'cardHolder': 'John Doe',
      'expiryDate': '08/26',
    },
    {
      'cardNumber': '**** **** **** 5678',
      'cardHolder': 'Jane Smith',
      'expiryDate': '11/24',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Cards"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Handle add card action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Add card tapped")),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.credit_card, size: 36),
              title: Text(card['cardNumber']!),
              subtitle: Text("${card['cardHolder']} • Exp: ${card['expiryDate']}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Handle delete card action
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Delete card ${card['cardNumber']}")),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}