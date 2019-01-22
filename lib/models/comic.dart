/// Model class for an XKCD comic.
class Comic {
  final String month;
  final int number;
  final String link;
  final String year;
  final String news;
  final String safeTitle;
  final String transcript;
  final String altText;
  final String image;
  final String title;
  final String day;

  Comic({
    this.month,
    this.number,
    this.link,
    this.year,
    this.news,
    this.safeTitle,
    this.transcript,
    this.altText,
    this.image,
    this.title,
    this.day,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      month: json['month'],
      number: json['num'],
      link: json['link'],
      year: json['year'],
      news: json['news'],
      safeTitle: json['safe_title'],
      transcript: json['transcript'],
      altText: json['alt'],
      image: json['img'],
      title: json['title'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "month": month,
      "num": number,
      "link": link,
      "year": year,
      "news": news,
      "safe_title": safeTitle,
      "transcript": transcript,
      "alt": altText,
      "img": image,
      "title": title,
      "day": day,
    };
  }

  @override
  bool operator ==(other) {
    return other is Comic
        && this.month == other.month
        && this.number == other.number
        && this.link == other.link
        && this.year == other.year
        && this.news == other.news
        && this.safeTitle == other.safeTitle
        && this.transcript == other.transcript
        && this.altText == other.altText
        && this.image == other.image
        && this.title == other.title
        && this.day == other.day;
  }

  @override
  int get hashCode => super.hashCode;
}
