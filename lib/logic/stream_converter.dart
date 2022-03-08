//TODO: поресерчить как это нормально делается

// class StreamConverter {
//   //Используется при обновлении карты с активным заказом
//   static LatLng? convertOrderToLatLng(Order order) => order.executor?.position;
//
//   static Set<Marker> convertLatLngListToMarkersSet(List<LatLng> list) {
//     Set<Marker> _markers = Set();
//
//     for (int i = 0; i < list.length; i++) {
//       _markers.add(Marker(
//         markerId: MarkerId(Uuid().v1()),
//         position: list[i],
//         draggable: false,
//         zIndex: 2,
//         flat: true,
//         anchor: Offset(0.5, 1.0),
//         icon: BitmapDescriptor.defaultMarker, //TODO: свою иконку добавить!
//       ));
//     }
//
//     return _markers;
//   }
//
//   static Set<Marker> convertOrderListToMarkersSet(List<Order> orders) {
//     List<LatLng> list = [];
//     for (int i = 0; i < orders.length; i++) {
//       if (orders[i].executor?.position != null)
//         list.add(orders[i].executor!.position!);
//     }
//
//     return convertLatLngListToMarkersSet(list);
//   }
// }
