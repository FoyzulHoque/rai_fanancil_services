class CashflowTrendResponse {
  final int statusCode;
  final bool success;
  final String message;
  final List<Datum> data;
  final Map<String, dynamic> stats;

  CashflowTrendResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.stats,
  });

  factory CashflowTrendResponse.fromJson(Map<String, dynamic> json) {
    return CashflowTrendResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'stats': stats,
  };
}

/// ✅ Single point model used everywhere
class Datum {
  final String date; // e.g. "Jan"
  final double value; // can be int or double from API, we store as double

  Datum({
    required this.date,
    required this.value,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      date: json['date'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "value": value,
  };
}

/// ✅ If other parts of your UI already reference CashflowTrendPoint,
/// keep this alias so you don't refactor code everywhere.
typedef CashflowTrendPoint = Datum;
