import 'package:flutter/material.dart';
import 'package:portfolio/pages/deposit_page.dart';
import 'package:portfolio/pages/send_page.dart';
import 'package:portfolio/pages/transaction_page.dart';
import 'package:portfolio/pages/withdraw_page.dart';
import 'package:portfolio/utilities/my_button.dart';
import 'package:portfolio/utilities/my_card.dart';
import 'package:portfolio/utilities/my_list_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        title: const Text('My Cards'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.monetization_on,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
                iconSize: 32,
                color: Colors.pink[200],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                physics: const BouncingScrollPhysics(), // Added physics
                children: [
                  MyCard(
                    balance: 5250.20,
                    cardNumber: 12345678,
                    expiryMonth: 10,
                    expiryYear: 24,
                    color: Colors.deepPurple.shade400,
                  ),
                  MyCard(
                    balance: 67839.9,
                    cardNumber: 12345678,
                    expiryMonth: 02,
                    expiryYear: 20,
                    color: Colors.orange.shade400,
                  ),
                  MyCard(
                    balance: 093920.38,
                    cardNumber: 12345678,
                    expiryMonth: 08,
                    expiryYear: 12,
                    color: Colors.blue.shade400,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey.shade800,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  'Services :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey
                  ),
                ),
              ),
            ),
            MyListTile(
              onTap: () {},
              iconImagePath: 'icons/analysis.png',
              tileTitle: 'Statistics',
              tileSubTitle: 'Payment and Income',
            ),
            MyListTile(
              iconImagePath: 'icons/cash-flow.png',
              tileTitle: 'Transactions',
              tileSubTitle: 'Transaction History',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionPage(
                    transactions: transactions.map((e) => Transaction.fromJson(e)).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
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
