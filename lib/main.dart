import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary
        )
      ),
    home: ListaTransferencia(), // FormularioTransferencia(),
  );
  }
}
      
class FormularioTransferencia extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: 'Número da conta',
              dica: '0000'
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: 'valor',
              dica: '0.00',
              icone: Icons.monetization_on
            ),
            RaisedButton(
              onPressed: () => _criarTransferencia(context),
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final int _numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double _valor = double.tryParse(_controladorCampoValor.text);
    if(_numeroConta != null && _valor != null) {
      final Transferencia transferenciaCriada = Transferencia(_valor, _numeroConta);
      debugPrint('Criando transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
final TextEditingController controlador;
final String rotulo;
final String dica;
final IconData icone;

Editor ({ this.controlador, this.rotulo, this.dica, this.icone });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controlador,
              style: TextStyle(
                fontSize: 24.0
              ),
              decoration: InputDecoration(
                icon: icone != null ? Icon(icone) : null,
                labelText: rotulo,
                hintText: dica,
              ),
              keyboardType: TextInputType.number,
            ),
          );
  }

}

class ListaTransferencia extends StatefulWidget {

  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferências'),),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
    ),
    floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () {
            final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            }));
            future.then((transferenciaRecebida) {
              Future.delayed(Duration(seconds: 2), () {
                debugPrint('chegou no then do future');
                debugPrint('$transferenciaRecebida');
                if (transferenciaRecebida != null) {
                  setState(() {
                    widget._transferencias.add(transferenciaRecebida);
                  });
                }
              });
            });
          },
        ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle : Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Tranferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}