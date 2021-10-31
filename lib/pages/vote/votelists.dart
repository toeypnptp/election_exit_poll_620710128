import 'package:election_exit_poll_620710128/pages/vote/voteres.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteMenu extends StatefulWidget {
  const VoteMenu({Key? key}) : super(key: key);

  @override
  _VoteMenuState createState() => _VoteMenuState();
}

class _VoteMenuState extends State<VoteMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(width: 500, height: 400, child: VoteScore()),
          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(350, 45),
              primary: Colors.yellow,
            ),
            child: Text('ดูผล',
                style: TextStyle(
                    fontSize: 20.0, color: Colors.black)),
          )
        ],
      ),
    );
  }
}
