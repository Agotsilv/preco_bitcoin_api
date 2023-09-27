import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperarPreco() async {
    String uri = "https://blockchain.info/ticker";

    http.Response response = await http.get(Uri.parse(uri));
    Map<String, dynamic> obj = json.decode(response.body);
    var brl = obj["BRL"]["buy"];

    var precoFormatado =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(brl);

    setState(() {
      _preco = precoFormatado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/bitcoin.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                _preco,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _recuperarPreco,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.only(
                      left: 30, right: 30, top: 12, bottom: 12)),
              child: Text(
                "Atualizar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
