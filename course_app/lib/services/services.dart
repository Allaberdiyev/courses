// services.dart

import '../model/model.dart';

class CourseService {
  List<Course> _courses = [];
  List<CartItem> _cartItems = [];
  List<Order> _orders = [];

  Future<List<Course>> getAllCourses() async {
    await Future.delayed(Duration(seconds: 2));
    return _courses;
  }

  Future<void> addCourse(Course course) async {
    _courses.add(course);
  }

  void addToCart(Course course) {
    final cartItem = _cartItems.firstWhere(
        (item) => item.course.id == course.id,
        orElse: () => CartItem(id: DateTime.now().toString(), course: course));

    if (_cartItems.contains(cartItem)) {
      cartItem.quantity++;
    } else {
      _cartItems.add(cartItem);
    }
  }

  List<CartItem> getCartItems() {
    return _cartItems;
  }

  void removeFromCart(String courseId) {
    _cartItems.removeWhere((item) => item.course.id == courseId);
  }

  void purchaseCartItems() {
    if (_cartItems.isEmpty) return;

    final order = Order(
      id: DateTime.now().toString(),
      items: List.from(_cartItems),
      totalAmount: _cartItems.fold(
          0, (sum, item) => sum + (item.course.price * item.quantity)),
      dateTime: DateTime.now(),
    );

    _orders.add(order);
    _cartItems.clear();
  }

  List<Order> getOrders() {
    return _orders;
  }

  void toggleFavorite(Course course) {
    course.isFavorite = !course.isFavorite;
  }

  List<Course> getFavoriteCourses() {
    return _courses.where((course) => course.isFavorite).toList();
  }
}
