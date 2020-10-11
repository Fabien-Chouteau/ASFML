with Sf.Config; use Sf.Config;

with Sf.System.Time;

package body Sf.System.Sleep is

   procedure sfDelay (Seconds : Duration) is
   begin
      sfSleep (Duration => Time.sfSeconds (Float (Seconds)));
   end sfDelay;

end Sf.System.Sleep;
