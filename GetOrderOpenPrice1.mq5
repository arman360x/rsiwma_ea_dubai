//+------------------------------------------------------------------+
//|                                            GetOrderOpenPrice.mq5 |
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
double GetOrderOpenPrice(int magicNumber)
{
   double openPrice = -1.0; // Default value if no position is found

   // Loop through all open positions
   for(int i = 0; i < PositionsTotal(); i++)
   {
      // Select the position by its index
      ulong ticket = PositionGetInteger(POSITION_TICKET);
      
      // Select the position by ticket
      //if(PositionSelect(ticket))
      {
         // Check if the position's magic number matches
         if(PositionGetInteger(POSITION_MAGIC) == magicNumber)
         {
            openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            break; // Exit the loop once the position is found
         }
      }
   }
   return openPrice;
}
