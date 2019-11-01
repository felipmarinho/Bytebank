import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      body: FormularioTransferencia(),
    ),
  );
  }
}
      
class FormularioTransferencia extends StatelessWidget{

final TextEditingController _controladorCampoNumeroConta = TextEditingController();
final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário de transferência'),),
      body: Column(
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
            onPressed: () => _criarTransferencia(),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _criarTransferencia() {
    final int _numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double _valor = double.tryParse(_controladorCampoValor.text);
    if(_numeroConta != null && _valor != null) {
      final Transferencia _transferenciaCriada = Transferencia(_valor, _numeroConta);
      debugPrint('$_transferenciaCriada');
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

class ListaTransferencia extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    return Scaffold( 
      appBar: AppBar(title: Text('Transferências'),),
      body: Column(
      children: <Widget>[
        ItemTransferencia(Transferencia(100.0, 1000)),
        ItemTransferencia(Transferencia(600.0, 1000)),
        ItemTransferencia(Transferencia(200.0, 1000)),
        ItemTransferencia(Transferencia(1230.0, 2000)),
      ],
    ),
    floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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