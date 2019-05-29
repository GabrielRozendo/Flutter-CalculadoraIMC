import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe o peso e a altura";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe o peso e a altura";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      debugPrint(imc.toString());
      String imcPrecision = imc.toStringAsPrecision(4);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso ($imcPrecision)";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal  ($imcPrecision)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso ($imcPrecision)";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau 1 ($imcPrecision)";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau 2 ($imcPrecision)";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau 3 ($imcPrecision)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 120, color: Colors.green),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso (kg)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25),
                        controller: weightController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o peso!";
                          }
                        }),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            labelStyle: TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25),
                        controller: heightController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira a altura!";
                          }
                        }),
                    Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 10),
                        child: Container(
                            height: 50,
                            child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _calculate();
                                  }
                                },
                                color: Colors.green,
                                child: Text(
                                  "Calcular",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )))),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    )
                  ],
                ))));
  }
}
