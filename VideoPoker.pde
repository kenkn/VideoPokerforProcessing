TrumpDesign trump;

void setup(){
  size(1280, 800);
  smooth();
  trump = new TrumpDesign(1, 0, true, 4.0);

}

void draw(){
  background(150);
  trump.setLocation(600, 100);
  trump.display();
}
