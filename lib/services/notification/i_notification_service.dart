abstract class INotificationService {
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  });
}

