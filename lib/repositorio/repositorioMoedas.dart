import 'package:flutter_application_1/modelos/moedas.dart';

class RepositorioMoedas {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'assets/bitcoin.jpg',
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 364983.09,
    ),
    Moeda(
      icone: 'assets/Ethereum.jpg',
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 18238.08,
    ),
    Moeda(
      icone: 'assets/Litecoin1.jpg',
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 397.49,
    ),
    Moeda(
      icone: 'assets/USDCoin.jpg',
      nome: 'USD Coin',
      sigla: 'USDC',
      preco: 5.65,
    ),
    Moeda(
      icone: 'assets/XRP.jpg',
      nome: 'XRP',
      sigla: 'XRP',
      preco: 3.56,
    ),
    Moeda(
      icone: 'assets/Cardano.jpg',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 2.21,
    ),
  ];
}
