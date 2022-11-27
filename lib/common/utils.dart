import 'package:flutter/cupertino.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

/*روی int اعمال میشه. خروجی string داره. this به int اشاره داره */
extension PriceLabel on int {
  String get withPriceLabel => "$this تومان " ;
}
