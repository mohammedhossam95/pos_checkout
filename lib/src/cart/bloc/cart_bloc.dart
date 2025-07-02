import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_checkout_core/src/cart/models.dart';
import 'package:pos_checkout_core/src/catalog/item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.empty()) {
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<ChangeQty>(_onChangeQty);
    on<ChangeDiscount>(_onChangeDiscount);
    on<ClearCart>(_onClearCart);
  }

  void _onAddItem(AddItem event, Emitter<CartState> emit) {
    final lines = List<CartLine>.from(state.lines);
    final index = lines.indexWhere((line) => line.item.id == event.item.id);

    if (index != -1) {
      final updated = lines[index].copyWith(
        quantity: lines[index].quantity + 1,
      );
      lines[index] = updated;
    } else {
      lines.add(CartLine(item: event.item, quantity: 1, discount: 0));
    }

    emit(CartState(lines: lines, totals: _calculateTotals(lines)));
  }

  void _onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    final lines =
        state.lines.where((line) => line.item.id != event.item.id).toList();
    emit(CartState(lines: lines, totals: _calculateTotals(lines)));
  }

  void _onChangeQty(ChangeQty event, Emitter<CartState> emit) {
    final lines =
        state.lines.map((line) {
          return line.item.id == event.item.id
              ? line.copyWith(quantity: event.quantity)
              : line;
        }).toList();
    emit(CartState(lines: lines, totals: _calculateTotals(lines)));
  }

  void _onChangeDiscount(ChangeDiscount event, Emitter<CartState> emit) {
    final lines =
        state.lines.map((line) {
          return line.item.id == event.item.id
              ? line.copyWith(discount: event.discount)
              : line;
        }).toList();
    emit(CartState(lines: lines, totals: _calculateTotals(lines)));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState.empty());
  }

  CartTotals _calculateTotals(List<CartLine> lines) {
    final subtotal = lines.fold(0.0, (sum, line) => sum + line.lineNet);
    final vat = subtotal * 0.15;
    final grandTotal = subtotal + vat;

    return CartTotals(
      subtotal: double.parse(subtotal.toStringAsFixed(2)),
      vat: double.parse(vat.toStringAsFixed(2)),
      grandTotal: double.parse(grandTotal.toStringAsFixed(2)),
    );
  }
}
