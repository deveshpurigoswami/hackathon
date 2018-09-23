#include "DHT.h"

#define DHTPIN 7    
#define DHTTYPE DHT11   // DHT 22  (AM2302)
int Pump=5;

DHT dht(DHTPIN, DHTTYPE);

void setup() 
{
    Serial.begin(9600); 
    pinMode(Pump,OUTPUT);

    dht.begin();
}

void loop() 
{

    int m;
    int t = dht.readTemperature();
    float moist=analogRead(A0);
    m=((-0.129)*moist) + 132.096;

    // check if returns are valid, if they are NaN (not a number) then something went wrong!
    if (isnan(t)) 
    {
        Serial.println("Failed to read from DHT");
    } 
    else 
    {
        Serial.print("P");
        Serial.print(m);
        Serial.print(".");
        Serial.print(t);
        Serial.print("p");
    }

  if (m<35)
  {
    analogWrite(A5,175);
  }
  if (m>35)
  {
    analogWrite(A5,0);
  }
}
