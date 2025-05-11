class IndividualCourses {
  final String? error;
  final String message;
  final int status;
  final List<Data> data;
  IndividualCourses(
      {required this.error,
      required this.message,
      required this.status,
      required this.data});
}

class Data {
  final String id;
  final String title;
  final String description;
  final Price price;
  final List<Notes> notes;
  final Author author;

  Data(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.notes,
      required this.author});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        price: Price.fromJson(json['price']),
        notes: List<Notes>.from(json['notes'].map((e) => Notes.fromJson(e))),
        author: Author.fromJson(json['author']));
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'price': price.toJson(),
      'notes': notes.map((e) => e.toJson()).toList(),
      'author': author.toJson()
    };
  }
}

class Price {
  final int usd;
  final int npr;
  final String id;
  Price({required this.usd, required this.npr, required this.id});
  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(usd: json['usd'], npr: json['npr'], id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    return {'usd': usd, 'npr': npr, '_id': id};
  }
}

class Notes {
  final String name;
  final String pdf;
  final String premium;
  final String id;
  Notes(
      {required this.name,
      required this.pdf,
      required this.premium,
      required this.id});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
        name: json['name'],
        pdf: json['pdf'],
        premium: json['premiun'],
        id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'pdf': pdf, 'premium': premium, '_id': id};
  }
}

class Author {
  final String email;
  final String id;
  final String phone;
  Author({required this.email, required this.id, required this.phone});
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(email: json['email'], id: json['_id'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, '_id': id, 'phone': phone};
  }
}
