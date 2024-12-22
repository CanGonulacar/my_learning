/*
ListView.builder(
  ...
  addAutomaticKeepAlives: false (true by default)
  addRepaintBoundaries: false (true by default)
-----------------------------------------------------------------

  *addAutomaticKeepAlives:

Etkinleştirildiğinde, ListView içindeki öğelerin durumlarını korur. Yani, görünüm alanından çıktıktan sonra bile öğelerin durumunu saklar.

Avantajı: Kullanıcı listeyi kaydırdığında ve önceki öğelere geri döndüğünde, bu öğelerin durumları korunmuş olur.
Dezavantajı: Daha fazla bellek kullanımına neden olabilir, çünkü her öğenin durumu saklanır.

  *addRepaintBoundaries:

Etkinleştirildiğinde, her liste öğesi için ayrı bir "repaint boundary" (yeniden boyama sınırı) oluşturur.

Avantajı: Bir öğe değiştiğinde, sadece o öğenin yeniden çizilmesini sağlar. Bu, özellikle büyük listelerde performansı artırabilir.
Dezavantajı: Her öğe için ek bellek kullanımına neden olabilir.
);
 */