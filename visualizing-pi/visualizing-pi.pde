String digits[];
int index = 0;
int prevX = 0, prevY = 0;

void setup() {
  fullScreen();
  //size(500, 500);
  String content = loadStrings("pi-1million.txt")[0];
  digits = content.split("");
  colorMode(HSB);
  background(51);
}

void draw() {
  noStroke();
  translate(width / 2, height / 2);
  int rep = index > 500 ? 20 : 1;
  for(int i = 0; i < rep; i++) {
    float alpha = map(Integer.parseInt(digits[index]), 0, 10, 0, TWO_PI);
    float len = map(Integer.parseInt(digits[index + 1]), 0, 9, 10, 30);
    float dX = cos(alpha) * len;
    float dY = sin(alpha) * len;
    int x = prevX + (int) dX;
    int y = prevY + (int) dY;
    if(x > width / 2) x = width / 2;
    if(x < - width / 2) x = - width / 2;
    if(y > height / 2) y = height / 2;
    if(y < - height / 2) y = - height / 2;
    float hue = map(Integer.parseInt(digits[index + 2]), 0, 9, 0, 255);  
    fill(hue, 150, 255);
    ellipse(x, y, len, len);
    prevX = x;
    prevY = y;
    index++;
  }
}
