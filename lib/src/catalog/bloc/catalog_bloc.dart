import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pos_checkout_core/src/catalog/item.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogLoading()) {
    on<LoadCatalog>((event, emit) {
      _onLoadCatalog(event, emit);
    });
  }

  Future<void> _onLoadCatalog(
    LoadCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      final jsonString = await rootBundle.loadString('assets/catalog.json');
      final items = Item.fromJsonList(jsonString);
      emit(CatalogLoaded(items));
    } catch (e) {
      emit(CatalogError("Failed to load catalog"));
    }
  }
}
