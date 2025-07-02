part of 'catalog_bloc.dart';

sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Item> items;

  const CatalogLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class CatalogError extends CatalogState {
  final String message;

  const CatalogError(this.message);

  @override
  List<Object> get props => [message];
}
