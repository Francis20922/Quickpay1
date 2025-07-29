import 'package:flutter/material.dart';
import 'package:quickpay/screens/send_money_screen.dart';
import 'package:quickpay/screens/setting_screen.dart';
import 'package:quickpay/screens/top_up_screen.dart';
import 'package:quickpay/screens/bills_screen.dart';
import 'package:quickpay/screens/scan_screen.dart';
import 'package:quickpay/screens/airtime_screen.dart';
import 'package:quickpay/screens/cards_screen.dart';
import 'package:quickpay/screens/history_screen.dart';
import 'package:quickpay/screens/loan_screen.dart';
import 'package:quickpay/screens/betting_screen.dart';
import 'package:quickpay/screens/notification_screen.dart';  // <-- Import NotificationScreen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': Icons.send, 'label': 'Send', 'screen': const SendMoneyScreen()},
      {'icon': Icons.account_balance_wallet, 'label': 'Top Up', 'screen': const TopUpScreen()},
      {'icon': Icons.receipt, 'label': 'Bills', 'screen': const BillsScreen()},
      {'icon': Icons.qr_code_scanner, 'label': 'Scan', 'screen': const ScanScreen()},
      {'icon': Icons.phone_android, 'label': 'Airtime', 'screen': const AirtimeScreen()},
      {'icon': Icons.credit_card, 'label': 'Cards', 'screen': const CardsScreen()},
      {'icon': Icons.monetization_on, 'label': 'Loan', 'screen': const LoanScreen()},
      {'icon': Icons.sports_esports, 'label': 'Betting', 'screen': const BettingScreen()},
    ];

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text("QuickPay", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          // Notification Icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3', // Example notification count
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_pic.png'),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Hi, Nonso!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.teal.shade200, blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Wallet Balance", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text(
                      "₦125,450.00",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _quickAction(context, Icons.send, "Send", const SendMoneyScreen()),
                _quickAction(context, Icons.account_balance_wallet, "Top Up", const TopUpScreen()),
                _quickAction(context, Icons.receipt, "Pay Bills", const BillsScreen()),
                _quickAction(context, Icons.history, "History", const HistoryScreen()),
              ],
            ),
            const SizedBox(height: 24),

            const Text("Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return _serviceCard(
                  context,
                  services[index]['icon'] as IconData,
                  services[index]['label'] as String,
                  services[index]['screen'] as Widget,
                );
              },
            ),
            const SizedBox(height: 24),

            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.teal),
              title: const Text("Paid Electricity Bill"),
              subtitle: const Text("₦5,000 - 2 days ago"),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.teal),
              title: const Text("Loan Repayment"),
              subtitle: const Text("₦20,000 - 5 days ago"),
              trailing: const Icon(Icons.access_time, color: Colors.orange),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  static Widget _quickAction(BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal.shade100,
            radius: 28,
            child: Icon(icon, size: 28, color: Colors.teal),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _serviceCard(BuildContext context, IconData icon, String label, Widget screen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.teal, size: 30),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
