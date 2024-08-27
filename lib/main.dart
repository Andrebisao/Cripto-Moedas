import 'package:flutter/material.dart';
import 'package:flutter_application_1/paginas/paginaInicial.dart';
import 'package:flutter_application_1/repositorio/repositorioFavorito.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RepositorioFavorito(),
      child: const MeuAplicativo(),
    ),
  );
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Moedasbase',
      debugShowCheckedModeBanner: false,
      home: PaginaInicial(),
    );
  }
}
