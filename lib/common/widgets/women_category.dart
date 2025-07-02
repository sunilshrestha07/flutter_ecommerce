import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/common/widgets/category_based_itemtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WomenCategory extends StatefulWidget {
  const WomenCategory({super.key});

  @override
  State<WomenCategory> createState() => _WomenCategoryState();
}

class _WomenCategoryState extends State<WomenCategory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, _) {
        final filteredItems = itemProvider.allItems
            .where((item) => item.category == "male")
            .toList();
        return Expanded(
          child: GridView.builder(
            // filter the product
            itemCount: filteredItems.length,
            // shrinkWrap: true,
            cacheExtent: 1000,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) =>
                CategoryBasedItemtile(allItems: filteredItems[index]),
          ),
        );
      },
    );
  }
}
