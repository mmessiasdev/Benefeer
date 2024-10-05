import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/padding.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/component/widgets/searchInput.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        // Alterei ListView para Column
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            child: SearchInput(),
          ),
          Expanded(
            // Envolvi o widget que você quer expandir com Expanded
            child: Container(
              decoration: BoxDecoration(color: PrimaryColor),
              child: Padding(
                padding: defaultPadding,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: SecudaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Center(
                                    child: SubText(
                                        text: "Farmácias",
                                        align: TextAlign.start),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: Opacity(
                                    opacity: .50,
                                    child: Image.network(
                                      "https://unex.edu.br/wp-content/uploads/2022/07/farmacia-scaled-1920x990.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: SecudaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Center(
                                  child: SubText(
                                      text: "Farmácias",
                                      align: TextAlign.start),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: OffColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: SecudaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Center(
                                  child: SubText(
                                      text: "Farmácias",
                                      align: TextAlign.start),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: OffColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Continue com seus outros widgets...
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
