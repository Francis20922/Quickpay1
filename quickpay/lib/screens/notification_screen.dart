import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample notifications list
  List<Map<String, String>> _notifications = [
    {
      'title': 'Payment Successful',
      'body': 'You have paid ₦2,000 to Electricity Bill',
      'time': '2 hours ago',
    },
    {
      'title': 'Top Up Completed',
      'body': 'Your wallet was topped up with ₦5,000',
      'time': '1 day ago',
    },
    {
      'title': 'Loan Approved',
      'body': 'Your loan application has been approved',
      'time': '3 days ago',
    },
  ];

  void _clearNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.teal,
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Clear All',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear All Notifications?'),
                    content: const Text('Are you sure you want to delete all notifications?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _clearNotifications();
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? const Center(child: Text('No notifications', style: TextStyle(fontSize: 16)))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.teal),
                  title: Text(notification['title']!),
                  subtitle: Text(notification['body']!),
                  trailing: Text(
                    notification['time']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () {
                    // Handle tap on notification (e.g., open detail)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: ${notification['title']}')),
                    );
                  },
                );
              },
            ),
    );
  }
}
