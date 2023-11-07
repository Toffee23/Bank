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
              height: 200,
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
                    color: Colors.deepPurple[400],
                  ),
                  MyCard(
                    balance: 67839.9,
                    cardNumber: 12345678,
                    expiryMonth: 02,
                    expiryYear: 20,
                    color: Colors.orange[400],
                  ),
                  MyCard(
                    balance: 093920.38,
                    cardNumber: 12345678,
                    expiryMonth: 08,
                    expiryYear: 12,
                    color: Colors.blue[400],
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
                    transactions: [],
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
