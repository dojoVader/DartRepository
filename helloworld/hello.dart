var name = 2;

void printInteger(int number){
  print('The number is $number');
}

int doubled (int n) {
  return (n * n);
}

String printName(String name){
  return ("My name is $name");
}
void printNumber(int num){
  print(num.toString());
}
void main(){
  printInteger(5);
  int value = doubled(6);
  print('The value is $value');
  String result = printName("Okeowo Aderemi");
  print(result);
  printNumber(20);
}