//+------------------------------------------------------------------+
//|                                                    RSIWMA EA.mq4 |
//|                                  Copyright @ arman360x@gmail.com |
//|                                   https://fiverr.com/galaxyarman |
//+------------------------------------------------------------------+
#property copyright "Copyright @ arman360x@gmail.com"
#property link      ""
#property version   "1.00"
#include <Trade\Trade.mqh> // Include the CTrade library

CTrade Trade; // Declare the Trade object

input string Indicator_Settings="++++++++++++++++++++++++++";
input string RSI_WMA_TF1="RSI WMA LOWER TF";
input ENUM_TIMEFRAMES RSI_Timeframe = PERIOD_CURRENT;
input int RSI_Period = 14;
input ENUM_APPLIED_PRICE RSI_Applied_Price = PRICE_CLOSE;
input ENUM_MA_METHOD WMA_METHOD = MODE_LWMA;
input int WMA_Period = 50;
input int EMA_Period = 20;

input double RSI_Threshold_Buy = 30.0;
input double RSI_Threshold_Sell = 70.0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input bool UseHigherTimeFrame=true;//Use RSI WMA HTF
input string RSI_WMA_TF2="RSI WMA HIGHER TF";

input ENUM_TIMEFRAMES RSI_Timeframe2 = PERIOD_CURRENT;
input int RSI_Period2 = 14;
input ENUM_APPLIED_PRICE RSI_Applied_Price2 = PRICE_CLOSE;
input ENUM_MA_METHOD WMA_METHOD2 = MODE_LWMA;
input int WMA_Period2 = 50;
input int EMA_Period2 = 20;

input double RSI_Threshold_Buy2 = 30.0;
input double RSI_Threshold_Sell2 = 70.0;

//input bool DisplayBars =false;//Display Color Bars

//input color BullishCandles = clrBlue;
//input color BearishCandles = clrRed;
input string EA_Settings="++++++++++++++++++++++++++";

input bool UseUSDAmountPerTrader=false;//Use USD Amount Per Trade
input double Trade_Value_USD = 500.0; // USD amount per trade
input double LotSize=0.2;//Lot Size
input double LotClosePartially =50;//Partial Close Lot %
input double Profit_Target_1_Ratio = 1.0; // First profit target ratio
input double Profit_Target_2_Ratio = 3.0; // Second profit target ratio

input bool UseTrailingStop=false;//Use Trailing Stop 
input bool Use_Last_High_Low_Price =false;//Use Last High/Low Price 
input double Trail_Trigger_Ratio = 1.0; // Trailing Stop Loss ratio

input int MagicNumber = 1234;//Magic Number
double myPoint; //initialized in OnInit

input int NumberOfActiveTradesPerChart=5;//Number Of Active  Trades Per Chart

input double Spread = 1000;//Spread (Points)


double RSI[];
double WMA[];

double RSI2[];
double WMA2[];


datetime time = D'2024.10.20';

double originalLotSize;
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
//---TrailPriceToBEBuy
//+------------------------------------------------------------------+
void TrailPriceToBEBuy()
{
    // Retrieve the total number of positions
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        // Select the position
        ulong ticket = PositionGetTicket(i);
        if (PositionSelectByTicket(ticket))
        {
            // Check symbol and magic number
            if (PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber)
            {
                // Retrieve position details
                double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                double stopLoss = PositionGetDouble(POSITION_SL);
                double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_BID);

                // Calculate breakeven price and trail price
                double slSize = openPrice - stopLoss;
                double bePrice = openPrice + slSize * Trail_Trigger_Ratio;

                if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && currentPrice >= bePrice && currentPrice > stopLoss)
                {
                    // Modify the stop loss to the breakeven price
                    bool result = Trade.PositionModify(ticket, openPrice, PositionGetDouble(POSITION_TP));
                    if (!result)
                    {
                        Print("Error modifying position: ", GetLastError());
                    }
                }
            }
        }
    }
}
//+------------------------------------------------------------------+
//---TrailPriceToBESell
//+------------------------------------------------------------------+
void TrailPriceToBESell()
{
    // Get the total number of positions
    int totalPositions = PositionsTotal();

    for (int i = 0; i < totalPositions; i++)
    {
        // Select the position
        ulong ticket = PositionGetTicket(i);
        if (PositionSelectByTicket(ticket))
        {
            // Check the symbol and magic number
            if (PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber)
            {
                // Retrieve position details
                double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                double stopLoss = PositionGetDouble(POSITION_SL);
                double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_ASK);

                // Calculate break-even price and trail price
                double slSize = stopLoss - openPrice;
                double bePrice = openPrice - slSize * Trail_Trigger_Ratio;

                if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && currentPrice <= bePrice && currentPrice < stopLoss)
                {
                    // Modify the stop loss to the break-even price
                    bool result = Trade.PositionModify(ticket, openPrice, PositionGetDouble(POSITION_TP));
                    if (!result)
                    {
                        Print("Error modifying position: ", GetLastError());
                    }
                }
            }
        }
    }
}

