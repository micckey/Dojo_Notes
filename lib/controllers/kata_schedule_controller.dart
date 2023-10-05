import 'package:dojonotes/models/scheduled_kata_model.dart';
import 'package:get/get.dart';

class KataScheduleController extends GetxController {
  List<ScheduledKata> kataList = [
    ScheduledKata('Heian Shodan'),
    ScheduledKata('Heian Nidan'),
    ScheduledKata('Heian Sandan'),
    ScheduledKata('Heain Yondan'),
    ScheduledKata('Heain Godan'),
    ScheduledKata('Tekki Shodan'),
    ScheduledKata('Tekki Nidan'),
    ScheduledKata('Tekki Sandan'),
    ScheduledKata('Bassai Dai'),
    ScheduledKata('Bassai Sho'),
    ScheduledKata('Jion'),
    ScheduledKata('Jiin'),
    ScheduledKata('Jitte'),
    ScheduledKata('Chinte'),
    ScheduledKata('Enpi'),
    ScheduledKata('Kanku Sho'),
    ScheduledKata('Kanku Dai'),
    ScheduledKata('Sochin'),
    ScheduledKata('Sochin'),
    ScheduledKata('Gojushiho Sho'),
    ScheduledKata('Gojushiho Dai'),
    ScheduledKata('Nijushiho'),
    ScheduledKata('Gankaku'),
    ScheduledKata('Wankan'),
    ScheduledKata('Unsu'),
    ScheduledKata('Hangetsu'),
    ScheduledKata('Meikyo')
  ].obs;

  List<String> selectedKatas = [];

  void toggleSelection(int index) {
    kataList[index].isSelected.value = !kataList[index].isSelected.value;

    if (kataList[index].isSelected.value) {
      selectedKatas.add(kataList[index].name);
    } else {
      selectedKatas.remove(kataList[index].name);
    }
  }
}
