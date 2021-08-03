class MusicEvent {
  String id;
  int playTime;
  int targetTime;
  String note;

  MusicEvent({
    required this.id,
    required this.playTime,
    required this.targetTime,
    required this.note,
  });

  factory MusicEvent.fromDatabaseJson(Map<String, dynamic> data) => MusicEvent(
        id: data['id'],
        playTime: data['playTime'],
        targetTime: data['targetTime'],
        note: data['note'],
      );
  Map<String, dynamic> toDatabaseJson() => {
        'id': this.id,
        'playTime': this.playTime,
        'targetTime': this.targetTime,
        'note': this.note,
      };
}
