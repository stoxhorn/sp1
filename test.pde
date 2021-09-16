DiceCup myCup;


void setup() {
  size(1000,1000);
  // Parameters go inside the parentheses when the object is constructed.
  myCup = new DiceCup();
  for(int i = 0; i < 10; i++){
    myCup.addDie(new Die(color(0,0,0), color(255, 255, 255)));
  }
  myCup.shake();
}

void draw() {
  background(255);
  myCup.draw(10, 50, 50);
}

class DiceCup{
  ArrayList<Die> cup;
  
  DiceCup(){
    cup = new ArrayList<Die>();
  }
  
  void addDie(Die die){
    cup.add(die);
  }
  
  void shake(){
     int len = cup.size();
     for(int i = 0; i < len; i++){
       cup.get(i).roll();
     }
     
  }

  void draw(int x, int y, int dieSize){
    int originalX = x;
    int len = cup.size();
    int[] dices = {0,0,0,0,0,0};
     for(int i = 0; i < len; i++){
       dices[cup.get(i).value-1]++;
     }
     
     for(int i = 0; i < 6; i++){
         for(int j = 0; j < len; j++){
           if(cup.get(j).value == (i+1)){
             cup.get(j).draw(x, y, dieSize);
             x += dieSize;
           }
         }
         x = originalX;
         if(dices[i] != 0){
           y += dieSize;
         }else{}
           
         
     }
     
  }


}


// Even though there are multiple objects, we still only need one class.
// No matter how many cookies we make, only one cookie cutter is needed.
class Die {
  color dieColour;
  color eyeColour;
  int value;
  // Split die up in fields of size/5
  // need a way to distinguish between patterns for each number - value
  // how to decide pattern? Use a bollean array. length of 7. Each indedx decides what to light up
  // 0,1 index is top, 2,3 index is middle 4, 5 index is bottom, 7 is middle
  boolean[][] patterns = {
                          /*1*/
                           {false, false, false, false, false, false, true},
                          /*2*/
                           {true, false, false, false, false, true, false},
                          /*3*/
                           {true, false, false, false, false, true, true},
                          /*4*/
                           {true, true, false, false, true, true, false},
                          /*5*/
                           {true, true, false, false, true, true, true},
                          /*6*/
                           {true, true, true, true, true, true, false}
                         };
  
  // The Constructor is defined with arguments.
  Die(color dieColourTmp, color eyeColourTmp) {
    dieColour = dieColourTmp;
    eyeColour = eyeColourTmp;
    value = -1;
  }

  void roll(){
    value = (int) random(1,7);
  }

  void draw(int x, int y, int size) {
    if(value < 0){
       return;
    }
    stroke(0);
    fill(dieColour);
    rect(x, y, size, size);
    int fieldSize = size/5;
    int xOffset = fieldSize;
    int yOffset = fieldSize;
   
   
    for(int i = 0; i < 7; i++){
      // if this index is true
      
      if(patterns[value-1][i]){
        if(i == 6){
          fill(eyeColour);
          rect(x + fieldSize*2, y + fieldSize*2, fieldSize, fieldSize);
        }
        else{
          // create an eye
          fill(eyeColour);
          rect(x+xOffset, y + yOffset, fieldSize, fieldSize);
        }
        
        
      }
      // increase x offset by 2 times fieldsize, as there's an empty field in between
      xOffset = fieldSize + (i+1)%2 * fieldSize * 2;
      // do the same with Y, buy use a modolus, as i need to add 2 eyes pre row
      yOffset = yOffset + ((i)%2) * fieldSize;
      
      
    }
  }
}
