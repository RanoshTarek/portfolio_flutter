const String TASK_NEW = 'new';
const String TASK_DONE = 'done';
const String TASK_ARCHIVE = 'archive';
const String IS_DARK_THEME_MODE = 'is_dark_theme_mode';
const String AUTHORIZATION = 'Authorization';
const String TOKEN = 'token';
const String API_KEY = '57af90325f2347258585551fd42d0475';
const String isSkipOnBoardingScreen = 'is_skip_on_boarding_screen';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
