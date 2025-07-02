import 'package:equatable/equatable.dart';

import '../catalog/item.dart';

class CartLine extends Equatable {
  final Item item;
  final int quantity;
  final double discount;

  const CartLine({
    required this.item,
    required this.quantity,
    required this.discount,
  });

  double get lineNet => item.price * quantity * (1 - discount);

  CartLine copyWith({int? quantity, double? discount}) {
    return CartLine(
      item: item,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object?> get props => [item, quantity, discount];
}

class CartTotals extends Equatable {
  final double subtotal;
  final double vat;
  final double grandTotal;

  const CartTotals({
    required this.subtotal,
    required this.vat,
    required this.grandTotal,
  });

  @override
  List<Object?> get props => [subtotal, vat, grandTotal];
}
