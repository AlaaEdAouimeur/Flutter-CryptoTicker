import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Color clr = Color(0xff414345);
  String SelectedCurency = 'USD';
  CoinData coinData;
  List<Map> Prices;
  bool isloading = false;
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
  Widget getarow(double changes,Color color , Icon icon){
    return Row(
      children: <Widget>[
        icon,
        Text('${changes.toStringAsFixed(1)}%',
        style: TextStyle(color: color),
        )
      ],
    );
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
    isloading = true;
    
    List _Prices = await coinData.Getdata(SelectedCurency);
    setState(() {
      Prices = _Prices;
      isloading = false;
    });
    
  }

  void getdata() async {
    
    isloading = true;

    Prices = await coinData.Getdata(SelectedCurency);
     setState(() {
       isloading = false;
     });
  }

  @override
  void initState() {
print(Prices);
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
   Color arrowcolor;
   Icon arrowicon;
    if (Prices['changes']['percent']['hour'] < 0){
      arrowcolor = Colors.red;
    arrowicon= Icon(Icons.arrow_drop_down);

    }
    else {
      arrowcolor = Colors.green;
    arrowicon= Icon(Icons.arrow_drop_up);
    }
    
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
          Expanded(
                      child: Card(
              color: clr,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    
                    Text(
                      '1 $Cypto = ${Prices['last']} $SelectedCurency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    getarow(Prices['changes']['percent']['hour'], arrowcolor, arrowicon),
                  ],
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
    return isloading 

          ? 
          Stack(
            children: <Widget>[
         Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('🤑 Coin Ticker'),
              backgroundColor: clr,
            ),
            body: Center(
            child: Container(color: Colors.transparent,
            child: spinkit.SpinKitChasingDots(color: Colors.blue,),),
          ),
          ),
         
            ]
          )
          


        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('🤑 Coin Ticker'),
              backgroundColor: clr,
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
                    height: 100.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 20.0),
                    color: clr,
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
