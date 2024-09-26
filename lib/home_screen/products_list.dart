

import 'package:flutter/material.dart';
import 'package:sesame/home_screen/product_list_item.dart';
import 'package:sesame/models/product_model.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.modelList});
  final List<ProductModel>modelList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(13.0),
      itemCount: modelList.length,
      itemBuilder: (context,index){
        return ProductListItem(model: modelList[index]);
      },
    );
  }
}
