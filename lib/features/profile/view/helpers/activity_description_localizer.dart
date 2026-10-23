/// Localizes restaurant order status tokens embedded in audit log sentences.
String localizeActivityDescription(String description) {
  const statusNames = <String, String>{
    'pending': 'بانتظار القبول',
    'accepted': 'مقبول',
    'preparing': 'قيد التحضير',
    'ready_for_pickup': 'جاهز للاستلام',
    'picked_up': 'تم الاستلام',
    'completed': 'مكتمل',
    'cancelled': 'ملغى',
    'rejected': 'مرفوض',
  };
  return description.replaceAllMapped(
    RegExp(r'\b(?:pending|accepted|preparing|ready_for_pickup|picked_up|completed|cancelled|rejected)\b'),
    (match) => statusNames[match.group(0)] ?? match.group(0)!,
  );
}
