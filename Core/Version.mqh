//+------------------------------------------------------------------+
//| Version.mqh                                                      |
//+------------------------------------------------------------------+
#ifndef __PHOENIX_VERSION_MQH__
#define __PHOENIX_VERSION_MQH__

#define PHOENIX_NAME      "Phoenix EA"
#define PHOENIX_VERSION   "v1.0.001"
#define PHOENIX_BUILD     "Build 001"

string PhoenixFullVersion()
{
   return StringFormat("%s %s",
                       PHOENIX_NAME,
                       PHOENIX_VERSION);
}

string PhoenixBuild()
{
   return PHOENIX_BUILD;
}

#endif