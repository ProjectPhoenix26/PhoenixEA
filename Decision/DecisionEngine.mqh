//+------------------------------------------------------------------+
//| DecisionEngine.mqh - Phoenix Build Sprint 3A Deliverable 2        |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_DECISIONENGINE_MQH__
#define __PHOENIX_DECISIONENGINE_MQH__

enum EPhoenixDecision
{
   DECISION_WAIT=0,
   DECISION_BUY,
   DECISION_SELL
};

struct DecisionContext
{
   bool bullishTrend;
   bool bearishTrend;
   bool bullishBOS;
   bool bearishBOS;
   bool bullishCHOCH;
   bool bearishCHOCH;
   bool riskOK;
   bool positionOpen;

   DecisionContext()
   {
      bullishTrend=false;
      bearishTrend=false;
      bullishBOS=false;
      bearishBOS=false;
      bullishCHOCH=false;
      bearishCHOCH=false;
      riskOK=false;
      positionOpen=false;
   }
};

class CPhoenixDecisionEngine
{
private:
   EPhoenixDecision m_decision;
   string m_reason;

public:
   CPhoenixDecisionEngine()
   {
      m_decision=DECISION_WAIT;
      m_reason="Not evaluated";
   }

   bool Initialize()
   {
      LogInfo("Decision Engine Ready.");
      return(true);
   }

   void Refresh(){}

   void Evaluate(const DecisionContext &ctx)
   {
      m_decision=DECISION_WAIT;
      m_reason="Waiting";

      if(!ctx.riskOK)
      {
         m_reason="Risk Manager blocked trading";
         return;
      }

      if(ctx.positionOpen)
      {
         m_reason="Position already open";
         return;
      }

      if(ctx.bullishTrend && (ctx.bullishBOS || ctx.bullishCHOCH))
      {
         m_decision=DECISION_BUY;
         m_reason="Bullish Trend + Bullish BOS";
         return;
      }

      if(ctx.bearishTrend && (ctx.bearishBOS || ctx.bearishCHOCH))
      {
         m_decision=DECISION_SELL;
         m_reason="Bearish Trend + Bearish BOS";
         return;
      }

      m_reason="No valid setup";
   }

   bool IsBuy()  const { return m_decision==DECISION_BUY;  }
   bool IsSell() const { return m_decision==DECISION_SELL; }
   bool IsWait() const { return m_decision==DECISION_WAIT; }

   EPhoenixDecision Decision() const { return m_decision; }
   string Reason() const { return m_reason; }

   void PrintDiagnostics()
   {
      LogLine();
      LogInfo("Decision Engine");
      Print("Decision : ",EnumToString(m_decision));
      Print("Reason   : ",m_reason);
      LogLine();
   }

   void Shutdown()
   {
      LogInfo("Decision Engine Shutdown.");
   }
};

#endif
