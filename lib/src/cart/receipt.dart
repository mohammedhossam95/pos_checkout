import 'package:pos_checkout_core/src/cart/bloc/cart_bloc.dart';

class Receipt {
  final DateTime timestamp;
  final List<ReceiptLine> lines;
  final double subtotal;
  final double vat;
  final double grandTotal;

  const Receipt({
    required this.timestamp,
    required this.lines,
    required this.subtotal,
    required this.vat,
    required this.grandTotal,
  });
}

class ReceiptLine {
  final String name;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double lineTotal;

  const ReceiptLine({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.lineTotal,
  });
}

Receipt buildReceipt(CartState state, DateTime now) {
  final receiptLines =
      state.lines.map((line) {
        return ReceiptLine(
          name: line.item.name,
          quantity: line.quantity,
          unitPrice: line.item.price,
          discount: line.discount,
          lineTotal: double.parse(line.lineNet.toStringAsFixed(2)),
        );
      }).toList();

  return Receipt(
    timestamp: now,
    lines: receiptLines,
    subtotal: state.totals.subtotal,
    vat: state.totals.vat,
    grandTotal: state.totals.grandTotal,
  );
}
