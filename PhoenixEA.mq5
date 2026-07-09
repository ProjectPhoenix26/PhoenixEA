//+------------------------------------------------------------------+
//|                                              PhoenixEA.mq5       |
//|                        Project Phoenix EA v1.0                   |
//|                 Build 001 - Foundation Framework                 |
//+------------------------------------------------------------------+
#property copyright "Project Phoenix"
#property version "1.001"
#property strict


//-------------------------------------------------------------------
// Core Modules
//-------------------------------------------------------------------
#include "Core/Version.mqh"
#include "Core/Config.mqh"
#include "Core/Logger.mqh"
#include "Core/Globals.mqh"
#include "Core/Engine.mqh"

//-------------------------------------------------------------------
// Input Parameters
//-------------------------------------------------------------------
input bool  InpEnableTimer = true;
input int   InpTimerSeconds = 1;

//-------------------------------------------------------------------
// Global Engine
//-------------------------------------------------------------------
CPhoenixEngine Engine;

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   gMagicNumber = InpMagicNumber;

   LogInfo("===========================================");
   LogInfo(PHOENIX_NAME + " " + PHOENIX_VERSION);
   LogInfo("Initializing...");

   if(!Engine.Initialize())
   {
      LogError("Engine initialization failed.");
      return(INIT_FAILED);
   }

   if(InpEnableTimer)
      EventSetTimer(InpTimerSeconds);

   LogInfo("Initialization complete.");

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   Engine.Update();
}

//+------------------------------------------------------------------+
//| Timer Event                                                      |
//+------------------------------------------------------------------+
void OnTimer()
{
   Engine.UpdateTimer();
}

//+------------------------------------------------------------------+
//| Trade Transaction                                                |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
{
   Engine.OnTradeTransaction(trans, request, result);
}

//+------------------------------------------------------------------+
//| Deinitialization                                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(InpEnableTimer)
      EventKillTimer();

   Engine.Shutdown();

   LogInfo("Phoenix EA stopped.");
}