import 'dart:io';

String message= r'Hi my name is \n Okeowo';

List<int> listNumber = [1,2,4,5,6,7];

var gifts = {
  'first': 'Value'
};





bool PC_RUNNER = true;



bool configured = false;

void main(){
  print(message);

  configured ? print('Configured') : print('Not Configured');
  for (int i in listNumber){
    print(i);
  }
  var gifts = Map<String, String>();
  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';

  Map<int,String> nobleGases = Map<int, String>();
  nobleGases[2] = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';

  print(nobleGases);
  while(PC_RUNNER){
    print("Welcome to the TERMINAL API for Data Enter an input");
    String optionSelected = stdin.readLineSync().toString();
    int choice = int.parse( optionSelected);
    switch(choice){
      case 1:
        print("Enter the Matrix");
            break;
      case 2:
        print('Okay we are here');
        break;
      case 3:
        print('What is my name');
        break;
      case 5:
        print('Quiting');
        PC_RUNNER = false;
        break;
    }

  }

}


