import 'package:get_time_ago/get_time_ago.dart';

class PersianTimeAgo implements Messages {
  @override
  String prefixAgo() => '';

  @override
  String suffixAgo() => 'قبل';

  @override
  String secsAgo(int seconds) => "$seconds ثانیه";

  @override
  String minAgo(int minutes) => 'یک دقیقه ';

  @override
  String minsAgo(int minutes) => "$minutes دقیقه";

  @override
  String hourAgo(int minutes) => 'یک ساعت ';

  @override
  String hoursAgo(int hours) =>"$hours ساعت";

  @override
  String dayAgo(int hours) => 'یک روز ';

  @override
  String daysAgo(int days) => "$days روز";

  @override
  String wordSeparator() => ' ';
}