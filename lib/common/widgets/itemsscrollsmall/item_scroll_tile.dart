import 'package:flutter/material.dart';

class ItemScrollTile extends StatelessWidget {
  const ItemScrollTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 109, 97, 60),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 300,
            width: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/homeImage.jpeg", fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 5),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  5,
                  (index) => const Icon(Icons.star, color: Colors.amberAccent, size: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
