import 'package:cryplet_app/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
    "litecoin",
    "dogecoin",
    "polkadot",
    "dash",
    "cardano",
    "ripple",
    "monacoin"
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropdownValue,
            onChanged: (value) {
              setState(() {
                dropdownValue = value.toString();
              });
            },
            items: coins.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child:
                    Text("${"${value[0].toUpperCase()}${value.substring(1)}"}"),
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Amount of coins to add",
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () async {
                await addCoin(
                    dropdownValue.toLowerCase(), _amountController.text);
                Navigator.of(context)
                    .pop(); //remove this material widget from the screen and go back to original screen (home view)
              },
              child: Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
