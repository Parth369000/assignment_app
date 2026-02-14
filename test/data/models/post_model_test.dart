import 'package:assignment_app/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostModel', () {
    test('fromJson should return a valid model', () {
      final json = {
        'userId': 1,
        'id': 101,
        'title': 'Test Title',
        'body': 'Test Body',
        'description': 'Test Description', // DummyJSON uses description
        'thumbnail': 'https://example.com/image.png',
        'price': 9.99,
        'rating': 4.5,
      };

      final model = PostModel.fromJson(json);

      expect(model.userId, 1);
      expect(model.id, 101);
      expect(model.title, 'Test Title');
      expect(model.body, 'Test Description'); // Should map description to body
      expect(model.thumbnail, 'https://example.com/image.png');
      expect(model.price, 9.99);
      expect(model.rating, 4.5);
    });

    test('toJson should return a JSON map containing proper data', () {
      final model = PostModel(
        userId: 1,
        id: 101,
        title: 'Test Title',
        body: 'Test Body',
        thumbnail: 'https://example.com/image.png',
        price: 9.99,
        rating: 4.5,
      );

      final json = model.toJson();

      expect(json['userId'], 1);
      expect(json['id'], 101);
      expect(json['title'], 'Test Title');
      expect(json['description'], 'Test Body');
      expect(json['thumbnail'], 'https://example.com/image.png');
      expect(json['price'], 9.99);
      expect(json['rating'], 4.5);
    });

    test('fromJson should handle null values gracefully', () {
      final json = {
        'userId': null,
        'id': null,
        'title': null,
        'body': null,
        'thumbnail': null,
        'price': null,
        'rating': null,
      };

      final model = PostModel.fromJson(json);

      expect(model.userId, 0);
      expect(model.id, 0);
      expect(model.title, '');
      expect(model.body, '');
      expect(model.thumbnail, '');
      expect(model.price, 0.0);
      expect(model.rating, 0.0);
    });
  });
}
