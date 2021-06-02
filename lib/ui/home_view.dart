import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryplet_app/net/api_methods.dart';
import 'package:cryplet_app/net/flutterfire.dart';
import 'package:cryplet_app/ui/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'add_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  double litecoin = 0.0;
  double dogecoin = 0.0;
  double polkadot = 0.0;
  double dash = 0.0;
  double cardano = 0.0;
  double ripple = 0.0;
  double monacoin = 0.0;

  @override
  initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    litecoin = await getPrice("litecoin");
    dogecoin = await getPrice("dogecoin");
    polkadot = await getPrice("polkadot");
    dash = await getPrice("dash");
    cardano = await getPrice("cardano");
    ripple = await getPrice("ripple");
    monacoin = await getPrice("monacoin");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else if (id == 'tether') {
        return (tether * amount).toStringAsFixed(2);
      } else if (id == 'litecoin') {
        return (litecoin * amount).toStringAsFixed(2);
      } else if (id == 'dogecoin') {
        return (dogecoin * amount).toStringAsFixed(2);
      } else if (id == 'polkadot') {
        return (polkadot * amount).toStringAsFixed(2);
      } else if (id == 'dash') {
        return (dash * amount).toStringAsFixed(2);
      } else if (id == 'cardano') {
        return (cardano * amount).toStringAsFixed(2);
      } else if (id == 'ripple') {
        return (ripple * amount).toStringAsFixed(2);
      } else if (id == 'monacoin') {
        return (monacoin * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xff00bfdb),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                        "${"${document.id[0].toUpperCase()}${document.id.substring(1)}"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Center(
                                    child: Text("${document.data()['Amount']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                        "\€${getValue(document.id, document.data()['Amount'])}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () async {
                                    await removeCoin(document.id);
                                  },
                                ),
                              ],
                            )));
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: Container(
        child: _getFAB(context),
      ),
    );
  }
}

Widget _getFAB(context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 22),
    backgroundColor: Color(0xff00bfdb),
    visible: true,
    curve: Curves.bounceIn,
    children: [
      // FAB 1
      SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Color(0xff00bfdb),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddView(),
              ),
            );
          },
          label: 'Add coins',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color(0xff00bfdb)),
      // FAB 2
      SpeedDialChild(
          child: Icon(Icons.close),
          backgroundColor: Color(0xff00bfdb),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Authentication(),
              ),
            );
          },
          label: 'Log out',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color(0xff00bfdb)),

      SpeedDialChild(
          child: Icon(Icons.refresh),
          backgroundColor: Color(0xff00bfdb),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
            );
          },
          label: 'Refresh',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color(0xff00bfdb))
    ],
  );
}
