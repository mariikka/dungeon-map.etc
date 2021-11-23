class Hero extends GameObjects {
  float speed;
  Weapon myWeapon;
  boolean immune;
  int immunetime = 0;
  color c;
  Hero() {
    super();
    hp = 100;
    loc = new PVector (50, 50);
    speed = 5;
    roomX = 1;
    roomY = 1;
    size = 40;
    c = green;
    immune = false;
    myWeapon = new AutoPistol();
  }

  void show() {
    fill(c);
    stroke(black);
    strokeWeight(2);
    circle(loc.x, loc.y, size);
//healthbar
rectMode(CENTER);
fill(brightRed);
stroke(0);
strokeWeight(2);
float lifemeter = map(hp, 0, 100, 0, 70);
rect(loc.x, loc.y + -35, 70, 10);
fill(green);
noStroke();
rect(loc.x, loc.y - 35, lifemeter, 10);
  }

  void act() {
    super.act();
    
    if (immune) {
      immunetime++;
      c = red;
    }
    if (immunetime > 100) { 
      immune = false;
      immunetime = 0;
      c = green;
    }

    if (wkey) vel.y = -speed;
    if (skey) vel.y = speed;
    if (akey) vel.x = -speed;
    if (dkey) vel.x = speed;

    if (vel.mag() > speed) vel.setMag(speed);

    if (!wkey && !skey) vel.y = vel.y*0.9;
    if (!akey && !dkey) vel.x = vel.x*0.9;

    //moving around rooms

    if (northRoom!=#FFFFFF && loc.x > 371 && loc.x < 428 && loc.y == 103) {
      roomY--;
      loc = new PVector (width/2, 497);
    }

    if (eastRoom!=#FFFFFF && loc.y > 262 && loc.y < 327 && loc.x == 687) {

      roomX++;
      loc = new PVector (113, height/2);
    }

    if (southRoom!=#FFFFFF && loc.x > 375 && loc.x < 432 && loc.y == 496) {
      roomY++;
      loc = new PVector (width/2, 103);
    }

    if (westRoom!=#FFFFFF && loc.y > 270 && loc.y < 328 && loc.x == 112) {
      roomX--;
      loc = new PVector (687, height/2);
    }
    myWeapon.update();
    if (spacekey) myWeapon.shoot();

    if (hp <=0) {
      mode = GAMEOVER;
    }
  }
}
