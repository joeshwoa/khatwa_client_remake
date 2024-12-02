import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static StreamController<int> streamController =
      StreamController<int>.broadcast();

  static int counter = 0;
  static Stream<int> get not => streamController.stream;

  // Initialize Firebase Messaging and request permission
  static Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    configureForegroundMessaging();
    firebaseNotificationHandler();
    subscribeToTopic('advertisement');
  }

  // Get the device token for push notifications
  static Future<String> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        return token;
      } else {
        log("Token is null");
        return "";
      }
    } catch (error) {
      log(error.toString());
      return "";
    }
  }

  // Configure callback for handling incoming messages when the app is in the foreground
  static void configureForegroundMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notification = message.notification!;
        final title = notification.title ?? '';
        final body = notification.body ?? '';
        counter++;
        streamController.add(counter);
        Get.snackbar(title, body);
      }
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    counter++;
    streamController.add(counter);
  }

  // Subscribe to a topic
  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  static firebaseNotificationHandler() {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {
        _handleNotification(message);
      }
    });
  }

  static void _handleNotification(RemoteMessage message) {}

  static Future<String> getAccessToken() async {
    try {
      final accountCredentials = ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "khatwa-49223",
        "private_key_id": "e6e8c3584c7e5b5912925ca65fa8f5e507fca7fe",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4q8WK11eT6HlY\nMW3QjrFfFLGGrnDS+E0HYY+JSAf9/40eeaM24vlqwvTc4JolIT4pKtB9AdMin9cu\ncd3pZr7vHxOembmtHochxQ51Y9YSnIItj6p4Y4JAPEcPr3zfr/Poy12+Y74UowxG\n4yxebzg9dTDrLefITFZ6HkB0vTCoHRHgBlX8KfbYpPz3Q6NrHmVEyMSFMrjoQLa/\ndBp2AabuGbP7z85kTnTXaU022uyNXepa34e0aeaHFzOkAfgi3mAuIrzTANEl8Rws\nZ4jpAZ+hqG5RN60ByhERS6yEeqA17Kzy+82ivHayMXV//pUxeWdNSUsUDKkKLzDq\nIDoYIHaPAgMBAAECggEAV40EOgdO224fPVsty28jE0dNxOLl1XdnmYS81qJiO57Q\n6i5T3V0tT1q/WQpYuhqxDDZioqlfTm6GR1wvj4ypH9fVZt9NopAzE6UHbksXPjqa\nEvymHq5anZaWQA78PlZ+ZhMoTe+eucz1MJRaQCkteiGZwB3C4fijFQFLoKzjKQfT\nU0/DesjVNKv0/Lyaf674oTl8spXmcbgf9kJCZDm7RF2dMokaYK58CA1kq6FjWGJ3\nFeK2D+as8CwOjetaq73HOyBb72QN11DIYK3L6p4UdEBaOYq7MUnwsoXFu7GW7g1f\nX5CfV6qRTRr2ZNUYgWwjxod2pQYlTFs+HRqvIdLy+QKBgQD2zYy+GoarC3sDZ6qr\njK+TXPP4cR9PiIDciV+abeWWdcc3jaHYDwQnp/aWb0u2JEY4J2wrrcQ9SUluCnqN\nBmNiZHJlDQXofte3MKpQAZFkQt+jJ5Z5yOJTIY8jsgKXM3Kx1FIDhlPSr0VQRbrX\nYKXgWEPpwpcgoiX1H1Y8ezvlCQKBgQC/jX7hasADrKAiO5avGuKUdIATsrtDT7xY\nVfCSQMl09+i/AtsQHrKVvIbO0D5B2kpE8uBnPR+jLbRF/kv0ViGk8rYyRzsDUgTV\n8/0WsOLHT/8Q9XVpBmFuyz6m5FAHMzFxSNtbqRExXjU4UuzNKlqF1c3qaqTzndJy\nR7LqHD081wKBgEyimvdUyUhHclUmVYqbTtGVZXRZu/04R7szNOqBAW9s9wU7B2xN\njV66+wjPWlUegmdhZmdRt8PIA/MVceRkfWvKAPN7zb/Z0yXhCKF7OyhE06iX3FPI\nmu5xVz8gQUmuAglSAn1xsomTPxSj8lZ6fkdhYQUvFTpe3yZ0KpTxNzHxAoGAbwjx\nJG+BsF+PT2ilNwlpj85cM47mN+VvcvEWC2Ecpf3SX26jVxvEP0HSDu3tOLT1WjRD\nWfS3cxpaJjx7AL4wsHG0pT5e+dTAUtkkutN8ETbQzp7KGUAGmHed8JXlwdat8VHf\nPamp+qj2RpjjBSZo5K2DuD9rMIAqbe4bytLluG8CgYEAzLXlo7QhKI+b6x2Pc2BM\nUD+U6e2bG0JWHQsgykCfIeozf1Zf9PJ5qpsmJlgDt8b2fSNTw1b0pkYhgYR+4ndi\nj/Uym9rNNqd8aAvqFpegkezTEv7GZA57x8XhtnMCIRWY0UMFXRSuYjj88K3VDh4M\nXOwPfePAkXSRVW4WDVusEjo=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fq69c@khatwa-49223.iam.gserviceaccount.com",
        "client_id": "109014809282061149527",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fq69c%40khatwa-49223.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      });

      final scopes = ["https://www.googleapis.com/auth/firebase.messaging"];
      final client = http.Client();
      try {
        final accessCredentials =
            await obtainAccessCredentialsViaServiceAccount(
          accountCredentials,
          scopes,
          client,
        );

        final accessToken = accessCredentials.accessToken.data;
         log('Access Token: $accessToken');
        return accessToken;
      } catch (e) {
        log('Error obtaining access token: $e');
        return '';
      } finally {
        client.close();
      }
    } catch (e) {
      log('Error loading service account JSON: $e');
      return '';
    }
  }

  static Future<void> sendNotification({
    required String title,
    required String body,
  }) async {
    final token = await FirebaseMessagingService.getDeviceToken();

    final accessToken = await getAccessToken();
    if (accessToken.isNotEmpty) {
      print(accessToken);
      return;
    }
    final response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/khatwa-49223/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(
        {
          'message': {
            'token': token,
            'notification': {
              'title': title,
              'body': body,
            },
            'android': {
              'priority': 'high',
              'notification': {
                'sound': 'default',  // Use default notification sound for Android
              },
            },
          },
        },
      ),
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
  }
}
