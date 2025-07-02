part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartLine> lines;
  final CartTotals totals;

  const CartState({required this.lines, required this.totals});

  factory CartState.empty() => CartState(
    lines: [],
    totals: const CartTotals(subtotal: 0, vat: 0, grandTotal: 0),
  );

  @override
  List<Object?> get props => [lines, totals];
}
