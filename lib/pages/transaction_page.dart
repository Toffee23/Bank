import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionPage({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          // Transaction transaction = transactions[index];
          return ListTile(
            leading: Icon(Icons.monetization_on), // Icon for transaction
            title: Text('Transfer From Wema Bank'), // Transaction description
            subtitle: Text('7/11/2023'), // Transaction date
            trailing: Text('\$23,000'), // Transaction amount
            onTap: () {
              // Handle onTap event (if needed)
            },
          );
        },
      ),
    );
  }
}

class Transaction {
  final String description;
  final String date;
  final double amount;

  Transaction({
    required this.description,
    required this.date,
    required this.amount,
  });
}

void main() => runApp(MaterialApp(
      home: TransactionPage(
        transactions: [
          Transaction(
              description: 'Payment received',
              date: 'Oct 15, 2023',
              amount: 200.0),
          Transaction(
              description: 'Purchase at XYZ Store',
              date: 'Oct 14, 2023',
              amount: -50.0),
          // Add more transactions as needed
        ],
      ),
    ));
