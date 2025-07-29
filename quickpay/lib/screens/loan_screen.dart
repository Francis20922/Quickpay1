import 'package:flutter/material.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();

  String _selectedLoanType = 'Flexi';
  String? _resultMessage;

  final Map<String, double> _interestRates = {
    'Flexi': 0.05, // 5% monthly interest
    'Cash': 0.1,   // 10% monthly interest
  };

  final Map<String, int> _maxPeriods = {
    'Flexi': 12,
    'Cash': 6,
  };

  final double _penaltyInterestRate = 0.04; // 2% penalty per month after max period

  @override
  void initState() {
    super.initState();

    // Add listeners to text fields to recalc on input change
    _amountController.addListener(_calculateLoan);
    _periodController.addListener(_calculateLoan);
  }

  void _calculateLoan() {
    final amountText = _amountController.text;
    final periodText = _periodController.text;

    if (amountText.isEmpty || periodText.isEmpty) {
      setState(() {
        _resultMessage = null; // Clear message if incomplete input
      });
      return;
    }

    final amount = double.tryParse(amountText);
    final period = int.tryParse(periodText);

    if (amount == null || amount <= 0 || period == null || period <= 0) {
      setState(() {
        _resultMessage = "Enter valid amount and repayment period.";
      });
      return;
    }

    final interestRate = _interestRates[_selectedLoanType]!;
    final maxPeriod = _maxPeriods[_selectedLoanType]!;

    final interest = amount * interestRate * period;

    double penaltyInterest = 0;
    if (period > maxPeriod) {
      final penaltyMonths = period - maxPeriod;
      penaltyInterest = amount * _penaltyInterestRate * penaltyMonths;
    }

    final totalRepayment = amount + interest + penaltyInterest;

    setState(() {
      _resultMessage =
          "Loan Type: $_selectedLoanType\n"
          "Principal: ₦${amount.toStringAsFixed(2)}\n"
          "Interest: ₦${interest.toStringAsFixed(2)}\n"
          "Penalty Interest: ₦${penaltyInterest.toStringAsFixed(2)}\n"
          "Total to Repay: ₦${totalRepayment.toStringAsFixed(2)}";
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loan Services")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Apply for a Loan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _selectedLoanType,
              items: ['Flexi', 'Cash'].map((loan) {
                return DropdownMenuItem(
                  value: loan,
                  child: Text(loan),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLoanType = value!;
                });
                _calculateLoan(); // recalc on loan type change
              },
              decoration: const InputDecoration(
                labelText: 'Select Loan Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Loan Amount (₦)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _periodController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Repayment Period (months)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            if (_resultMessage != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal),
                ),
                child: Text(
                  _resultMessage!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
