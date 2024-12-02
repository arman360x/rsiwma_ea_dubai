//+------------------------------------------------------------------+
//|                                             patial close buy.mq5 |
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
// Partial close for Buy positions
void PartialCloseBuy()
{
    // Iterate through all open positions
    for (int i = 0; i < PositionsTotal(); i++) 
    {
        // Select the position
        ulong ticket = PositionGetTicket(i);
        if (PositionSelectByTicket(ticket)) 
        {
            // Ensure the position matches the criteria
            if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_SYMBOL) == Symbol()) 
            {
                // Retrieve position details
                double positionVolume = PositionGetDouble(POSITION_VOLUME);
                double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                double stopLoss = PositionGetDouble(POSITION_SL);

                // Calculate parameters
                double slSize = openPrice - stopLoss; // Stop loss size for a buy trade
                double partialVolume = NormalizeDouble(positionVolume * LotClosePartially * 0.01, 2); // Partial close lot size

                // Ensure the partial volume is valid
                if (partialVolume > 0 && partialVolume < positionVolume) 
                {
                    double profitTarget = openPrice + slSize * Profit_Target_1_Ratio;

                    // Check if the current Ask price has reached the profit target
                    if (SymbolInfoDouble(Symbol(), SYMBOL_ASK) >= profitTarget) 
                    {
                        // Perform partial close
                        bool result = Trade.PositionClosePartial(ticket, partialVolume);
                        if (!result) 
                        {
                            Print("Error closing part of the buy position: ", GetLastError());
                        } 
                        else 
                        {
                            Print("Successfully closed ", partialVolume, " lots from the buy position.");
                        }
                    }
                }
                else 
                {
                    Print("Invalid lot size for partial close: ", partialVolume);
                }
            }
        }
        else 
        {
            Print("PositionSelectByTicket failed for index: ", i);
        }
    }
}
// Partial close for Buy positions
void PartialCloseBuy()
{
    // Iterate through all open positions
    for (int i = 0; i < PositionsTotal(); i++) 
    {
        // Select the position
        ulong ticket = PositionGetTicket(i);
        if (PositionSelectByTicket(ticket)) 
        {
            // Ensure the position matches the criteria
            if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_SYMBOL) == Symbol()) 
            {
                // Retrieve position details
                double positionVolume = PositionGetDouble(POSITION_VOLUME);
                double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                double stopLoss = PositionGetDouble(POSITION_SL);

                // Calculate parameters
                double slSize = openPrice - stopLoss; // Stop loss size for a buy trade
                double partialVolume = NormalizeDouble(positionVolume * LotClosePartially * 0.01, 2); // Partial close lot size

                // Ensure the partial volume is valid
                if (partialVolume > 0 && partialVolume < positionVolume) 
                {
                    double profitTarget = openPrice + slSize * Profit_Target_1_Ratio;

                    // Check if the current Ask price has reached the profit target
                    if (SymbolInfoDouble(Symbol(), SYMBOL_ASK) >= profitTarget) 
                    {
                        // Perform partial close
                        bool result = Trade.PositionClosePartial(ticket, partialVolume);
                        if (!result) 
                        {
                            Print("Error closing part of the buy position: ", GetLastError());
                        } 
                        else 
                        {
                            Print("Successfully closed ", partialVolume, " lots from the buy position.");
                        }
                    }
                }
                else 
                {
                    Print("Invalid lot size for partial close: ", partialVolume);
                }
            }
        }
        else 
        {
            Print("PositionSelectByTicket failed for index: ", i);
        }
    }
}
