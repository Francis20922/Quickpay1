import 'package:flutter/material.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = 'Bank Transfer';

  final List<String> _methods = ['Bank Transfer', 'Card Payment', 'Wallet'];

  void _performTopUp() {
    if (_formKey.currentState!.validate()) {
      final amount = _amountController.text;
      final method = _selectedMethod;

      // Simulate top-up logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Topping up ₦$amount via $method')),
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount (₦)'),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedMethod,
                items: _methods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMethod = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Top-Up Method'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _performTopUp,
                child: const Text('Top Up Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}