import 'package:flutter_test/flutter_test.dart';
import 'package:pos_checkout_core/src/cart/bloc/cart_bloc.dart';
import 'package:pos_checkout_core/src/cart/models.dart';
import 'package:pos_checkout_core/src/cart/receipt.dart';
import 'package:pos_checkout_core/src/catalog/item.dart';

void main() {
  test('buildReceipt returns correct structure and values', () {
    final item = Item(id: 'p01', name: 'Coffee', price: 10.0);

    final cartLine = CartLine(
      item: item,
      quantity: 2,
      discount: 0.1,
    ); // 10% discount
    final cartState = CartState(
      lines: [cartLine],
      totals: CartTotals(
        subtotal: 18.0, // 10 * 2 * (1 - 0.1)
        vat: 2.7,
        grandTotal: 20.7,
      ),
    );

    final now = DateTime.now();
    final receipt = buildReceipt(cartState, now);

    expect(receipt.timestamp, now);
    expect(receipt.lines.length, 1);
    expect(receipt.lines.first.name, 'Coffee');
    expect(receipt.lines.first.quantity, 2);
    expect(receipt.lines.first.unitPrice, 10.0);
    expect(receipt.lines.first.discount, 0.1);
    expect(receipt.lines.first.lineTotal, 18.0);
    expect(receipt.subtotal, 18.0);
    expect(receipt.vat, 2.7);
    expect(receipt.grandTotal, 20.7);
  });
}
