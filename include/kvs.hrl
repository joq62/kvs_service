%%-------------------------------------------------------------
%% Hrl file
%%-------------------------------------------------------------
-define(TABLE,key_value_store).
-define(RECORD,key_value_store).

-record(?RECORD,{
		 key,
		 value
		}).


%%---------- Log
-define(MainLogDir,"logs").
-define(LocalLogDir,"log.logs").
-define(LogFile,"test_logfile").
-define(MaxNumFiles,10).
-define(MaxNumBytes,100000).
