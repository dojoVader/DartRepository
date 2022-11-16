void printInteger(int number){
  print('The number is $number');
}

int doubled (int n) {
  return (n * n);
}

void main(){
  printInteger(5);
  int value = doubled(6);
  print('The value is $value');
}