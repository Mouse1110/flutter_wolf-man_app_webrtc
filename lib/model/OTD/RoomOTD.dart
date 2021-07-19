class RoomOTD {
  final String name;
  final int max;
  final int index;
  RoomOTD({this.index, this.max, this.name});

  RoomOTD.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        max = json['max'],
        index = json['index'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'max': max,
        'index': index,
      };
}
