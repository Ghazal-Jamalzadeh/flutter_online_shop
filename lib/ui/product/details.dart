import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/common/utils.dart';
import 'package:flutter_online_shop/data/product.dart';
import 'package:flutter_online_shop/theme.dart';
import 'package:flutter_online_shop/widgets/image.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text('افزودن به سبد خرید'),
          ),
        ),
        body: CustomScrollView(
          physics: defaultScrollPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(imageUrl: product.imageUrl),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.caption!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.withPriceLabel),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                        'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود'),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کاربران',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextButton(onPressed: () {}, child: Text('ثبت نظر'))
                      ],
                    ),
                    Container(
                      color: Colors.blue,
                      height: 1000,
                      width: 300,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
