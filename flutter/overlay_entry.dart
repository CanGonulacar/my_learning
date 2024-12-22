/*
1. OverlayEntry Kullanımı

OverlayEntry, overlay bileşenlerini doğrudan ekrana yerleştirmek için kullanılan bir yapıdır. 
Bu genellikle modal pencereler, popup'lar veya geçici ekran bileşenleri oluşturmak için kullanılır. 
Bir OverlayEntry eklediğinizde, widget ağacında fiziksel olarak bir widget eklemezsiniz. 
Bunun yerine, geçici bir ekran bileşeni ekleyip kaldırmak için overlay kullanırsınız. 
Bu, Navigator gibi widget'ların yerine kullanılabilir.

Avantajları:

    Performans: OverlayEntry genellikle daha hafif ve hızlıdır çünkü widget ağacına doğrudan bir şey eklemez, 
    yalnızca geçici bir ekran bileşeni görüntüler. Böylece, overlay kapandığında widget ağacının yeniden oluşturulması gerekmez.
    
    Kontrol: Overlay'lar daha kontrollü bir şekilde yönetilebilir. Örneğin, sayfa veya popup açıldığında, 
    arka planda başka bir şeyin etkileşime girmesini engellemek için sadece Overlay'i yönetebilirsiniz.
    
    Geçici UI: Overlay, sayfayı doğrudan widget ağacına eklemek yerine geçici bir UI bileşeni sağlar, bu da dinamik ve kullanıcı etkileşimine dayalı uygulamalarda faydalıdır.

Dezavantajları:

    Karmaşıklık: OverlayEntry kullanımı, bazı durumlarda daha karmaşık olabilir. 
    Overlay'ler manuel olarak yönetilmelidir (örneğin, ekleme ve kaldırma işlemleri).

    Daha Az "Reactif": StatelessWidget'ler gibi widget'lar, Flutter'ın reaktif yapısını tam anlamıyla kullanır, 
    bu da daha az elle yönetim gerektirir.

 */