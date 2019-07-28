import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String SelectedCurency = 'USD';
  CoinData coinData;
  List<Map> Prices;
  List<DropdownMenuItem<String>> getitems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  cupertino() {
    List<Widget> texts = [];
    for (String currency in currenciesList) {
      Widget text = Text(currency);
      texts.add(text);
    }
    return texts;
  }

  Future update() async {
    Prices = null;
    List _Prices = await coinData.Getdata(SelectedCurency);
    setState(() {
      Prices = _Prices;
    });
  }

  void getdata() async {
    Prices = await coinData.Getdata(SelectedCurency);
  }

  @override
  void initState() {
    super.initState();
    coinData = new CoinData();
    getdata();
  }

  void Showdialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('GHel'),
          );
        });
  }

  Widget priceitem(Map Prices, String Cypto) {
    String png = Cypto.toLowerCase();
    print(png);
    return Container(
      width: 800,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Image(
                height: 70,
                width: 70,
               image: AssetImage(
                 'images/$png.png'
               ),
              ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $Cypto = ${Prices['last']} $SelectedCurency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),          
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Prices == null

          ? 
          Stack(
            children: <Widget>[
         Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('🤑 Coin Ticker'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, i) {
                      return null;
                    },
                  ),
                ),
                Container(
                    height: 150.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.lightBlue,
                    child: DropdownButton<String>(
                      hint: Text('pick'),
                      items: getitems(),
                      value: SelectedCurency,
                      iconSize: 50,
                      onChanged: (value) {
                        setState(() {
                        //  SelectedCurency = value;
                        //  update();
                        });
                      },
                    )),
              ],
            ),
          ),
          Center(
            child: Container(color: Colors.transparent,
            child: spinkit.SpinKitChasingDots(color: Colors.blue,),),
          )
            ]
          )
          
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('🤑 Coin Ticker'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: Prices.length,
                    itemBuilder: (BuildContext context, i) {
                      return priceitem(Prices[i], cryptoList[i]);
                    },
                  ),
                ),
                Container(
                    height: 150.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.lightBlue,
                    child: DropdownButton<String>(
                      hint: Text('pick'),
                      items: getitems(),
                      value: SelectedCurency,
                      iconSize: 50,
                      onChanged: (value) {
                        setState(() {
                          SelectedCurency = value;
                          update();
                        });
                      },
                    )),
              ],
            ),
          );
  }
}
