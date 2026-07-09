//+------------------------------------------------------------------+
//| StructureEngine.mqh                                              |
//| Phoenix EA v1.0.004                                              |
//| Build 004A - Market Structure Engine                             |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_STRUCTUREENGINE_MQH__
#define __PHOENIX_STRUCTUREENGINE_MQH__

class CPhoenixStructureEngine
{
private:

   double m_lastSwingHigh;
   double m_lastSwingLow;

   bool m_higherHigh;
   bool m_higherLow;
   bool m_lowerHigh;
   bool m_lowerLow;

   int m_lookback;

public:

   CPhoenixStructureEngine()
   {
      m_lastSwingHigh = 0.0;
      m_lastSwingLow  = 0.0;

      m_higherHigh = false;
      m_higherLow  = false;
      m_lowerHigh  = false;
      m_lowerLow   = false;

      m_lookback = 10;
   }

   bool Initialize()
   {
      LogInfo("Structure Engine Ready.");
      return(true);
   }

   void Refresh()
   {
      m_lastSwingHigh = iHigh(_Symbol, PERIOD_CURRENT, 1);
      m_lastSwingLow  = iLow(_Symbol, PERIOD_CURRENT, 1);

      for(int i = 2; i <= m_lookback; i++)
      {
         double high = iHigh(_Symbol, PERIOD_CURRENT, i);
         double low  = iLow(_Symbol, PERIOD_CURRENT, i);

         if(high > m_lastSwingHigh)
            m_lastSwingHigh = high;

         if(low < m_lastSwingLow)
            m_lastSwingLow = low;
      }

      double currentHigh = iHigh(_Symbol, PERIOD_CURRENT, 0);
      double currentLow  = iLow(_Symbol, PERIOD_CURRENT, 0);

      m_higherHigh = (currentHigh > m_lastSwingHigh);
      m_higherLow  = (currentLow  > m_lastSwingLow);

      m_lowerHigh  = (currentHigh < m_lastSwingHigh);
      m_lowerLow   = (currentLow  < m_lastSwingLow);
   }

   double LastSwingHigh() const
   {
      return(m_lastSwingHigh);
   }

   double LastSwingLow() const
   {
      return(m_lastSwingLow);
   }

   bool HasHigherHigh() const
   {
      return(m_higherHigh);
   }

   bool HasHigherLow() const
   {
      return(m_higherLow);
   }

   bool HasLowerHigh() const
   {
      return(m_lowerHigh);
   }

   bool HasLowerLow() const
   {
      return(m_lowerLow);
   }

   void PrintStructure()
   {
      LogLine();

      LogInfo("Market Structure");

      Print("Last Swing High : ", DoubleToString(m_lastSwingHigh,_Digits));
      Print("Last Swing Low  : ", DoubleToString(m_lastSwingLow,_Digits));

      Print("Higher High : ", m_higherHigh);
      Print("Higher Low  : ", m_higherLow);
      Print("Lower High  : ", m_lowerHigh);
      Print("Lower Low   : ", m_lowerLow);

      LogLine();
   }

   void Shutdown()
   {
      LogInfo("Structure Engine Shutdown.");
   }
};

#endif