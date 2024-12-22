/*
Önce basit bir şekilde açıklamaya çalışayım

Stack ve Heap'i bir kütüphaneye benzetelim:

**STACK:**
- Masamız gibi düşünelim
- Sınırlı alan var
- Kitapları üst üste koyuyoruz
- En üstteki kitaba hemen ulaşabiliriz
- Masadan kalktığımızda kitaplar kaldırılıyor.

Örnek:
```dart
void main() {
  int yas = 25;        /// Masaya yaş yazdık
  bool evliMi = false; /// Masaya medeni hal yazdık
  
  /// Bu değişkenler fonksiyon bitince 
  /// masadan silinir (stack'ten temizlenir)
}
```

**HEAP:**
- Kütüphanenin depo alanı gibi düşünelim
- Çok geniş alan var
- Kitaplar rastgele yerleştirilebilir
- Bir kitaba ulaşmak için raf numarası (referans) kullanırız
- Kullanılmayan kitapları görevli (garbage collector) toplar

Örnek:
```dart
void main() {
  /// Heap örneği: 
  String isim = "Ahmet";  /// "Ahmet" depoda
  List liste = [1,2,3];   /// Liste depoda
  
  /// Stack'te sadece depo numaraları var
  /// Yani isim ve liste değişkenleri
  /// heap'teki verilerin referanslarını tutuyor
}
```

**Ne Zaman Ne Kullanılır:**

Stack'te tutulanlar (Masa):
- Sayılar (int, double)
- Boolean değerler
- Referanslar (depo numaraları)

Heap'te tutulanlar (Depo):
- String'ler 
- Listeler
- Objeler
- Sınıflar

Basit bir senaryo:
```dart
void kutuphaneOrnegi() {
  int ogrenciNo = 123;       /// Stack'te (masada)
  
  String kitapAdi = "Flutter Dersleri";  /// Heap'te (depoda)
  List<String> yazarlar = ["Can", "Hakan"]; /// Heap'te (depoda)
  
  /// ogrenciNo -> direkt masada
  /// kitapAdi -> masada sadece depo numarası yani referansı
  /// yazarlar -> masada sadece depo numarası yani referansı
}
```

Özetle:
1. Küçük, basit şeyler -> Stack (Masa)
2. Büyük, karmaşık şeyler -> Heap (Depo)
3. Stack daha hızlı ama küçük
4. Heap daha yavaş ama büyük
5. Stack otomatik temizlenir
6. Heap'i garbage collector temizler olabildiğince

Bu kadar basit! 😊

 */

