//+------------------------------------------------------------------+
//| Logger.mqh                                                       |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_LOGGER_MQH__
#define __PHOENIX_LOGGER_MQH__

class CPhoenixLogger
{
public:

   void Line()
   {
      Print("============================================================");
   }

   void Info(string message)
   {
      Print("[INFO] ", message);
   }

   void Warning(string message)
   {
      Print("[WARNING] ", message);
   }

   void Error(string message)
   {
      Print("[ERROR] ", message);
   }
};

CPhoenixLogger gLogger;

// Compatibility wrappers
void LogLine()               { gLogger.Line(); }
void LogInfo(string msg)     { gLogger.Info(msg); }
void LogWarning(string msg)  { gLogger.Warning(msg); }
void LogError(string msg)    { gLogger.Error(msg); }

#endif