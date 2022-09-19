import 'package:flutter/material.dart';
import 'package:producteve/pages/my_account/my_account.dart';
import 'package:producteve/utils/constants.dart';
import 'package:producteve/utils/utils.dart';

class Introduction extends StatelessWidget {
  const Introduction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: gradientGlobal,
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.000000000001)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'DJ Ariful',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyAccount(),
                  ));
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1563993297290-609c9406efcd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8c3VwZXJtb2RlbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
