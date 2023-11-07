import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Savings account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    // letterSpacing: 1.5
                  ),
                ),
                Text(
                  '\$1,099.54',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Sort Most Recent',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey.shade500,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: ListView.separated(
              itemCount: 17,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                // Transaction transaction = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.monetization_on),
                  ), //transaction
                  title: const Text('Transfer From Wema Bank'),
                  titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700
                  ),
                  subtitle: const Text(
                    '7/11/2023',
                    style: TextStyle(
                      color: Colors.blueGrey
                    ),
                  ),
                  trailing: Text('\$23,000'), // Transaction amount
                  onTap: () {
                    // Handle onTap event (if needed)
                  },
                );
              },
            ),
          ),
        ],
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

final transactions = [
  {
    'desc': 'Send Money to My Wife',
    'amount': '\$25.00',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'Received from Eric R.',
    'amount': '\$96.00',
    'type': 'credit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'Send Money to Janet G.',
    'amount': '\$118.00',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'Send Money to Bakong A',
    'amount': '\$1,200.00',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'Transfer to own account',
    'amount': '\$150.00',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'Payment from POS',
    'amount': '\$82.99',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'Payment for Electricity bill',
    'amount': '\$152.52',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'desc': 'October Salary',
    'amount': '\$152.52',
    'type': 'credit',
    'date': '21 October 2023, 11:16PM'
  },
];
