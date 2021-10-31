import 'package:election_exit_poll_620710128/api.dart';
import 'package:election_exit_poll_620710128/models/voteitem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteScore extends StatefulWidget {
  const VoteScore({Key? key}) : super(key: key);

  @override
  _VoteScoreState createState() => _VoteScoreState();
}

class _VoteScoreState extends State<VoteScore> {
  late Future<List<VoteItem>> _futureVoteLists;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<VoteItem>>(

        future: _futureVoteLists,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ผิดพลาด: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureVoteLists = _loadVoteLists();
                      });
                    },
                    child: Text('RETRY'),
                  ),
                ],
              ),
            );
          }

          if (_isLoading) {
            return Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var itemm = snapshot.data![index];

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    onTap: () => _ppppp(itemm.number),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.greenAccent,
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: Text('${itemm.number}')),
                                    ),
                                    Text(
                                      ('${itemm.title}${itemm.firstName} ${itemm.lastName}'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [

            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _vote(int id) async {
    try {
      var data = (await Api().submit('exit_poll', {'candidateNumber': id}));
      return data.toString();
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _ppppp(int id) async {
    var data = await _vote(id);
    _showMaterialDialog('SUCCESS', 'บันทึกข้อมูลสำเร็จ $data');
  }

  Future<List<VoteItem>> _loadVoteLists() async {
    List list = await Api().fetch('exit_poll');
    var voteList = list.map((item) => VoteItem.fromJson(item)).toList();
    return voteList;
  }

  @override
  initState() {
    super.initState();

    _futureVoteLists = _loadVoteLists();
  }
}
