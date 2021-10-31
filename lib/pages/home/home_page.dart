import 'package:election_exit_poll_620710128/pages/vote/votelists.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  VoteMenu? _currentPage = VoteMenu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/images/vote_hand.png',
                    height: 50,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "EXIT POLL",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    ' ',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    ' ',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'เลือกตั้ง อบต.',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    ' ',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    'รายชื่อผู้สมัครรับเลือกตั้ง',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'นายกองค์การบริหารส่วนตำบลเขาพระ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'อำเภอเมืองนครนายก จังหวัดนครนายก',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              Container(
                child: SafeArea(
                  child: _buildSubPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _buildSubPage() {
    switch (_subPageIndex) {
      case 0:
        return _currentPage;
      default:
        return null;
    }
  }

  void _showSubPage(BuildContext context, int page) {
    setState(() {
      _subPageIndex = page;
      _currentPage = page == 0 ? VoteMenu() : null;
    });
  }
}
