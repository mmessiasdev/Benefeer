import 'package:Benefeer/component/buttons.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/header.dart';
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
    const TutorialPage(
      title: 'Benefeer!',
      subtitle: 'O seu app de beneficios.',
      description:
          "Desconto em lojas online e fisicas, serviços online e muito mais!",
      image: "assets/images/illustrator/illustrator1.png",
    ),
    const TutorialPage(
      title: 'Mais que um app.',
      subtitle: "Uma forma de ganhar dinheiro!",
      description:
          'Ganhe dinheiro fazendo compras e do conforto de casa. Os maiores cashbacks do mercado.',
      image: "assets/images/illustrator/illustrator2.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
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
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
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
                  child: DefaultButton(
                    text: _currentPage == _pages.length - 1
                        ? "Concluir"
                        : "Próximo",
                    color: PrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SubText(
                    text:
                        _currentPage == _pages.length - 1 ? "2 de 2" : "1 de 2",
                    align: TextAlign.center)
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
  final String? image;
  final String subtitle;

  const TutorialPage({
    Key? key,
    required this.title,
    required this.description,
    required this.subtitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: defaultPaddingHorizon,
          child: Image.asset(
            image ?? "",
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              RichDefaultText(
                align: TextAlign.start,
                text: title,
                fontweight: FontWeight.w600,
                size: 40,
                wid: SubTextSized(
                  size: 40,
                  fontweight: FontWeight.normal,
                  align: TextAlign.start,
                  text: subtitle,
                ),
              ),
              SizedBox(height: 20),
              SecundaryText(
                text: description,
                color: nightColor,
                align: TextAlign.start,
              ),
            ],
          ),
        )
      ],
    );
  }
}