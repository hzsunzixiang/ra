
%%%%%%%%%%%%%%%
rebar3 shell --sname ra1@centos7-dev
rebar3 shell --sname ra2@centos7-dev
rebar3 shell --sname ra3@centos7-dev

ErlangNodes = ['ra1@centos7-dev', 'ra2@centos7-dev', 'ra3@centos7-dev'].
[io:format("Attempting to communicate with node ~s, response: ~s~n", [N, net_adm:ping(N)]) || N <- ErlangNodes].
[rpc:call(N, ra, start, []) || N <- ErlangNodes].
ServerIds = [{quick_start, N} || N <- ErlangNodes].
ClusterName = quick_start.
Machine = {simple, fun erlang:'+'/2, 0}.
{ok, ServersStarted, _ServersNotStarted} = ra:start_cluster(default, ClusterName, Machine, ServerIds).
{ok, StateMachineResult, LeaderId} = ra:process_command(hd(ServersStarted), 5).
{ok, 12, LeaderId1} = ra:process_command(LeaderId, 7).


%%%%%%%%%%%%%%%%%%%%%%%
# replace centos7-dev with your actual hostname
rebar3 shell --sname ra1@centos7-dev
# replace centos7-dev with your actual hostname
rebar3 shell --sname ra2@centos7-dev
# replace centos7-dev with your actual hostname
rebar3 shell --sname ra3@centos7-dev


%% All servers in a Ra cluster are named processes on Erlang nodes.
%% The Erlang nodes must have distribution enabled and be able to
%% communicate with each other.
%% See https://learnyousomeerlang.com/distribunomicon if you are new to Erlang/OTP.

%% These Erlang nodes will host Ra nodes. They are the "seed" and assumed to
%% be running or come online shortly after Ra cluster formation is started with ra:start_cluster/4.
ErlangNodes = ['ra1@centos7-dev', 'ra2@centos7-dev', 'ra3@centos7-dev'],

%% This will check for Erlang distribution connectivity. If Erlang nodes
%% cannot communicate with each other, Ra nodes would not be able to cluster or communicate
%% either.
[io:format("Attempting to communicate with node ~s, response: ~s~n", [N, net_adm:ping(N)]) || N <- ErlangNodes],

%% The Ra application has to be started on all nodes before it can be used.
[rpc:call(N, ra, start, []) || N <- ErlangNodes],

%% Create some Ra server IDs to pass to the configuration. These IDs will be
%% used to address Ra nodes in Ra API functions.
ServerIds = [{quick_start, N} || N <- ErlangNodes],

ClusterName = quick_start,
%% State machine that implements the logic and an initial state
Machine = {simple, fun erlang:'+'/2, 0},

%% Start a Ra cluster with an addition state machine that has an initial state of 0.
%% It's sufficient to invoke this function only on one Erlang node. For example, this
%% can be a "designated seed" node or the node that was first to start and did not discover
%% any peers after a few retries.
%%
%% Repeated startup attempts will fail even if the cluster is formed, has elected a leader
%% and is fully functional.
{ok, ServersStarted, _ServersNotStarted} = ra:start_cluster(default, ClusterName, Machine, ServerIds),

%% Add a number to the state machine.
%% Simple state machines always return the full state after each operation.
{ok, StateMachineResult, LeaderId} = ra:process_command(hd(ServersStarted), 5),

%% Use the leader id from the last command result for the next one
{ok, 12, LeaderId1} = ra:process_command(LeaderId, 7).




