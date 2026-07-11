//+------------------------------------------------------------------+
//| ExecutionEngine.mqh                                               |
//| Phoenix EA Build 006                                              |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_EXECUTIONENGINE_MQH__
#define __PHOENIX_EXECUTIONENGINE_MQH__

#include <Trade/Trade.mqh>

class CPhoenixExecutionEngine
{
private:
   CTrade m_trade;

public:
   bool Initialize()
   {
      LogInfo("Execution Engine Ready.");
      return(true);
   }

   void Refresh()
   {
   }

   bool Buy(double lots,double sl,double tp,string comment="Phoenix Buy")
   {
      return m_trade.Buy(lots,_Symbol,0.0,sl,tp,comment);
   }

   bool Sell(double lots,double sl,double tp,string comment="Phoenix Sell")
   {
      return m_trade.Sell(lots,_Symbol,0.0,sl,tp,comment);
   }

   bool ClosePosition()
   {
      if(!PositionSelect(_Symbol))
         return false;
      return m_trade.PositionClose(_Symbol);
   }

   void PrintDiagnostics()
   {
      LogLine();
      LogInfo("Execution Engine");
      Print("Position Open : ",PositionSelect(_Symbol));
      LogLine();
   }

   void Shutdown()
   {
      LogInfo("Execution Engine Shutdown.");
   }
};

#endif
