import processing.serial.*;
Serial my;
int index,h,t;
char val;
String value,humid,temp;
PImage wheat,rice,apple,red,clay,loam;
int CROP=1,SOIL=1;


void setup()
{
  size(1200,800);
  String port=Serial.list()[0];
  my = new Serial(this,port,9600);
  delay(1000);
  
  wheat=loadImage("wheat.jpg");
  rice=loadImage("rice.jpg");
  apple=loadImage("aple.jpg");
  red=loadImage("red.jpg");
  clay=loadImage("clay.jpg");
  loam=loadImage("loam.png");
  
}


void doit(int x,int y)
{
  textSize(20);
  int hy,ty;
  hy=int(5.33*x);
  ty=(20*y)-400;
  
  background(0);
  fill(255);
  rect(width/12,height/6,width/12,(height*4)/6,width/24);
  text("MOISTURE",100,700);
  rect(3*(width/12),height/6,width/12,(height*4)/6,width/24);
  text("TEMPRATUTE",300,700);
  
 
  text("ID : XXX01",30,50);
  text("STATUS :",30,70);
  fill(0,200,0);
  text("WORKING ",120,70);
  fill(255);
  
  
  
  text("100 %",60,140);
  text("0 %",65,660);
  text(x+" %",30,(5*(height/6))-hy);
  
  text("50 C",260,140);
  text("20 C",260,660);
  text(y+" C",250,(5*(height/6))-ty);
  
   text("SELECT CROP",700,80);
   text("WHEAT",550,380);
   text("RICE",750,380);
   text("APPLE",950,380);
   text("SELECT SOIL TYPE",700,480);
   text("RED SOIL",550,750);
   text("CLAY SOIL",750,750);
   text("LOAM SOIL",950,750);
  
  fill(0,150,150);
  rect(width/12,(5*(height/6))-hy,width/12,hy,width/24);
  fill(150,50,50);
  rect(3*(width/12),(5*(height/6))-ty,width/12,ty,width/24);
  
  
  image(wheat,(width/12)*5,height/6,(width/12)*1.5,height/4);
  image(rice,(width/12)*7,height/6,(width/12)*1.5,height/4);
  image(apple,(width/12)*9,height/6,(width/12)*1.5,height/4);
  
  image(red,(width/12)*5,(height/2)+100,(width/12)*1.5,height/4);
  image(clay,(width/12)*7,(height/2)+100,(width/12)*1.5,height/4);
  image(loam,(width/12)*9,(height/2)+100,(width/12)*1.5,height/4);
  
  
  if(CROP==1)
  {fill(5,100);
  rect((width/12)*7,height/6,(width/12)*1.5,height/4);
  rect((width/12)*9,height/6,(width/12)*1.5,height/4);
   }
   else if (CROP == 2)
   {fill(5,100);
  rect((width/12)*5,height/6,(width/12)*1.5,height/4);
  rect((width/12)*9,height/6,(width/12)*1.5,height/4);
   }
   else if (CROP == 3)
   {
     fill(5,100);
  rect((width/12)*5,height/6,(width/12)*1.5,height/4);
  rect((width/12)*7,height/6,(width/12)*1.5,height/4);
   }
   
   if(SOIL==1)
   {
     fill(5,100);
  rect((width/12)*7,(height/2)+100,(width/12)*1.5,height/4);
  rect((width/12)*9,(height/2)+100,(width/12)*1.5,height/4);
     
   }
  else if (SOIL == 2)
   {fill(5,100);
  rect((width/12)*5,(height/2)+100,(width/12)*1.5,height/4);
  rect((width/12)*9,(height/2)+100,(width/12)*1.5,height/4);
   }
   else if (SOIL == 3)
   {
     fill(5,100);
  rect((width/12)*5,(height/2)+100,(width/12)*1.5,height/4);
  rect((width/12)*7,(height/2)+100,(width/12)*1.5,height/4);
   }
}


void mousePressed()
{
  if ( (mouseX>((width/12)*5) && (mouseX<(((width/12)*5) + ((width/12)*1.5)))) && ( (mouseY> (height/6)) && (mouseY<((height/6)+(height/4))))  )
  {
    CROP =1;
  }
  if ( (mouseX>((width/12)*7) && (mouseX<(((width/12)*7) + ((width/12)*1.5)))) && ( (mouseY> (height/6)) && (mouseY<((height/6)+(height/4))))  )
  {
    CROP =2;
  }
  if ( (mouseX>((width/12)*9)&& (mouseX<(((width/12)*9) + ((width/12)*1.5)))) && ( (mouseY> (height/6)) && (mouseY<((height/6)+(height/4))))  )
  {
    CROP =3;
  }
  if ( (mouseX>((width/12)*5)&& (mouseX<(((width/12)*5) + ((width/12)*1.5)))) && ( (mouseY> ((height/2)+100)) && (mouseY<(((height/2)+100)+(height/4))))  )
  {
    SOIL =1;
  }
  if ( (mouseX>((width/12)*7)&& (mouseX<(((width/12)*7) + ((width/12)*1.5)))) && ( (mouseY> ((height/2)+100)) && (mouseY<(((height/2)+100)+(height/4))))  )
  {
    SOIL =2;
  }
  if ( (mouseX>((width/12)*9)&& (mouseX<(((width/12)*9) + ((width/12)*1.5)))) && ( (mouseY> ((height/2)+100)) && (mouseY<(((height/2)+100)+(height/4))))  )
  {
    SOIL =3;
  }

}



void draw()
{
  Table table=new Table();
  table=loadTable("abc.csv");
    val=my.readChar();
    if(val=='P')
    {
    value=my.readStringUntil('p');
    
    if(value!=null)
    {
      value=value.substring(0,value.length()-1);
      index=value.indexOf('.');
      humid=value.substring(0,index+1);
      temp=value.substring(index+1,value.length());
    }
    if(humid!=null&&temp!=null)
    {
    h=int(humid);
    t=int(temp);
    TableRow row= table.addRow();
    row.setInt(0,CROP);
    row.setInt(1,SOIL);
    row.setInt(2,t);
    row.setInt(3,h);


saveTable(table,"abc.csv");
    }
   
    doit(h,t);
    }
    print(h+"\t"+t+"\t"+CROP+"\t"+SOIL+"\n");
    delay(100);


}
