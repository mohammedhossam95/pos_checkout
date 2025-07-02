part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddItem extends CartEvent {
  final Item item;

  const AddItem(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItem extends CartEvent {
  final Item item;

  const RemoveItem(this.item);

  @override
  List<Object?> get props => [item];
}

class ChangeQty extends CartEvent {
  final Item item;
  final int quantity;

  const ChangeQty(this.item, this.quantity);

  @override
  List<Object?> get props => [item, quantity];
}

class ChangeDiscount extends CartEvent {
  final Item item;
  final double discount;

  const ChangeDiscount(this.item, this.discount);

  @override
  List<Object?> get props => [item, discount];
}

class ClearCart extends CartEvent {}
