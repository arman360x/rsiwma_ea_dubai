//+------------------------------------------------------------------+
//|                                              GetOrderLotSize.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
double GetOrderLotSize(int magicNumber)
{
   double lotSize = -1.0; // Default value if no position is found

   // Loop through all open positions
   for(int i = 0; i < PositionsTotal(); i++)
   {
      // Select the position by its ticket
      if(PositionSelectByTicket(i))
      {
         // Check if the position's magic number matches
         if(PositionGetInteger(POSITION_MAGIC) == magicNumber)
         {
            lotSize = PositionGetDouble(POSITION_VOLUME);
            break; // Exit the loop once the position is found
         }
      }
   }
   return lotSize;
}
