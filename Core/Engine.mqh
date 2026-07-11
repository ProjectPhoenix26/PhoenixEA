// Sprint 3A Deliverable 3 - Live DecisionContext integration
//+------------------------------------------------------------------+
//| Engine.mqh                                                       |
//| Phoenix EA v1.0.004                                              |
//| Build 004A - Structure Engine Integration                        |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_ENGINE_MQH__
#define __PHOENIX_ENGINE_MQH__

#include "../Market/MarketData.mqh"
#include "../Trend/TrendEngine.mqh"
#include "../Structure/StructureEngine.mqh"
#include "../Risk/RiskManager.mqh"
#include "../Decision/DecisionEngine.mqh"
#include "../Execution/ExecutionEngine.mqh"
#include "../Dashboard/DashboardEngine.mqh"

class CPhoenixEngine
{
private:

   bool m_initialized;

   CPhoenixMarketData      m_market;
   CPhoenixTrendEngine     m_trend;
   CPhoenixStructureEngine m_structure;

public:

   CPhoenixEngine()
   {
      m_initialized = false;
   }

   //==============================================================
   // Initialize
   //==============================================================
   bool Initialize()
   {
      LogInfo("Initializing Phoenix Engine...");

      gMagicNumber = InpMagicNumber;

      //----------------------------------------------------------
      // Market Engine
      //----------------------------------------------------------

      if(!m_market.Initialize())
      {
         LogError("Market Engine failed.");
         return(false);
      }

      //----------------------------------------------------------
      // Trend Engine
      //----------------------------------------------------------

      if(!m_trend.Initialize())
      {
         LogError("Trend Engine failed.");
         return(false);
      }

      //----------------------------------------------------------
      // Structure Engine
      //----------------------------------------------------------

      if(!m_structure.Initialize())
      {
         LogError("Structure Engine failed.");
         return(false);
      }

      m_initialized = true;

      LogInfo("Phoenix Engine Ready.");

      return(true);
   }

   //==============================================================
   // Update
   //==============================================================
   void Update()
   {
      if(!m_initialized)
         return;

      //----------------------------------------------------------
      // Refresh Modules
      //----------------------------------------------------------

      m_market.Refresh();

      m_trend.Refresh();

      m_structure.Refresh();

      //----------------------------------------------------------
      // RC1 Modules
// RC1 Patch 3
// DecisionContext wiring scaffold
// DecisionContext ctx;
// ctx.riskOK = m_risk.CanTrade();
// Populate trend/structure fields after interface verification.
// m_decision.Evaluate(ctx);
// End RC1 Patch 3

// NOTE: Integration scaffold added.
// TODO:
// m_risk.Refresh();
// DecisionContext ctx;
// m_decision.Evaluate(ctx);
// m_dashboard.Refresh();
// SAFE MODE: execution intentionally disabled.

// Future Builds
      //----------------------------------------------------------

      // Liquidity Engine

      // Momentum Engine

      // Decision Engine

      // Risk Engine

      // Execution Engine
   }

   //==============================================================
   // Timer
   //==============================================================
   void UpdateTimer()
   {
      if(!m_initialized)
         return;

      // Reserved
   }

   //==============================================================
   // Shutdown
   //==============================================================
   void Shutdown()
   {
      m_structure.Shutdown();

      m_trend.Shutdown();

      LogInfo("Phoenix Engine Shutdown.");

      m_initialized = false;
   }

   //==============================================================
   // Trade Transaction
   //==============================================================
   void OnTradeTransaction(
      const MqlTradeTransaction &trans,
      const MqlTradeRequest &request,
      const MqlTradeResult &result)
   {
      // Reserved for Build 009
   }

 


   //================ RC1 Patch 2 =================
   // Integration shutdown scaffold.
   // m_dashboard.Shutdown();
   // m_execution.Shutdown();
   // m_decision.Shutdown();
   // m_risk.Shutdown();
   //==============================================



//================ RC1 Patch 4 =================
// Dashboard integration scaffold.
//
// Example:
// m_dashboard.Refresh();
// Display BUY / SELL / WAIT from DecisionEngine.
//==============================================

};


#endif

//================ RC1 Patch 5 =================
// Safe Mode execution gate
input bool EnableAutoTrading = false;

// In update loop:
// if(EnableAutoTrading)
// {
//    // Execute BUY/SELL based on DecisionEngine signal
// }
// else
// {
//    // SAFE MODE: dashboard only, no live orders.
// }
//==============================================
