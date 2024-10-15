abstract class Serializable {
  Map<String, dynamic> toJson();
  T fromJson<T extends Serializable>(dynamic json);
}
