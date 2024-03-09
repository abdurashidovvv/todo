class Note {
  String title;
  String description;
  String date;

  Note({required this.title, required this.description, required this.date});

  toJson() {
    return {"title": title, "description": description, "date": date};
  }
}
