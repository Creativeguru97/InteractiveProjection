import codeanticode.syphon.*;

PGraphics canvas;
SyphonServer server;

void setup(){
  size(400, 400, P3D);
  canvas = createGraphics(400,400,P3D); //Create secondary window
  
  //Create syphon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
}

void draw(){
  canvas.beginDraw(); //Need for draw to with syphon
  //The normal drawing functions work from here now, but also must be prefixed with
  //*canvas.* (for example canvas.line, canvas.ellipse).
  canvas.background(100,100,100);
  canvas.stroke(mouseX);
  canvas.strokeWeight(4);
  canvas.line(50,50,mouseX,mouseY);
  canvas.endDraw();

  
  image(canvas, 0, 0);
  server.sendImage(canvas);
}
