%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(all).      
 
-export([start/0]).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
    
    ok=setup(),
    ok=normal_test(),
    ok=dist_test:start(),
 
    io:format("Test OK !!! ~p~n",[?MODULE]),
   % timer:sleep(1000),
   % init:stop(),
    ok.


%%--------------------------------------------------------------------
%% @doc
%% 
%% @end
%%--------------------------------------------------------------------
normal_test()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),

    io:format("mnesia system_info ~p~n",[{mnesia:system_info(),?MODULE,?FUNCTION_NAME,?LINE}]),
    ok=kvs:create(key1,value1),
    {ok,[{key1,value1}]}=kvs:get_all(),
    {ok,value1}=kvs:read(key1),
    {error,["Doesnt exists Key ",glurk,lib_kvs,_]}=kvs:read(glurk),
    
    ok=kvs:update(key1,value11),
    {ok,value11}=kvs:read(key1),
    {error,["Doesn't exists",glurk,lib_kvs,_]}=kvs:update(glurk,value11),
    
    ok=kvs:delete(key1),
    {error,["Doesnt exists Key ",key1,lib_kvs,_]}=kvs:read(key1),
    {error,["Doesn't exists",glurk,lib_kvs,_]}=kvs:delete(glurk),
    
  
    ok=kvs:create(key1,value10),
    ok=kvs:create(key2,value20),
   {ok,[{key2,value20},{key1,value10}]}=kvs:get_all(),

    ok.
    


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
setup()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),


    {ok,_}=log:start_link(),
    
    
    {ok,_}=rd:start_link(),
    {ok,_}=kvs:start_link(),
  
    pong=log:ping(),
    pong=rd:ping(),
    pong=kvs:ping(),
    ok.
    
