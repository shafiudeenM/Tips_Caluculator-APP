import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  int _tippercentage = 0;
  int _personcount = 1;
  double _billamount = 0.0;
  Color a = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: a,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              height: 150,
              width: 150.0,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Colors.indigo),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " \$ ${calculateTotalPerPerson(_billamount, _personcount, _tippercentage)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: Colors.indigo),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              width: 150,
              margin: EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: Colors.grey, style: BorderStyle.solid)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        // labelText: "Bill Amount",
                        prefixText: "Bill Amount :",
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String value) {
                        try {
                          _billamount = double.parse(value);
                        } catch (exception) {
                          _billamount = 0.0;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Split",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 17),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personcount > 1) {
                                    _personcount--;
                                  } else {}
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.indigo.shade100),
                                child: Center(
                                    child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )),
                              ),
                            ),
                            Text(
                              "$_personcount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Colors.indigo),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personcount++;
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.indigo.shade100),
                                child: Center(
                                    child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Tip",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 17),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "\$ ${(CalculateTopTip(_billamount, _personcount, _tippercentage)).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "$_tippercentage%",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Slider(
                            min: 0,
                            max: 100,
                            divisions: 10,
                            activeColor: Colors.indigo,
                            inactiveColor: Colors.grey,
                            value: _tippercentage.toDouble(),
                            onChanged: (double newvalue) {
                              setState(() {
                                _tippercentage = newvalue.round();
                              });
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                child: FloatingActionButton(
                  //hoverColor: Colors.red,
                  splashColor: Colors.indigo,
                  backgroundColor: Colors.indigo.shade200,
                  onPressed: () {
                    setState(() {
                      _tippercentage = 0;
                      _personcount = 1;
                      _billamount = 0.0;
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(child: Text("Developed by :Shafiudeen.M")),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitby, int tipPercentage) {
    var totalPerPerson =
        (CalculateTopTip(billAmount, splitby, tipPercentage) + billAmount) /
            splitby;
    return totalPerPerson.toStringAsFixed(2);
  }

  CalculateTopTip(double billAmount, int splitby, int tipPercentage) {
    double _totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      _totalTip = (billAmount * tipPercentage) / 100;
    }
    return _totalTip;
  }
}
