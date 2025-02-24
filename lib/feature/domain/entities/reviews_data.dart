import 'package:yourscooks/feature/domain/entities/reviews.dart';

class ReviewsData {
  List<Reviews> reviews;
  dynamic lastDocument;

  ReviewsData({required this.reviews, this.lastDocument});
}
