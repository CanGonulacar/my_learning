/*
Küçük bir not: bloc ile get_it'i beraber kullanabiliriz. (BlocProvider.value ile)
 */
// Basit bir servis lokator sınıfı
class ServiceLocator {
  // Private constructor
  ServiceLocator._();
  
  // Singleton instance
  static final ServiceLocator instance = ServiceLocator._();
  
  // Dependency'leri tutacağımız map
  final _instances = <Type, dynamic>{};
  
  // Factory'leri tutacağımız map (lazy initialization için)
  final _factories = <Type, dynamic Function()>{};
  
  // registerSingleton metodu
  void registerSingleton<T>(T instance) {
    _instances[T] = instance;
  }
  
  // registerLazySingleton metodu
  void registerLazySingleton<T>(T Function() factory) {
    _factories[T] = factory;
  }
  
  // get metodu
  T get<T>() {
    // Önce instance map'te ara
    if (_instances.containsKey(T)) {
      return _instances[T] as T;
    }
    
    // Instance yoksa factory map'te ara
    if (_factories.containsKey(T)) {
      // Factory'den instance oluştur
      final instance = _factories[T]!() as T;
      // Oluşturulan instance'ı sakla
      _instances[T] = instance;
      // Factory'yi sil (artık ihtiyaç yok)
      _factories.remove(T);
      return instance;
    }
    
    throw Exception('No registration found for type $T');
  }
  
  // Reset metodu (test için kullanışlı)
  void reset() {
    _instances.clear();
    _factories.clear();
  }
}

// Örnek kullanım için test sınıfları
class UserService {
  UserService() {
    print('UserService constructor çalıştı');
  }
  
  void getUser() => print('Kullanıcı bilgileri alındı');
}

class AnalyticsService {
  AnalyticsService() {
    print('AnalyticsService constructor çalıştı');
  }
  
  void logEvent() => print('Event loglandı');
}

void main() {
  final locator = ServiceLocator.instance;
  
  print('--- registerSingleton Örneği ---');
  // Eager initialization
  locator.registerSingleton<UserService>(UserService());
  print('Register işlemi tamamlandı\n');
  
  // Her get çağrısında aynı instance döner
  final userService1 = locator.get<UserService>();
  final userService2 = locator.get<UserService>();
  userService1.getUser();
  print('userService1 == userService2: ${identical(userService1, userService2)}\n');
  
  print('--- registerLazySingleton Örneği ---');
  // Lazy initialization - henüz oluşturulmaz
  locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  print('Register işlemi tamamlandı');
  print('AnalyticsService henüz oluşturulmadı\n');
  
  // İlk get çağrısında oluşturulur
  print('İlk get çağrısı:');
  final analyticsService1 = locator.get<AnalyticsService>();
  analyticsService1.logEvent();
  
  print('\nİkinci get çağrısı:');
  final analyticsService2 = locator.get<AnalyticsService>();
  print('analyticsService1 == analyticsService2: ${identical(analyticsService1, analyticsService2)}');
}