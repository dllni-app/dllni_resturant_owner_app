part of 'orders_bloc.dart';

class OrdersState {
  BlocStatus? rejectOrderStatus;
  RejectOrderModel? rejectOrder;
  BlocStatus? acceptOrderStatus;
  AcceptOrderModel? acceptOrder;
  BlocStatus? changeOrderStatusStatus;
  OwnerOrderDetailsModel? statusChangedOrder;
  PaginationStateModel<GetOrdersModelDataItem>? orders;
  GetOrdersModel? homePreparingOrders;
  BlocStatus? homePreparingOrdersStatus;
  OwnerOrderDetailsModel? orderDetails;
  BlocStatus? orderDetailsStatus;
  BlocStatus? orderItemMutationStatus;
  String? currentStatus;
  String? errorMessage;

  OrdersState({
    this.errorMessage,
    this.orders = const PaginationStateModel(perPage: 20),
    this.acceptOrder,
    this.acceptOrderStatus,
    this.rejectOrder,
    this.rejectOrderStatus,
    this.changeOrderStatusStatus,
    this.statusChangedOrder,
    this.homePreparingOrders,
    this.homePreparingOrdersStatus,
    this.orderDetails,
    this.orderDetailsStatus,
    this.orderItemMutationStatus,
    this.currentStatus,
  });

  OrdersState copyWith({
    String? errorMessage,
    PaginationStateModel<GetOrdersModelDataItem>? orders,
    AcceptOrderModel? acceptOrder,
    BlocStatus? acceptOrderStatus,
    RejectOrderModel? rejectOrder,
    BlocStatus? rejectOrderStatus,
    BlocStatus? changeOrderStatusStatus,
    OwnerOrderDetailsModel? statusChangedOrder,
    GetOrdersModel? homePreparingOrders,
    BlocStatus? homePreparingOrdersStatus,
    OwnerOrderDetailsModel? orderDetails,
    BlocStatus? orderDetailsStatus,
    BlocStatus? orderItemMutationStatus,
    String? currentStatus,
    bool setCurrentStatus = false,
  }) => OrdersState(
    errorMessage: errorMessage ?? this.errorMessage,
    orders: orders ?? this.orders,
    acceptOrder: acceptOrder ?? this.acceptOrder,
    acceptOrderStatus: acceptOrderStatus ?? this.acceptOrderStatus,
    rejectOrder: rejectOrder ?? this.rejectOrder,
    rejectOrderStatus: rejectOrderStatus ?? this.rejectOrderStatus,
    changeOrderStatusStatus: changeOrderStatusStatus ?? this.changeOrderStatusStatus,
    statusChangedOrder: statusChangedOrder ?? this.statusChangedOrder,
    homePreparingOrders: homePreparingOrders ?? this.homePreparingOrders,
    homePreparingOrdersStatus: homePreparingOrdersStatus ?? this.homePreparingOrdersStatus,
    orderDetails: orderDetails ?? this.orderDetails,
    orderDetailsStatus: orderDetailsStatus ?? this.orderDetailsStatus,
    orderItemMutationStatus: orderItemMutationStatus ?? this.orderItemMutationStatus,
    currentStatus: setCurrentStatus ? currentStatus : this.currentStatus,
  );
}
