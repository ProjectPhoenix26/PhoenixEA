class CPhoenixPriceAction
{
public:

   bool Initialize();

   void Refresh();

   bool IsBullish();

   bool IsBearish();

   bool IsDoji();

   double BodySize();

   double UpperWick();

   double LowerWick();

   double CandleRange();

   void PrintSnapshot();
};