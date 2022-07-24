DateTime fromGraphQLDateToDartDateTime(String date) => DateTime.parse(date);
String fromDartDateTimeToGraphQLDate(DateTime date) => date.toIso8601String();
DateTime? fromGraphQLDateNullableToDartDateTimeNullable(String? date) =>
    date == null ? null : DateTime.parse(date);
String? fromDartDateTimeNullableToGraphQLDateNullable(DateTime? date) =>
    date?.toIso8601String();
DateTime fromGraphQLTimeToDartDateTime(String time) =>
    DateTime.parse('1970-01-01T${time}Z');
String fromDartDateTimeToGraphQLTime(DateTime date) =>
    date.toIso8601String().split('T').last;
