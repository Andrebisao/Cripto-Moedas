import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelos/moedas.dart';
import 'package:flutter_application_1/paginas/paginaDetalhesMoedas.dart';
import 'package:flutter_application_1/repositorio/repositorioFavorito.dart';
import 'package:flutter_application_1/repositorio/repositorioMoedas.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaginasDeMoedas extends StatefulWidget {
  const PaginasDeMoedas({super.key});

  @override
  State<PaginasDeMoedas> createState() => _PaginasDeMoedasState();
}

class _PaginasDeMoedasState extends State<PaginasDeMoedas> {
  final tabela = RepositorioMoedas.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];
  late RepositorioFavorito favoritas;

  AppBarDinamic() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text(
          'Cripto Moedas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text(
          '${selecionadas.length} selecionadas',
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      );
    }
  }

  mostrarDetelhes(Moeda moeda) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => PaginaDetalhesMoedas(moeda: moeda)));
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritas = Provider.of<RepositorioFavorito>(context);
    final tabela = RepositorioMoedas.tabela;
    return Scaffold(
        appBar: AppBarDinamic(),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int moeda) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                leading: (selecionadas.contains(tabela[moeda]))
                    ? const CircleAvatar(
                        child: Icon(
                            grade: BorderSide.strokeAlignInside,
                            Icons.check,
                            color: Colors.black),
                      )
                    : SizedBox(
                        width: 60,
                        child: Image.asset(tabela[moeda].icone),
                      ),
                title: Row(
                  children: [
                    Text(
                      tabela[moeda].nome,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    if (favoritas.lista.contains(tabela[moeda]))
                      const Icon(Icons.star, color: Colors.blueAccent, size: 12)
                  ],
                ),
                trailing: Text(
                  real.format(tabela[moeda].preco),
                  style: const TextStyle(fontSize: 15),
                ),
                selected: selecionadas.contains(tabela[moeda]),
                selectedTileColor: Colors.indigo[50],
                onTap: () {
                  setState(() {
                    (selecionadas.contains(tabela[moeda]))
                        ? (selecionadas.remove(tabela[moeda]))
                        : (selecionadas.add(tabela[moeda]));
                  });
                  mostrarDetelhes(tabela[moeda]);
                },
              );
            },
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: tabela.length),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selecionadas.isNotEmpty
            ? FloatingActionButton.extended(
                backgroundColor: Colors.blue,
                onPressed: () {
                  favoritas.saveAll(selecionadas);
                  limparSelecionadas();
                },
                label: (const Text(
                  'FAVORITAR',
                  style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                icon: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              )
            : null);
  }
}
