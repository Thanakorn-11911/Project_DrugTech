class Drugs {
  List<String> images;
  String brandName;
  String genericName;
  String letter;
  String benefit;
  String description;
  String shapeId;
  String statusId;
  String sizedId;
  String drugTypeId;
  String drugRegistrationTypeId;
  String id;

  Drugs({
    this.brandName,
    this.genericName,
    this.letter,
    this.benefit,
    this.description,
    this.drugRegistrationTypeId,
    this.drugTypeId,
    this.images,
    this.shapeId,
    this.sizedId,
    this.statusId,
    this.id,
  });

  factory Drugs.fromJson(Map<String, dynamic> map, {String id}) => Drugs(
        id: id,
        brandName: map["brandName"],
        genericName: map["genericName"],
        letter: map["letter"],
        benefit: map["benefit"],
        description: map["description"],
        drugRegistrationTypeId: map["drugRegistrationTypeId"],
        drugTypeId: map["drugTypeId"],
        images: map["images"].map<String>((i) => i as String).toList(),
        shapeId: map["shapeId"],
        sizedId: map["sizedId"],
        statusId: map["statusId"],
      );

  Drugs copyWith({
    List<String> images,
    String brandName,
    String genericName,
    String letter,
    String benefit,
    String description,
    String shapeId,
    String statusId,
    String sizedId,
    String drugTypeId,
    String drugRegistrationTypeId,
    String id,
  }) {
    return (Drugs(
        images: images ?? this.images,
        brandName: brandName ?? this.brandName,
        genericName: genericName ?? this.genericName,
        letter: letter ?? this.letter,
        benefit: benefit ?? this.benefit,
        description: description ?? this.description,
        shapeId: shapeId ?? this.shapeId,
        statusId: statusId ?? this.statusId,
        sizedId: sizedId ?? this.sizedId,
        drugTypeId: drugTypeId ?? this.drugTypeId,
        drugRegistrationTypeId:
            drugRegistrationTypeId ?? this.drugRegistrationTypeId,
        id: id ?? this.id));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "images": images,
      "brandName": brandName,
      "genericName": genericName,
      "letter": letter,
      "benefit": benefit,
      "description": description,
      "drugRegistrationTypeId": drugRegistrationTypeId,
      "drugTypeId": drugTypeId,
      "shapeId": shapeId,
      "sizedId": sizedId,
      "statusId": statusId
    };
  }
}

//enum DrugColor { red, yellow, blck }
