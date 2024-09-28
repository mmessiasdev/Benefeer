import 'package:flutter/material.dart';
import 'package:Benefeer/component/colors.dart';
import 'package:Benefeer/component/texts.dart';
import 'package:Benefeer/view/posts/post/screen.dart';

class WidgetPosts extends StatelessWidget {
  WidgetPosts(
      {super.key,
      required this.plname,
      required this.title,
      required this.desc,
      required this.updatedAt,
      required this.id});

  String plname;
  String title;
  String desc;
  String updatedAt;
  String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: GestureDetector(
        child: Container(
          // constraints: BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: PrimaryColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SubTextSized(
                      text: plname,
                      align: TextAlign.start,
                      size: 24,
                      fontweight: FontWeight.bold)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SubTextSized(
                  text: desc,
                  size: 15,
                  fontweight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          (Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostScreen(
                id: id,
              ),
            ),
          ));
        },
      ),
    );
  }
}
