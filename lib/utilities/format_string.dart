class FormatString{

  static String formatStatistic(int i){
    int len = i.toString().length;
    String text;
    if (len<=3){
      text = i.toString();
    } else if (len <=6){
      text = (i/1000).toStringAsFixed(1)+"K";
    } else {
      text = (i/1000000).toStringAsFixed(1)+"M";
    }
    return text;
  }
}