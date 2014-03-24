// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Interactive Selection
// http://www.genarts.com/karl/papers/siggraph91.html



class Button {
  Rectangle r;  // Button's rectangle
  String txt;   // Button's text
  boolean clickedOn;  // Did i click on it?
  boolean rolloverOn; // Did i rollover it?

  color baseColor = color(50,30,80);
  color hoverColor = color(50,80,100);
  color clickColor = color(50,0,80);

  Button(int x, int y, int w, int h, String s) {
    r = new Rectangle(x,y-5,w,h);
    txt = s;
  }

  void display() {
    // Draw rectangle and text based on whether rollover or clicked
    pushStyle();
    stroke(hoverColor); 
    strokeWeight(3);
  

    if (rolloverOn) 
      fill(hoverColor);
    else if (clickedOn) 
      fill(clickColor);
    else 
      fill(baseColor);

    rect(r.x,r.y,r.width,r.height,5);

    float b = 0.0;
    if (clickedOn) 
      b = 1;
    else if (rolloverOn) 
      b = 0.2;
    else 
      b = 0;

    fill(b);
    textAlign(CENTER);
    text(txt,r.x + r.width * 0.5 ,r.y + r.height*0.70);
    popStyle();
  }
  
  
  // Methods to check rollover, clicked, or released (must be called from appropriate
  // Places in draw, mousePressed, mouseReleased
  boolean rollover(int mx, int my) {
    if (r.contains(mx,my)) 
      rolloverOn = true;
    else 
      rolloverOn = false;
    return rolloverOn;
  }

  boolean clicked(int mx, int my) {
    if (r.contains(mx,my)) 
      clickedOn = true;
    return clickedOn;
  }

  void released() {
    clickedOn = false;
  }

}