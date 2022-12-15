
bool isStringFilled(String message){
    return message.isNotEmpty;
}

List<String> names = ["Okeowo", "Aderemi", "Toys"];

printName(String name){
  print (name);
}

void main(List<String> arguments){
  print (arguments.length);
  bool status = isStringFilled("Okeowo");
  print(status);
  names.forEach(printName);


}