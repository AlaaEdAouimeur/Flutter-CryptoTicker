import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
 String SelectedCurency = 'USD';
  List<DropdownMenuItem<String>> getitems(){
    int i;
      List<DropdownMenuItem<String>> dropdownItems = [
     
      ];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }
 cupertino(){
  List<Widget> texts = [];
   for (String currency in currenciesList){
     Widget text = Text(currency);
     texts
     .add(text);
   }
   return texts;
}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              children: cupertino(),
              itemExtent: 30,
              onSelectedItemChanged: (value){
                 setState(() {
                    SelectedCurency = currenciesList[value];
                  print(SelectedCurency);
                 });
              },

            )
             /*DropdownButton<String>(
              hint: Text('pick'),
              items: getitems(),
              value: SelectedCurency,
              icon: Icon(Icons.playlist_add_check,color: Colors.white,),
              iconSize: 50,
              onChanged: (value){
            setState(() {
              SelectedCurency = value;
            });
              },
            )*/
          ),
        ],
      ),
    );
  }
}
