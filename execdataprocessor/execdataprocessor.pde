String filename = "database";

Table table;
int[] xValues = {};
int[] xValueFrequency = {};
int highestXValueFrequency;
int dx;
int lowestXValue;
int currentXPointer;
int sideBufferSize = 13; // THIS IS BROKEN CURRENTLY (will only shift right, not on both sides) [should be easy fix]
int topBufferSize = 10;
int i;
int xAxisLabelBottomBuffer = 50;
int graphBottomBuffer = xAxisLabelBottomBuffer * 2;
int dataLabelOffsetY = 10;
int dataLabelOffsetX = 10;
PFont f;

//Data Table Variables
String title = "Number of Executions in the U.S. Over Time";
String xValueColumnName = "Date";
String yValueColumnName = null; // If this is null, oneVarFrequency must be true
boolean oneVarFrequency = true;

void setup(){
 
  noLoop();
  
  table = loadTable(filename + ".csv", "header");
  println("loaded" + filename + ".csv");
  
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
  
  println(xValues);
  for(int x = 0; x < xValues.length; x++){
    println(xValues[x] + " : " + xValueFrequency[x]);
  }
  size(1000, 600);
  translate(width/2, height/2);
  background(255);
 
 currentXPointer=0;
 dx = (width - 2 * sideBufferSize) / xValues.length;
 lowestXValue = xValues[0];
 
 for(int m = 0; m < xValueFrequency.length; m++){
   if(m==0){
    highestXValueFrequency = xValueFrequency[m]; 
   }
   if(xValueFrequency[m] > highestXValueFrequency){
    highestXValueFrequency = xValueFrequency[m]; 
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
    ellipse(sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize, 10, 10);
    textAlign(CENTER);
    text(xValueFrequency[n], sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2 + dataLabelOffsetX, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize - dataLabelOffsetY);
  }
  
  for(int n = 0; n < xValues.length; n++){
    pushMatrix();
    rotate(PI + PI/2);
    textAlign(CENTER);
    text(xValues[n], xAxisLabelBottomBuffer - height/2, sideBufferSize +  (xValues[n] - lowestXValue) + (n * dx) - width/2);
    popMatrix();
    stroke(255, 0, 0);
    line(sideBufferSize +  (xValues[n] - lowestXValue) + (n * dx) - width/2 , height/2 - xAxisLabelBottomBuffer*1.5, sideBufferSize + (xValues[n] - lowestXValue) + (n * dx) - width/2, height/2 - graphBottomBuffer - xValueFrequency[n] * ((height - graphBottomBuffer) / highestXValueFrequency) + topBufferSize);
  }
 
 textFont(f, 24);
 textAlign(CENTER);
 text(title, -width/4, -height/3);
  
}