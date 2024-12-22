/*
dynamic bir tip değildir. Tipi belirtilmemiştir. Bunlar derleyicinin(compiler) tür kontrolu yapmasını engeller.

Example: 
class MyClass{
    myFunction() => print("This works");        
}

void main(){
dynamic a = new MyClass();
Object b = new MyClass();
a.myFunction(); // prints without error
b.myFunction(); // error : myFunction isn't defined for b
}
 */