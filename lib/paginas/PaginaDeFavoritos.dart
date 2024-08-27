import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositorio/repositorioFavorito.dart';
import 'package:flutter_application_1/widgets/moeda_card.dart';
import 'package:provider/provider.dart';

class PaginaDeFavoritos extends StatefulWidget {
  const PaginaDeFavoritos({super.key});

  @override
  State<PaginaDeFavoritos> createState() => _PaginaDeFavoritosState();
}

class _PaginaDeFavoritosState extends State<PaginaDeFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          ' Favoritas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.indigo.withOpacity(0.05),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(12.0),
          child: Consumer<RepositorioFavorito>(
            builder: (context, favoritas, child) {
              return favoritas.lista.isEmpty
                  ? const ListTile(
                      tileColor: Colors.red,
                      leading: Icon(Icons.star),
                      title: Text('Ainda não há moedas favoritas'),
                    )
                  : ListView.builder(
                      itemCount: favoritas.lista.length,
                      itemBuilder: (_, index) {
                        return MoedaCard(moeda: favoritas.lista[index]);
                      },
                    );
            },
          )),
    );
  }
}
