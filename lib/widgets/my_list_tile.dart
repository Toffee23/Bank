import 'package:flutter/material.dart';

import '../models.dart';

class MyListTile extends StatelessWidget {
  final String iconImagePath;
  final String tileTitle;
  final String tileSubTitle;
  final VoidCallback? onTap;

  const MyListTile({
    super.key,
    required this.iconImagePath,
    required this.tileTitle,
    required this.tileSubTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        onTap: onTap,
        tileColor: Colors.grey.shade200,
        leading: Container(
          width: 60,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400.withOpacity(.5))),
          child: Image.asset(iconImagePath),
        ),
        title: Text(
          tileTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          tileSubTitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    Key? key,
    this.isEven = false,
    required this.transaction,
  }) : super(key: key);
  final bool? isEven;
  final TransactionHistoryModel transaction;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isEven == true ? Colors.grey.shade100 : null,
      ),
      child: ListTile(
        leading: const CircleAvatar(
            child: Text(
          '₦',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )), //transaction
        title: Text(transaction.description,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700)),
        subtitle: Text(
          transaction.date,
          style: const TextStyle(color: Colors.blueGrey),
        ),
        trailing: Text(
          '${transaction.isCredit ? '+' : '-'}₦ ${transaction.amount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaction.isCredit ? Colors.green : Colors.red),
        ),
        onTap: () {},
      ),
    );
  }
}
