import 'package:community/data/remote/data_providers/my_dio.dart';
import 'package:dio/dio.dart';

class NotificationApi {
  Future notificationApi({required String title, required String body}) async {
    try {
      Response response = await MyDio.postData(
          endPoint: 'https://fcm.googleapis.com/fcm/send',
          data: {
            "to":
                "dwR8NQhaR6WS0CWFAUzy2W:APA91bG5EI59LG8sIlBkRvXE5EqKlHDFF0E-WrEZ3vmfxKMcrFF2mLIG57ilpVBFWmDb9GJXzCYyqeG7_fMiGIxYqngtABPLJCpQhJlPN0hrcbmycSWxjDJ-GNoUrt-3vabMj3528kzN",
            "notification": {
              "title": title,
              "body": body,
              "sound": "default",
              "android_channel_id": "id"
            }
          });
      print(response.data['type']);
    } catch (error) {
      print('error$error');
    }
  }
}
