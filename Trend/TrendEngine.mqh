//+------------------------------------------------------------------+
//| TrendEngine.mqh                                                  |
//| Phoenix EA - Build 003                                           |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_TRENDENGINE_MQH__
#define __PHOENIX_TRENDENGINE_MQH__

enum ENUM_PHOENIX_TREND
{
   TREND_SIDEWAYS = 0,
   TREND_BULLISH,
   TREND_BEARISH
};

class CPhoenixTrendEngine
{
private:

   int m_fastHandle;
   int m_slowHandle;

   double m_fastEMA;
   double m_slowEMA;

   ENUM_PHOENIX_TREND m_trend;

public:

   CPhoenixTrendEngine()
   {
      m_fastHandle = INVALID_HANDLE;
      m_slowHandle = INVALID_HANDLE;
      m_fastEMA = 0;
      m_slowEMA = 0;
      m_trend = TREND_SIDEWAYS;
   }

   bool Initialize()
   {
      m_fastHandle = iMA(_Symbol, PERIOD_CURRENT, 50, 0, MODE_EMA, PRICE_CLOSE);
      m_slowHandle = iMA(_Symbol, PERIOD_CURRENT, 200, 0, MODE_EMA, PRICE_CLOSE);

      if(m_fastHandle == INVALID_HANDLE)
         return(false);

      if(m_slowHandle == INVALID_HANDLE)
         return(false);

      LogInfo("Trend Engine Ready.");

      return(true);
   }

   void Refresh()
   {
      double fastBuffer[];
      double slowBuffer[];

      if(CopyBuffer(m_fastHandle,0,0,1,fastBuffer) <= 0)
         return;

      if(CopyBuffer(m_slowHandle,0,0,1,slowBuffer) <= 0)
         return;

      m_fastEMA = fastBuffer[0];
      m_slowEMA = slowBuffer[0];

      if(m_fastEMA > m_slowEMA)
         m_trend = TREND_BULLISH;
      else if(m_fastEMA < m_slowEMA)
         m_trend = TREND_BEARISH;
      else
         m_trend = TREND_SIDEWAYS;
   }

   ENUM_PHOENIX_TREND Direction() const
   {
      return m_trend;
   }

   bool IsBullish() const
   {
      return (m_trend == TREND_BULLISH);
   }

   bool IsBearish() const
   {
      return (m_trend == TREND_BEARISH);
   }

   bool IsSideways() const
   {
      return (m_trend == TREND_SIDEWAYS);
   }

   double FastEMA() const
   {
      return m_fastEMA;
   }

   double SlowEMA() const
   {
      return m_slowEMA;
   }

   string TrendName() const
   {
      switch(m_trend)
      {
         case TREND_BULLISH: return "BULLISH";
         case TREND_BEARISH: return "BEARISH";
         default:            return "SIDEWAYS";
      }
   }

   void Shutdown()
   {
      if(m_fastHandle != INVALID_HANDLE)
         IndicatorRelease(m_fastHandle);

      if(m_slowHandle != INVALID_HANDLE)
         IndicatorRelease(m_slowHandle);

      LogInfo("Trend Engine Shutdown.");
   }
};

#endif