/*
STACK:

LIFO (Last In First Out) prensibiyle çalışan, önceden belirlenmiş boyutta olan bellek bölgesidir
Çok hızlı erişim sağlar çünkü bellek düzenli ve sıralıdır
Derleme zamanında boyutu belirlenir. (Compile Time)
Otomatik bellek yönetimi vardır (scope bitince otomatik temizlenir)
Thread başına bir stack ayrılır

HEAP:

Dinamik bellek alanıdır, boyutu runtime'da değişebilir
Dağınık bellek yapısı vardır
Manuel bellek yönetimi gerektirir (Dart'ta Garbage Collector yapar)
Tüm thread'ler ortak kullanır
Stack'e göre daha yavaş erişim sağlar

Stack ve Heap'i daha detaylı inceleyelim:

# STACK

1. Çalışma Prensibi:
```dart
void stackExample() {
  /// Her fonksiyon çağrısı için yeni bir stack frame oluşur
  int a = 5;          /// Stack offset: 0
  int b = 10;         /// Stack offset: 4
  double c = 15.5;    /// Stack offset: 8
  
  calculateSum(a, b); /// Yeni stack frame oluşur
}

int calculateSum(int x, int y) {
  int result = x + y; /// Yeni stack frame'de
  return result;      /// Stack frame temizlenir
}
```

2. Stack Frame Yapısı:
- Return Address (Fonksiyon bitince dönülecek adres)
- Parametre değerleri
- Local değişkenler
- Stack pointer (SP) - Stack'in tepesini gösterir
- Frame pointer (FP) - Mevcut frame'in başlangıcını gösterir

3. Stack Overflow Durumu:
```dart
void recursiveFunction() {
  int x = 1;
  recursiveFunction(); /// Sürekli kendini çağırır
  /// Stack dolunca StackOverflow hatası oluşur
}
```

# HEAP

1. Bellek Yönetimi Detayları:

```dart
class Person {
  String name;
  List<String> hobbies;
  
  Person(this.name) {
    /// 1. name string'i heap'te oluşturulur
    /// 2. Person objesi heap'te oluşturulur
    /// 3. Stack'te sadece Person referansı tutulur
    hobbies = [];     /// Yeni List heap'te oluşturulur
  }
  
  void addHobby(String hobby) {
    hobbies.add(hobby); /// Heap'teki List'e yeni eleman eklenir
  }
}

void heapExample() {
  var person1 = Person("Alice");  /// Heap allocation
  var person2 = person1;          /// Sadece referans kopyalanır
  
  person1.addHobby("Reading");    /// Heap'teki aynı List güncellenir
  /// person2.hobbies de aynı List'i gösterir
}
```

2. Heap Fragmentation:
```dart
void fragmentationExample() {
  List<String> list1 = List.filled(1000, "A"); /// Büyük blok
  List<String> list2 = List.filled(2000, "B"); /// Büyük blok
  List<String> list3 = List.filled(500, "C");  /// Orta blok
  
  list1 = null; /// Boşluk oluşur
  
  /// Yeni bir 1500 boyutlu liste için
  /// yeterli ardışık alan olmayabilir
  /// Bu fragmentasyon problemidir
}
```

3. Garbage Collection Detayları:

```dart
class Resource {
  final String data;
  Resource(this.data);
  
  /// Finalizer metodu (nadiren kullanılır)
  void dispose() {
    /// Kaynakları temizle
    print('Resource disposed');
  }
}

void gcExample() {
  weak Resource? resource; /// Weak referans
  
  void createResource() {
    resource = Resource("data");
    /// Scope bitince resource GC için uygun hale gelir
  }
  
  void complexOperation() {
    var list1 = List.filled(10000, "data");
    var list2 = List.filled(20000, "data");
    /// Büyük allocationlar GC'yi tetikleyebilir
  }
}
```

4. Memory Layout Detayları:

```dart
class MemoryExample {
  /// Static değişkenler data segment'te
  static const int CONSTANT = 100;
  
  /// Instance değişkenler heap'te
  int instanceVar;
  
  void memoryLayoutExample() {
    /// Stack'te:
    int stackVar = 42;
    final int finalStackVar = 10;
    
    /// Heap'te:
    var dynamicArray = List<int>.filled(1000, 0);
    var growableList = <String>[];
    
    /// String interning örneği:
    var str1 = "hello";
    var str2 = "hello";
    /// Aynı string literals heap'te tek bir yerde tutulur
    
    /// Value types vs Reference types
    var value1 = 42;        /// Stack'te
    var value2 = value1;    /// Değer kopyalanır
    
    var list1 = [1,2,3];    /// Heap'te
    var list2 = list1;      /// Referans kopyalanır
  }
}
```

5. Performans İpuçları:

```dart
void performanceConsiderations() {
  /// İyi: Stack allocation
  int x = 42;
  double y = 3.14;
  
  /// Dikkatli kullanılmalı: Heap allocation
  var largeList = List<int>.filled(1000000, 0);
  
  /// İyi: Small String
  var smallString = "Hello";
  
  /// Dikkatli kullanılmalı: Large String
  var largeString = "X" * 1000000;
  
  /// İyi: Records (Stack-based)
  var point = (x: 10, y: 20);
  
  /// Dikkatli kullanılmalı: Class (Heap-based)
  var pointClass = Point(10, 20);
}
```

6. Memory Leak Önleme:

```dart
class StreamExample {
  StreamController? _controller;
  StreamSubscription? _subscription;
  
  void startListening() {
    _controller = StreamController<int>();
    
    _subscription = _controller?.stream.listen((data) {
      print(data);
    });
  }
  
  void dispose() {
    /// Memory leak önleme
    _subscription?.cancel();
    _controller?.close();
    _controller = null;
    _subscription = null;
  }
}
```

7. Heap ve Stack İlişkisi:

```dart
class ComplexDataStructure {
  final List<Map<String, List<int>>> data;
  
  ComplexDataStructure() : data = [] {
    /// Heap'te nested yapı:
    /// 1. OuterList
    /// 2. ---> Map
    /// 3. ------> InnerList
    /// 4. ----------> Integer values
    
    /// Stack'te sadece ComplexDataStructure referansı
  }
  
  void addData(String key, List<int> values) {
    data.add({key: values});
    /// Yeni Map ve List heap'te oluşturulur
  }
}
```

 */