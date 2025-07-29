import 'package:flutter/material.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedBillType = 'Electricity';

  // Added more bill types
  final List<String> _billTypes = [
    'Electricity',
    'Water',
    'Internet',
    'Cable TV',
    'Gas',
    'Phone',
    'Property Tax',
    'Garbage Collection',
  ];

  void _payBill() {
    if (_formKey.currentState!.validate()) {
      final account = _accountController.text;
      final amount = _amountController.text;
      final billType = _selectedBillType;

      // Simulate payment logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paying ₦$amount for $billType (Account: $account)')),
      );
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay Bills")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedBillType,
                items: _billTypes.map((bill) {
                  return DropdownMenuItem(
                    value: bill,
                    child: Text(bill),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBillType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Bill Type'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _accountController,
                decoration: const InputDecoration(labelText: 'Account Number / Customer ID'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a valid account ID' : null,
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _payBill,
                child: const Text("Pay Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
