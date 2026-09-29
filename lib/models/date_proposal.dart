class DateProposal {
  final String id;
  final String title;
  final String dateTimeText;
  final String place;
  final String dressCode;
  final String memo;
  final String imageUrl;
  final bool isAccepted;

  const DateProposal({
    required this.id,
    required this.title,
    required this.dateTimeText,
    required this.place,
    required this.dressCode,
    required this.memo,
    required this.imageUrl,
    this.isAccepted = false,
  });

  DateProposal copyWith({
    String? id,
    String? title,
    String? dateTimeText,
    String? place,
    String? dressCode,
    String? memo,
    String? imageUrl,
    bool? isAccepted,
  }) {
    return DateProposal(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTimeText: dateTimeText ?? this.dateTimeText,
      place: place ?? this.place,
      dressCode: dressCode ?? this.dressCode,
      memo: memo ?? this.memo,
      imageUrl: imageUrl ?? this.imageUrl,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }
}
