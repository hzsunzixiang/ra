aft cluster leader
{ok, _Members, LeaderId} = ra:members(quick_start),
%% perform a leader query on the leader node
QueryFun = fun(StateVal) -> StateVal end,
{ok, {_TermMeta, State}, LeaderId1} = ra:leader_query(LeaderId, QueryFun).


%% this is the replica hosted on the current Erlang node.
%% alternatively it can be constructed as {ClusterName, node()}
{ok, Members, _LeaderId} = ra:members(quick_start),
LocalReplicaId = lists:keyfind(node(), 2, Members),
%% perform a local query on the local node
QueryFun = fun(StateVal) -> StateVal end,
{ok, {_TermMeta, State}, LeaderId1} = ra:local_query(LocalReplicaId, QueryFun).
