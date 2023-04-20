import 'package:flutter/material.dart';
import 'package:flutterdemo/values/styles.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 400,
                child: Hero(
                    tag: "ProductImage",
                    child: Image.asset(
                      "assets/images/shirt.png",
                      fit: BoxFit.contain,
                    ))),
            Text('Product Detail',style: AppStyles.titleText,),
          ],
        ),
      ),
    );
  }
}
