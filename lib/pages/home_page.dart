import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/pages/deposit_page.dart';
import 'package:portfolio/pages/send_page.dart';
import 'package:portfolio/pages/transaction_page.dart';
import 'package:portfolio/pages/withdraw_page.dart';
import 'package:portfolio/providers.dart';
import 'package:portfolio/utils.dart';
import 'package:portfolio/widgets/my_button.dart';
import 'package:portfolio/widgets/my_card.dart';
import 'package:portfolio/widgets/my_list_tile.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(userModelStateNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF008284),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Good morning',
              style: TextStyle(
                fontSize: 13,
                letterSpacing: .6,
                color: Colors.white70.withOpacity(.5)
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              'Odunayo Agboola',
              style: TextStyle(
                letterSpacing: .7,
                color: Colors.white70.withOpacity(1)
              ),
            )
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell,
                color: Colors.white70,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFF008284)
            ),
          ),
          Column(
            children: <Widget>[
              MyCard(
                balance: userProvider.balance.toString().formatToPrice,
                phoneNumber: userProvider.phoneNumber,
                color: Colors.blue,
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <MyButton>[
                  MyButton(
                    iconImagePath: 'icons/send-money.png',
                    buttonText: 'Send',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendPage(),
                      ),
                    ),
                  ),
                  MyButton(
                    iconImagePath: 'icons/deposit.png',
                    buttonText: 'Deposit',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DepositPage(),
                      ),
                    ),
                  ),
                  MyButton(
                    iconImagePath: 'icons/money-withdrawal.png',
                    buttonText: 'withdraw',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WithDrawPage(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                  child: Text(
                    'Transaction history',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      letterSpacing: .6
                    ),
                  ),
                ),
              ),

              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        tabs: const <Tab>[
                          Tab(text: 'All', height: 38.0),
                          Tab(text: 'Credits', height: 38.0),
                          Tab(text: 'Debits', height: 38.0),
                        ],
                      ),

                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            ListView.separated(
                              itemCount: transactions.length,
                              separatorBuilder: (_, __) => const Divider(height: 0.0),
                              itemBuilder: (BuildContext context, int index) {
                                final data = transactions.elementAt(index);
                                final transaction = Transaction.fromJson(data);
                                return TransactionListTile(
                                  transaction: transaction,
                                );
                              },
                            ),
                            const Center(
                              child: Text('Tab 2 Content'),
                            ),
                            const Center(
                              child: Text('Tab 3 Content'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final transactions = [
  {
    'description': 'Send Money to My Wife',
    'amount': '\$25.00',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'description': 'Received from Eric R.',
    'amount': '\$96.00',
    'type': 'credit',
    'date': '22 October 2023, 9:16AM'
  },
  {
    'description': 'Pocket allowance',
    'amount': '\$100.00',
    'type': 'credit',
    'date': '22 October 2023, 12:45AM'
  },
  {
    'description': 'Send Money to Janet G.',
    'amount': '\$118.00',
    'type': 'debit',
    'date': '22 October 2023, 1:10PM'
  },
  {
    'description': 'Send Money to Bakong A',
    'amount': '\$1,200.00',
    'type': 'debit',
    'date': '23 October 2023, 11:16PM'
  },
  {
    'description': 'Pocket allowance',
    'amount': '\$100.00',
    'type': 'credit',
    'date': '24 October 2023, 10:15AM'
  },
  {
    'description': 'Transfer to own account',
    'amount': '\$150.00',
    'type': 'debit',
    'date': '24 October 2023, 8:28AM'
  },
  {
    'description': 'Payment from POS',
    'amount': '\$82.99',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'description': 'Payment for Electricity bill',
    'amount': '\$152.52',
    'type': 'debit',
    'date': '21 October 2023, 11:16PM'
  },
  {
    'description': 'October Salary',
    'amount': '\$152.52',
    'type': 'credit',
    'date': '21 October 2023, 11:16PM'
  },
];
