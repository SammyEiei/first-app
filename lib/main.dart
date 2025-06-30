import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jakkapan app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: "Maa",
      ),
      home: const MyHomePage(title: 'Jakkapan Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var price = TextEditingController();
  var amount = TextEditingController();
  var change = TextEditingController();
  double _total = 0;
  double _change = 0;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(children: [
        headerText(),
        SizedBox(height: 24,),
        headerImage(),
        priceTextField(),
        amountTextField(), 
        calculateButton(), 
        showTotalText(),
        receiveMoneyTextField(),
        changeCalculateButton(),
        showChangeText(),],)
          
        );
  }

  Widget headerText(){
    return Text("Calculate", style: TextStyle(
      fontFamily:"Maa", 
      fontSize: 40, 
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      color: Colors.lightBlueAccent,
      backgroundColor: Colors.grey.shade200, 
      ),);
  }

Widget headerImage(){
  return Image.asset("assets/food2.png");
}
  Widget priceTextField(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
      controller: price,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Price per item",
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      ),
    );
  }
  Widget amountTextField(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: amount,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Amount of the item",
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  Widget calculateButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if(price.text.isNotEmpty && amount.text.isNotEmpty){
            setState(() {
              _total = double.parse(price.text) * double.parse(amount.text);
            });
          }
        }, child: Text("Calculate Total")),
    );
  }

  Widget showTotalText(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Total : $_total Baht"),
    );
  }

  Widget receiveMoneyTextField(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: change,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Get Money"
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ],
      ),
    );
  }

Widget changeCalculateButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () {
        if (change.text.isNotEmpty) {
          double received = double.parse(change.text);
          if (received < _total) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("money is not enough")),
            );
          } else {
            setState(() {
              _change = received - _total;
            });
          }
        }
      },
      child: Text("Calculate Change"),
    ),
  );
}


    Widget showChangeText(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Change : $_change Baht"),
    );
  }
  
}
