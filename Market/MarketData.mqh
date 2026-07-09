//+------------------------------------------------------------------+
//| MarketData.mqh                                                   |
//| Phoenix EA - Build 002                                           |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_MARKETDATA_MQH__
#define __PHOENIX_MARKETDATA_MQH__

class CPhoenixMarketData
{
private:

   string   m_symbol;
   double   m_bid;
   double   m_ask;
   double   m_spread;

   double   m_open;
   double   m_high;
   double   m_low;
   double   m_close;

   long     m_volume;

   datetime m_time;

   int      m_digits;
   double   m_point;

public:

   bool Initialize()
   {
      m_symbol = _Symbol;
      m_digits = (int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);
      m_point  = SymbolInfoDouble(_Symbol,SYMBOL_POINT);

      Refresh();

      LogInfo("Market Data Engine Ready.");

      return(true);
   }

   void Refresh()
   {
      MqlTick tick;

      if(SymbolInfoTick(_Symbol,tick))
      {
         m_bid     = tick.bid;
         m_ask     = tick.ask;
         m_spread  = (tick.ask-tick.bid)/m_point;
         m_time    = tick.time;
      }

      m_open   = iOpen(_Symbol,PERIOD_CURRENT,0);
      m_high   = iHigh(_Symbol,PERIOD_CURRENT,0);
      m_low    = iLow(_Symbol,PERIOD_CURRENT,0);
      m_close  = iClose(_Symbol,PERIOD_CURRENT,0);
      m_volume = iVolume(_Symbol,PERIOD_CURRENT,0);
   }

   string Symbol() const { return m_symbol; }

   double Bid() const { return m_bid; }

   double Ask() const { return m_ask; }

   double Spread() const { return m_spread; }

   double Open() const { return m_open; }

   double High() const { return m_high; }

   double Low() const { return m_low; }

   double Close() const { return m_close; }

   long Volume() const { return m_volume; }

   datetime Time() const { return m_time; }

   int Digits() const { return m_digits; }

   double Point() const { return m_point; }

   void PrintSnapshot()
   {
      LogLine();

      LogInfo("Market Snapshot");

      Print("Symbol  : ",m_symbol);
      Print("Bid     : ",DoubleToString(m_bid,m_digits));
      Print("Ask     : ",DoubleToString(m_ask,m_digits));
      Print("Spread  : ",DoubleToString(m_spread,1));
      Print("Open    : ",DoubleToString(m_open,m_digits));
      Print("High    : ",DoubleToString(m_high,m_digits));
      Print("Low     : ",DoubleToString(m_low,m_digits));
      Print("Close   : ",DoubleToString(m_close,m_digits));
      Print("Volume  : ",m_volume);

      LogLine();
   }
};

#endif
