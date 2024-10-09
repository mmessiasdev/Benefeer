import 'package:Benefeer/view/account/auth/signin.dart';
import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Lista de textos ou conteúdo para as páginas do tutorial
  final List<Widget> _pages = [
    TutorialPage(
      title: 'Bem-vindo ao Benefeer!',
      description: 'Aqui você pode acompanhar seus benefícios de forma fácil.',
      image: Icons.account_balance,
    ),
    TutorialPage(
      title: 'Gerencie suas contas',
      description: 'Tenha controle completo sobre seus gastos e economias.',
      image: Icons.monetization_on_outlined,
    ),
    TutorialPage(
      title: 'Relatórios em tempo real',
      description:
          'Receba atualizações e relatórios automáticos em tempo real.',
      image: Icons.analytics_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial"),
      ),
      body: Column(
        children: [
          Expanded(
            // PageView para exibir as páginas do tutorial
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          // Botão para avançar para a próxima página ou finalizar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão "Voltar"
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text("Voltar"),
                  ),
                Spacer(),
                // Botão "Próximo" ou "Concluir"
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      // Se for a última página, finalize o tutorial
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    } else {
                      // Caso contrário, vá para a próxima página
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(_currentPage == _pages.length - 1
                      ? "Concluir"
                      : "Próximo"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para exibir o conteúdo de cada página do tutorial
class TutorialPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData? image;

  const TutorialPage({
    Key? key,
    required this.title,
    required this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/illustrator/illustrator1.png"),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
