import 'package:Benefeer/component/colors.dart';
import 'package:flutter/material.dart';

class SearchDelegateScreen extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Pesquise produtos ou lojas';

  


  // Lista de sugestões de exemplo
  final List<String> suggestions = [
    "Apple",
    "Banana",
    "Orange",
    "Mango",
    "Watermelon",
    "Grapes",
    "Pineapple"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Define as ações para a barra de pesquisa (ex: limpar o texto)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ""; // Limpa a query de busca
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Define o ícone principal à esquerda da barra de pesquisa (ex: voltar)
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, ""); // Fecha a pesquisa
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Retorna os resultados da pesquisa
    final List<String> results = suggestions
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]); // Retorna o resultado selecionado
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Retorna as sugestões enquanto o usuário digita
    final List<String> filteredSuggestions = suggestions
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredSuggestions[index]),
          onTap: () {
            query = filteredSuggestions[index]; // Atualiza o texto de busca
            showResults(context); // Mostra os resultados
          },
        );
      },
    );
  }
}
