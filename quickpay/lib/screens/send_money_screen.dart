import 'package:flutter/material.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedBank = 'GTBank';

  final List<String> _banks = [
    'GTBank',
    'Access Bank',
    'UBA',
    'First Bank',
    'Zenith Bank',
  ];

  void _sendMoney() {
    if (_formKey.currentState!.validate()) {
      final account = _accountController.text;
      final amount = _amountController.text;
      final bank = _selectedBank;
      final note = _noteController.text;

      // Simulate money sending logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sending ₦$amount to $account at $bank\nNote: $note'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send Money")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedBank,
                items: _banks.map((bank) {
                  return DropdownMenuItem(
                    value: bank,
                    child: Text(bank),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBank = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Bank'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Account Number'),
                validator: (value) =>
                    value == null || value.length != 10 ? 'Enter a valid 10-digit account number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount (₦)'),
                validator: (value) =>
                    value == null || value.isEmpty || double.tryParse(value) == null
                        ? 'Enter a valid amount'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note (optional)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _sendMoney,
                child: const Text('Send Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}