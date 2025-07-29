import 'package:flutter/material.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedNetwork = 'MTN';

  final List<String> _networks = ['MTN', 'Airtel', 'Glo', '9mobile'];

  void _buyAirtime() {
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text;
      final amount = _amountController.text;
      final network = _selectedNetwork;

      // You can replace this with actual logic to process airtime purchase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Buying ₦$amount airtime for $phone on $network'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buy Airtime")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                value: _selectedNetwork,
                items: _networks.map((network) {
                  return DropdownMenuItem(
                    value: network,
                    child: Text(network),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedNetwork = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Network Provider'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _buyAirtime,
                child: const Text('Buy Airtime'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}