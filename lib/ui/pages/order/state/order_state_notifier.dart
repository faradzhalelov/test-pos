import 'order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderStateNotifier extends StateNotifier<OrderState> {
  OrderStateNotifier() : super(OrderState());

  updateOrder() {}

  deleteOrder() {}
}
