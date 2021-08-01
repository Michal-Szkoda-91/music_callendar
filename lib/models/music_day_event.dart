class MusicEvent {
  int id;
  double playTime;
  String date;
  String note;
  bool canByOmmited;

  MusicEvent(
      {required this.id,
      required this.playTime,
      required this.date,
      required this.note,
      required this.canByOmmited});

  factory MusicEvent.fromDatabaseJson(Map<String, dynamic> data) => MusicEvent(
        id: data['id'],
        playTime: data['playTime'],
        date: data['date'],
        note: data['note'],
        canByOmmited: data['canByOmmited'] == 0 ? false : true,
      );
  Map<String, dynamic> toDatabaseJson() => {
        'id': this.id,
        'playTime': this.playTime,
        'date': this.date,
        'note': this.note,
        'canByOmmited': this.canByOmmited == false ? 0 : 1,
      };
}
