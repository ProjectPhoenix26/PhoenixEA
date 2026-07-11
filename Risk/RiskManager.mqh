//+------------------------------------------------------------------+
//| RiskManager.mqh                                                   |
//| Phoenix EA Build 005                                              |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_RISKMANAGER_MQH__
#define __PHOENIX_RISKMANAGER_MQH__

class CPhoenixRiskManager
{
private:
   double m_riskPercent;
   double m_maxSpread;
   int    m_maxOpenTrades;
   bool   m_canTrade;

public:
   CPhoenixRiskManager()
   {
      m_riskPercent   = 1.0;
      m_maxSpread     = 30.0;
      m_maxOpenTrades = 1;
      m_canTrade      = true;
   }

   bool Initialize()
   {
      LogInfo("Risk Manager Ready.");
      return(true);
   }

   void Refresh()
   {
      m_canTrade = true;

      double spread=(SymbolInfoDouble(_Symbol,SYMBOL_ASK)-SymbolInfoDouble(_Symbol,SYMBOL_BID))/_Point;

      if(spread>m_maxSpread)
         m_canTrade=false;

      if(PositionsTotal()>=m_maxOpenTrades)
         m_canTrade=false;
   }

   bool CanTrade() const
   {
      return m_canTrade;
   }

   double CalculateLotSize(double stopLossPoints) const
   {
      if(stopLossPoints<=0.0)
         return(0.01);

      double riskMoney=AccountInfoDouble(ACCOUNT_BALANCE)*(m_riskPercent/100.0);
      double tickValue=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
      double lotStep=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

      double lots=riskMoney/(stopLossPoints*tickValue);
      if(lotStep>0)
         lots=MathFloor(lots/lotStep)*lotStep;

      double minLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
      double maxLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);

      if(lots<minLot) lots=minLot;
      if(lots>maxLot) lots=maxLot;

      return NormalizeDouble(lots,2);
   }

   void PrintDiagnostics()
   {
      LogLine();
      LogInfo("Risk Manager");
      Print("Trading Allowed : ",m_canTrade);
      Print("Risk %          : ",DoubleToString(m_riskPercent,2));
      Print("Max Spread      : ",DoubleToString(m_maxSpread,1));
      Print("Max Trades      : ",m_maxOpenTrades);
      LogLine();
   }

   void Shutdown()
   {
      LogInfo("Risk Manager Shutdown.");
   }
};

#endif
