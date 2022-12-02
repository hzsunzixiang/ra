
ClusterName = dyn_members,
Machine = {simple, fun erlang:'+'/2, 0},

% Start a cluster
{ok, _, _} =  ra:start_cluster(default, ClusterName, Machine, [{dyn_members, 'ra2@hostname.local'}]).

% Add member
{ok, _, _} = ra:add_member({dyn_members, 'ra2@hostname.local'}, {dyn_members, 'ra1@hostname.local'}),

% Start the server
ok = ra:start_server(default, ClusterName, {dyn_members, 'ra1@hostname.local'}, Machine, [{dyn_members, 'ra2@hostname.local'}]).


% Add a new member
{ok, _, _} = ra:add_member({dyn_members, 'ra2@hostname.local'}, {dyn_members, 'ra3@hostname.local'}),

% Start the server
ok = ra:start_server(default, ClusterName, {dyn_members, 'ra3@hostname.local'}, Machine, [{dyn_members, 'ra2@hostname.local'}]).

ra:members({dyn_members, node()}).
% => {ok,[{dyn_members,'ra1@hostname.local'},
% =>      {dyn_members,'ra2@hostname.local'},
% =>      {dyn_members,'ra3@hostname.local'}],
% =>      {dyn_members,'ra2@hostname.local'}}

% Add a new member
{ok, _, _} = ra:add_member({dyn_members, 'ra2@hostname.local'}, {dyn_members, 'ra4@hostname.local'}),

% Start the server
ok = ra:start_server(default, ClusterName, {dyn_members, 'ra4@hostname.local'}, Machine, [{dyn_members, 'ra2@hostname.local'}]).

%% on ra4@hostname.local
ra:leave_and_terminate(default, {ClusterName, node()}, {ClusterName, node()}).

ra:members({ClusterName, node()}).
% => {ok,[{dyn_members,'ra1@hostname.local'},
% =>      {dyn_members,'ra2@hostname.local'},
% =>      {dyn_members,'ra3@hostname.local'}],
% =>      {dyn_members,'ra2@hostname.local'}}
