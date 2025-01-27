import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/modelos/moedas.dart';
import 'package:intl/intl.dart';

class PaginaDetalhesMoedas extends StatefulWidget {
  Moeda moeda;
  PaginaDetalhesMoedas({Key? key, required this.moeda}) : super(key: key);

  @override
  State<PaginaDetalhesMoedas> createState() => _PaginaDetalhesMoedasState();
}

class _PaginaDetalhesMoedasState extends State<PaginaDetalhesMoedas> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  comprar() {
    if (_form.currentState!.validate()) {
      //salvar a compra

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Compra realizada com sucesso!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.moeda.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: Image.asset(widget.moeda.icone),
                ),
                Container(
                  width: 10,
                ),
                Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800]),
                )
              ],
            ),
          ),
          const Divider(color: Colors.transparent),
          (quantidade > 0)
              ? SizedBox(
                  width: 370,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 17),
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: Colors.teal.withOpacity(0.05)),
                    child: Text(
                      '$quantidade ${widget.moeda.sigla}',
                      style: const TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 24),
                ),
          SizedBox(
            width: 370,
            child: Form(
              key: _form,
              child: TextFormField(
                  controller: _valor,
                  style: const TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    labelText: 'Valor',
                    hintText: 'R\$',
                    prefixIcon: const Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.green,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.justify,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o valor da compra';
                    } else if (double.parse(value) < 50) {
                      return 'Compra mínima é R\$ 50,00';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quantidade = (value.isEmpty)
                          ? 0
                          : (double.parse(value) / widget.moeda.preco);
                    });
                  }),
            ),
          ),
          Container(
            width: 250,
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 24),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: comprar,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
