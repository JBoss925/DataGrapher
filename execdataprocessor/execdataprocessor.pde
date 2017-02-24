String filename = "database";

Table table;
int[] xValues = {};
int[] xValueFrequency = {};
int highestYValue = 0; //// If isOneVarFrequency is true, this is not used. Default 0;
int highestXValueFrequency; // Only used if 1-var frequency graph
int dx;
int lowestXValue;
int currentXPointer;
int sideBufferSize = 20;
int topBufferSize = 10;
int i;
int xAxisLabelTextOffsetX = 5;
int xAxisLabelBottomBuffer = 50;
int graphBottomBuffer = xAxisLabelBottomBuffer * 2;
int dataLabelOffsetY = 10;
int dataLabelOffsetX = 10;
PFont f;

//Data Table Variables
String title = "Number of Executions in the U.S. Over Time";
String xValueColumnName = "Date";
String yValueColumnName = null; // If this is null, isOneVarFrequency must be true
boolean isOneVarFrequency = true;

//Graph Additional Variables
boolean includeVerticalLines = true;
boolean includePoints = true;

void setup(){
 
  noLoop();
  
  table = loadTable(filename + ".csv", "header");
  println("loaded" + filename + ".csv");
  
  if(isOneVarFrequency){
   
    for (TableRow row : table.rows()) {
   
      String xValue = row.getString(xValueColumnName);
      String[] numstrings = split(xValue, "/");
    
      i = xValues.length;
      println("triggered" + i);
      if(i == 0){
       xValues = append(xValues, parseInt(numstrings[2]));
       xValueFrequency = append(xValueFrequency, 1);
       println("entry added" + i);
      }
      if(i != 0 && xValues[i-1] == parseInt(numstrings[2])){
        xValueFrequency[i-1] += 1;
      }
      if(i != 0 && xValues[i-1] != parseInt(numstrings[2])){
        xValues = append(xValues, parseInt(numstrings[2]));
        xValueFrequency = append(xValueFrequency, 1);
        println("entry added" + i);
      }
    }
  
    for(int m = 0; m < xValueFrequency.length; m++){
     if(m==0){
       highestXValueFrequency = xValueFrequency[m]; 
      }
     if(xValueFrequency[m] > highestXValueFrequency){
       highestXValueFrequency = xValueFrequency[m]; 
      }
    }
    
  }


  size(1000, 600);
  translate(width/2, height/2);
  background(255);
 
 currentXPointer=0;
 dx = (width - 2 * sideBufferSize) / xValues.length;
 
 
  for(int m = 0; m < xValues.length; m++){
   if(m==0){
    lowestXValue = xValues[m]; 
   }
   if(xValues[m] < lowestXValue){
    lowestXValue = xValues[m]; 
   }
 }
 
 f = createFont("Arial",16,true);
 drawPoints();
}


void drawPoints(){
  stroke(0);
  fill(0);
  textFont(f, 12);
  for(int n = 0; n < xValues.length; n++){
    if(n>0){
      line(sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize, sideBufferSize + (xValues[n-1] - lowestXValue) + ((n-1) * dx) - width/2, height/2 - graphBottomBuffer - xValueFrequency[n-1] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize);
    }
    //Add point
    if(includePoints){
      ellipse(sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize, 10, 10);
    }
    //Add data label
    textAlign(CENTER);
    text(xValueFrequency[n], sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2 + dataLabelOffsetX, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize - dataLabelOffsetY);
    redraw();
  }
  
  for(int n = 0; n < xValues.length; n++){
    pushMatrix();
    rotate(PI + PI/2);
    textAlign(CENTER);
    text(xValues[n], xAxisLabelBottomBuffer - height/2, xAxisLabelTextOffsetX + sideBufferSize +  (xValues[n] - lowestXValue) + (n * dx) - width/2);
    popMatrix();
    if(includeVerticalLines){
      stroke(255, 0, 0);
      line(sideBufferSize +  (xValues[n] - lowestXValue) + (n * dx) - width/2 , height/2 - xAxisLabelBottomBuffer*1.5, sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize);
      stroke(0);
    }
  }
 
 textFont(f, 24);
 textAlign(CENTER);
 text(title, -width/4, -height/3);
  
}