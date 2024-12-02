//+------------------------------------------------------------------+
//|                                              GetOrderComment.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
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
string GetOrderComment(int magicNumber)
{
   string comment = ""; // Default value if no position is found

   // Loop through all open positions
   for(int i = 0; i < PositionsTotal(); i++)
   {
      // Select the position by its index
      if(PositionSelectByTicket(i))
      {
         // Check if the position's magic number matches
         if(PositionGetInteger(POSITION_MAGIC) == magicNumber)
         {
            comment = PositionGetString(POSITION_COMMENT);
            break; // Exit the loop once the position is found
         }
      }
   }
   return comment;
}
