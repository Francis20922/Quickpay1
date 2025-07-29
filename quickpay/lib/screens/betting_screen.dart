import 'package:flutter/material.dart';

class BettingScreen extends StatefulWidget {
  const BettingScreen({super.key});

  @override
  State<BettingScreen> createState() => _BettingScreenState();
}

class _BettingScreenState extends State<BettingScreen> {
  final TextEditingController amountController = TextEditingController();
  String? selectedPlatform;

  void _handlePlatformTap(String platformName) {
    setState(() {
      selectedPlatform = platformName;
    });
  }

  void _handleTopUp() {
    if (selectedPlatform == null || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a platform and enter an amount.")),
      );
      return;
    }

    // Logic to top up goes here. For now, just a success message.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Topped up ${amountController.text} to $selectedPlatform!")),
    );

    amountController.clear();
    setState(() {
      selectedPlatform = null;
    });
  }

  Widget bettingPlatformIcon(String imagePath, String label) {
    final isSelected = selectedPlatform == label;

    return GestureDetector(
      onTap: () => _handlePlatformTap(label),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? Colors.blue.shade100 : Colors.transparent,
            radius: 34,
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 30,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget bettingTransactionTile(String platform, String amount, String status) {
    return ListTile(
      leading: const Icon(Icons.sports_soccer, color: Colors.green),
      title: Text(platform),
      subtitle: Text("Amount: $amount"),
      trailing: Text(
        status,
        style: TextStyle(
          color: status == "Completed" ? Colors.green : Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Betting Services"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Top Up Your Betting Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Select Betting Platform"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bettingPlatformIcon("assets/bet9ja.png", "Bet9ja"),
                bettingPlatformIcon("assets/sportybet.png", "SportyBet"),
                bettingPlatformIcon("assets/1xbet.png", "1xBet"),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleTopUp,
              child: const Text("Top Up"),
            ),
            const SizedBox(height: 30),
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            bettingTransactionTile("Bet9ja", "₦2,000", "Completed"),
            bettingTransactionTile("SportyBet", "₦1,500", "Pending"),
          ],
        ),
      ),
    );
  }
}
