//+------------------------------------------------------------------+
//|                                           partial close sell.mq5 |
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
// Partial close for Sell positions
void PartialCloseSell()
{
    // Get the total number of open positions
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++) 
    {
        // Select the position by index
        ulong ticket = PositionGetTicket(i);
        if (PositionSelectByTicket(ticket))
        {
            // Ensure the position matches the symbol and magic number
            if (PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber)
            {
                // Check if the position is a sell order
                if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                {
                    double positionLots = PositionGetDouble(POSITION_VOLUME); // Current lot size
                    double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                    double stopLoss = PositionGetDouble(POSITION_SL);