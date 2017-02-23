String filename = "database";

Table table;
int[] dates = {};
int[] numOfEachDate = {};
int highestNum;
int dx;
int lowx;
int currx;
int bufferx = 20;
int bufferTop = 10;
int i;
int textHeightOffset = 50;
int graphHeightOffset = textHeightOffset * 2;
int dataOffsetY = 10;
int dataOffsetX = 10;
PFont f;
String title = "Number of Executions in the U.S. Over Time";

void setup(){
 
  noLoop();
  
  table = loadTable(filename + ".csv", "header");
  println("loaded" + filename + ".csv");
  
  for (TableRow row : table.rows()) {
   
    String date = row.getString("Date");
    String[] numstrings = split(date, "/");
    
    i = dates.length;
    println("triggered" + i);
    if(i == 0){
     dates = append(dates, parseInt(numstrings[2]));
     numOfEachDate = append(numOfEachDate, 1);
     println("entry added" + i);
   }
    if(i != 0 && dates[i-1] == parseInt(numstrings[2])){
      numOfEachDate[i-1] += 1;
    }
    if(i != 0 && dates[i-1] != parseInt(numstrings[2])){
      dates = append(dates, parseInt(numstrings[2]));
      numOfEachDate = append(numOfEachDate, 1);
      println("entry added" + i);
    }
  }
  
  println(dates);
  for(int x = 0; x < dates.length; x++){
    println(dates[x] + " : " + numOfEachDate[x]);
  }
  size(1000, 600);
  translate(width/2, height/2);
  background(255);
 
 currx=0;
 dx = (width - 2 * bufferx) / dates.length;
 lowx = dates[0];
 
 for(int m = 0; m < numOfEachDate.length; m++){
   if(m==0){
    highestNum = numOfEachDate[m]; 
   }
   if(numOfEachDate[m] > highestNum){
    highestNum = numOfEachDate[m]; 
   }
 }
 
 f = createFont("Arial",16,true);
 drawPoints();
}


void drawPoints(){
  stroke(0);
  fill(0);
  textFont(f, 12);
  for(int n = 0; n < dates.length; n++){
    if(n>0){
      line(bufferx + (dates[n] - lowx) + (n * dx) - width/2, height/2 - graphHeightOffset - numOfEachDate[n] * ((height - graphHeightOffset) / highestNum) + bufferTop, bufferx + (dates[n-1] - lowx) + ((n-1) * dx) - width/2, height/2 - graphHeightOffset - numOfEachDate[n-1] * ((height - graphHeightOffset) / highestNum) + bufferTop);
    }
    ellipse(bufferx + (dates[n] - lowx) + (n * dx) - width/2, height/2 - graphHeightOffset - numOfEachDate[n] * ((height - graphHeightOffset) / highestNum) + bufferTop, 10, 10);
    textAlign(CENTER);
    text(numOfEachDate[n], bufferx + (dates[n] - lowx) + (n * dx) - width/2 + dataOffsetX, height/2 - graphHeightOffset - numOfEachDate[n] * ((height - graphHeightOffset) / highestNum) + bufferTop - dataOffsetY);
  }
  
  for(int n = 0; n < dates.length; n++){
    pushMatrix();
    rotate(PI + PI/2);
    textAlign(CENTER);
    text(dates[n], textHeightOffset - height/2, bufferx +  (dates[n] - lowx) + (n * dx) - width/2);
    popMatrix();
    stroke(255, 0, 0);
    line(bufferx +  (dates[n] - lowx) + (n * dx) - width/2 , height/2 - textHeightOffset*1.5, bufferx + (dates[n] - lowx) + (n * dx) - width/2, height/2 - graphHeightOffset - numOfEachDate[n] * ((height - graphHeightOffset) / highestNum) + bufferTop);
  }
 
 textFont(f, 24);
 textAlign(CENTER);
 text(title, -width/4, -height/3);
  
}