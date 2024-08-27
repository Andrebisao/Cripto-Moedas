// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelos/moedas.dart';
import 'package:flutter_application_1/paginas/paginaDetalhesMoedas.dart';
import 'package:flutter_application_1/repositorio/repositorioFavorito.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedaCard extends StatefulWidget {
  Moeda moeda;

  MoedaCard({
    Key? key,
    required this.moeda,
  }) : super(key: key);

  @override
  State<MoedaCard> createState() => _MoedaCardState();
}

class _MoedaCardState extends State<MoedaCard> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo
  };

  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaginaDetalhesMoedas(moeda: widget.moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => abrirDetalhes(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 020, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.moeda.icone,
                height: 40,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.moeda.nome,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.moeda.sigla,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black45),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.4),
                  ),
                ),
                child: Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                      fontSize: 16,
                      color: precoColor['down'],
                      letterSpacing: -1),
                ),
              ),
              PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: ListTile(
                          title: const Text('Remover das Favoritas'),
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<RepositorioFavorito>(context,
                                    listen: false)
                                .remove(widget.moeda);
                          },
                        ))
                      ])
            ],
          ),
        ),
      ),
    );
  }
}
