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
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'My',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cards',
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendPage(),
                      ),
                    ),
                    child: const MyButton(
                      iconImagePath: 'icons/send-money.png',
                      buttonText: 'Send',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DepositPage(),
                      ),
                    ),
                    child: const MyButton(
                      iconImagePath: 'icons/deposit.png',
                      buttonText: 'Deposit',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WithDrawPage(),
                      ),
                    ),
                    child: const MyButton(
                      iconImagePath: 'icons/money-withdrawal.png',
                      buttonText: 'withdraw',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const MyListTile(
                    iconImagePath: 'icons/analysis.png',
                    tileTitle: 'Statistics',
                    tileSubTitle: 'Payment and Income',
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionPage(
                          transactions: [],
                        ),
                      ),
                    ),
                    child: const MyListTile(
                      iconImagePath: 'icons/cash-flow.png',
                      tileTitle: 'Transactions',
                      tileSubTitle: 'Transaction History',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
