import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pos_checkout_core/src/cart/bloc/cart_bloc.dart';
import 'package:pos_checkout_core/src/catalog/item.dart';

void main() {
  final item1 = Item(id: 'p01', name: 'Coffee', price: 10.0);
  final item2 = Item(id: 'p02', name: 'Bagel', price: 20.0);

  group('CartBloc', () {
    blocTest<CartBloc, CartState>(
      '1. Adding two items calculates correct totals',
      build: () => CartBloc(),
      act:
          (bloc) =>
              bloc
                ..add(AddItem(item1))
                ..add(AddItem(item2)),
      expect:
          () => [
            isA<CartState>()
                .having((s) => s.lines.length, 'lines length', 1)
                .having((s) => s.totals.subtotal, 'subtotal', 10.0),
            isA<CartState>()
                .having((s) => s.lines.length, 'lines length', 2)
                .having((s) => s.totals.subtotal, 'subtotal', 30.0)
                .having((s) => s.totals.vat, 'vat', 4.5)
                .having((s) => s.totals.grandTotal, 'grandTotal', 34.5),
          ],
    );

    blocTest<CartBloc, CartState>(
      '2. Quantity and discount update totals correctly',
      build: () => CartBloc(),
      act:
          (bloc) =>
              bloc
                ..add(AddItem(item1))
                ..add(ChangeQty(item1, 3))
                ..add(ChangeDiscount(item1, 0.10)), // 10% discount
      expect:
          () => [
            isA<CartState>().having((s) => s.totals.subtotal, 'subtotal', 10.0),
            isA<CartState>().having((s) => s.totals.subtotal, 'subtotal', 30.0),
            isA<CartState>()
                .having((s) => s.totals.subtotal, 'subtotal', 27.0)
                .having((s) => s.totals.vat, 'vat', 4.05)
                .having((s) => s.totals.grandTotal, 'grandTotal', 31.05),
          ],
    );

    blocTest<CartBloc, CartState>(
      '3. Clearing the cart resets state',
      build: () => CartBloc(),
      act:
          (bloc) =>
              bloc
                ..add(AddItem(item1))
                ..add(ClearCart()),
      expect:
          () => [
            isA<CartState>().having(
              (s) => s.lines.isNotEmpty,
              'has items',
              true,
            ),
            CartState.empty(),
          ],
    );
  });
}
