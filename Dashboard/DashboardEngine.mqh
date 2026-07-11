//+------------------------------------------------------------------+
//| DashboardEngine.mqh                                               |
//| Phoenix EA Build 008                                              |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_DASHBOARDENGINE_MQH__
#define __PHOENIX_DASHBOARDENGINE_MQH__

class CPhoenixDashboardEngine
{
private:
   string m_symbol;
   string m_tf;
   string m_market;
   string m_trend;
   string m_structure;
   string m_decision;
   string m_risk;

public:
   bool Initialize()
   {
      m_symbol=_Symbol;
      m_tf=EnumToString((ENUM_TIMEFRAMES)_Period);
      m_market="UNKNOWN";
      m_trend="UNKNOWN";
      m_structure="UNKNOWN";
      m_decision="WAIT";
      m_risk="OK";
      Comment("");
      return(true);
   }

   void Refresh()
   {
      string dash;
      dash+="==============================\n";
      dash+="        PHOENIX EA\n";
      dash+="==============================\n";
      dash+="Symbol     : "+m_symbol+"\n";
      dash+="Timeframe  : "+m_tf+"\n\n";
      dash+="Market     : "+m_market+"\n";
      dash+="Trend      : "+m_trend+"\n";
      dash+="Structure  : "+m_structure+"\n";
      dash+="Risk       : "+m_risk+"\n";
      dash+="Decision   : "+m_decision+"\n";
      dash+="==============================";
      Comment(dash);
   }

   void SetMarket(string v){m_market=v;}
   void SetTrend(string v){m_trend=v;}
   void SetStructure(string v){m_structure=v;}
   void SetRisk(string v){m_risk=v;}
   void SetDecision(string v){m_decision=v;}

   void Shutdown()
   {
      Comment("");
   }
};

#endif
