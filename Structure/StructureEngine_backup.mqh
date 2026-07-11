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

   double m_previousSwingHigh;
   double m_currentSwingHigh;

   double m_previousSwingLow;
   double m_currentSwingLow;

   bool m_higherHigh;
   bool m_higherLow;
   bool m_lowerHigh;
   bool m_lowerLow;

   int m_lookback;

public:

   CPhoenixStructureEngine()
   {
      m_previousSwingHigh = 0.0;
      m_currentSwingHigh  = 0.0;

      m_previousSwingLow = 0.0;
      m_currentSwingLow  = 0.0;

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
      m_previousSwingHigh = m_currentSwingHigh;
      m_previousSwingLow  = m_currentSwingLow;

      m_currentSwingHigh = iHigh(_Symbol, PERIOD_CURRENT, 1);
      m_currentSwingLow  = iLow(_Symbol, PERIOD_CURRENT, 1);

      for(int i = 2; i <= m_lookback; i++)
      {
         double high = iHigh(_Symbol, PERIOD_CURRENT, i);
         double low  = iLow(_Symbol, PERIOD_CURRENT, i);

         if(high > m_currentSwingHigh)
            m_currentSwingHigh = high;

         if(low < m_currentSwingLow)
            m_currentSwingLow = low;
      }

      double currentHigh = iHigh(_Symbol, PERIOD_CURRENT, 0);
      double currentLow  = iLow(_Symbol, PERIOD_CURRENT, 0);

      m_higherHigh = (m_currentSwingHigh > m_previousSwingHigh);
      m_higherLow  = (m_currentSwingLow > m_previousSwingLow);

      m_lowerHigh  = (m_currentSwingHigh < m_previousSwingHigh);
      m_lowerLow   = (m_currentSwingLow < m_previousSwingLow);
   }

   double CurrentSwingHigh() const
   {
      return(m_currentSwingHigh);
   }

   double CurrentSwingLow() const
   {
      return(m_currentSwingLow);
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

      Print("Previous Swing High : ", DoubleToString(m_previousSwingHigh,_Digits));
      Print("Current Swing High  : ", DoubleToString(m_currentSwingHigh,_Digits));
      Print("Previous Swing Low  : ", DoubleToString(m_previousSwingLow,_Digits));
      Print("Current Swing Low   : ", DoubleToString(m_currentSwingLow,_Digits));

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