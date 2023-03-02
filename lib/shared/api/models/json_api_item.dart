class JsonApiItem {
  String id;
  String type;
  Map<String, dynamic> attributes;

  JsonApiItem({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory JsonApiItem.fromMap(Map<String, dynamic> data) => JsonApiItem(
    id: data['id'],
    type: data['type'],
    attributes: data['attributes'],
  );
}