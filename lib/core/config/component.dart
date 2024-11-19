class Component {
  final String type;
  final Map<String, dynamic> params;

  Component({required this.type, required this.params});

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      type: json['type'],
      params: json['params'] as Map<String, dynamic>,
    );
  }
}