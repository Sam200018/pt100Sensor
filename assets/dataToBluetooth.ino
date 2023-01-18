#include <SoftwareSerial.h>
const int inputPins[8] = {2, 3, 4, 5, 6, 7, 8, 9}; // Pines de entrada
int inputValues[8];                                // Valores de entrada
char PASS[5] = "1234";
SoftwareSerial blue(12, 13);

void setup()
{

  Serial.begin(9600);

  for (int i = 0; i < 8; i++)
  {
    pinMode(inputPins[i], INPUT); // Configura los pines como entradas
  }
  blue.begin(9600);
  Serial.println("ENTER AT Commands:");
  delay(1000);

  blue.print("AT");
  delay(1000);

  blue.print("AT+PIN");
  blue.print(PASS);
  delay(1000);
}

void loop()
{
  int adcBin = 0;
  int powTen = 1;
  String binToSend = "";
  Serial.print("Binario:");
  for (int i = 0; i < 8; i++)
  {
    
    inputValues[i] = digitalRead(inputPins[i]); // Lee el valor de cada pin
    binToSend += String(inputValues[i]);
    adcBin = (adcBin << 1) | inputValues[i];
    Serial.print(inputValues[i]);
  }

  double temperature = 0.0;
  Serial.print(" adcBin:");
  Serial.print(adcBin);
  temperature = adcBin / (1.3029);
  Serial.print(" Temperatura:");
  Serial.print(temperature);

  
  String dataToSend = binToSend + " " + String(temperature);
  blue.print(dataToSend);
  Serial.println();
  delay(100);
}
