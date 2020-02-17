/*
 * All the code based on the Mathematics by Paul Burke
 * Check out the original at http://paulbourke.net/geometry/knots/
 *
 * Edited and animated by Lorenzo Leonardini, inspired by Daniel Shiffman's livestream
 *
 * Available to anyone for free to learn and experiment. If used anywhere you are free
 * to mention me. Make sure to let me know I'm part of someone's project!
 */

ArrayList<PVector> vectors = new ArrayList<PVector>();

void setup(){
  fullScreen(P3D);
}

float angle = 0; 
int i = 0;

// nlongitude and nmeridian change how the line is constructed around the torus
// not sure how it actually works in geometry, try to play with the values to have
// an idea
int nlongitude = 7, nmeridian = 4;

// The speed is used to decide how fast the animation should be
int speed = 8;

void draw() {
  background(0);
  
  // Translate to the center and rotate everything
  translate(width / 2, height / 2);
  rotateY(angle);
  rotateX(angle * 0.8);
  rotateZ(angle * 1.2);
  angle += 0.01;

  float x, y, z;
  float mu;

  for (int j = 0; j < speed; j++) {
    // Do the bad calculation
    mu = i * TWO_PI * nmeridian / 1000f;
    x = cos(mu) * (1 + cos(nlongitude * mu / (float) nmeridian) / 2.0);
    y = sin(mu) * (1 + cos(nlongitude * mu / (float) nmeridian) / 2.0);
    z = sin(nlongitude * mu / (float) nmeridian) / 2.0;

    // Scale everything to fit properly into the screen, change if needed
    x *= height * 0.5 / 2;
    y *= height * 0.5 / 2;
    z *= height * 0.5 / 2;

    // If i < 1000 so the knot is still being constructed, add each point to the list
    if (i < 1000)
      vectors.add(new PVector(x, y, z));
    i++;
  }


  // Draw everything from the list of points
  strokeWeight(8);
  noFill();
  beginShape();
  for (PVector v : vectors) {
    float r = map(v.x, -100, 100, 100, 255);
    float g = map(v.y, -100, 100, 100, 255);
    stroke(r, g, v.mag());
    vertex(v.x, v.y, v.z);
  }
  endShape();


  // If i >= 1000 so the knot has already been constructed, just start deleting it from the
  // start to the end, when finished removing all the points from the list, set i to 0 so
  // it can start everything again
  if (i >= 1000) {
    for (int j = 0; j < speed; j++)
      if (vectors.size() != 0)
        vectors.remove(0);
    if (vectors.size() == 0)
      i = 0;
  }
}
