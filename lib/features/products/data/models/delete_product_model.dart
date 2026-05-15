class DeleteProductModel {
  const DeleteProductModel();

  factory DeleteProductModel.fromJson(Map<String, dynamic> json) {
    return const DeleteProductModel();
  }

  Map<String, dynamic> toJson() => const {};
}

DeleteProductModel deleteProductModelFromJson(dynamic body) {
  if (body is Map<String, dynamic>) {
    return DeleteProductModel.fromJson(body);
  }
  return const DeleteProductModel();
}
