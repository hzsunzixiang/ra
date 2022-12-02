
ClusterName = dyn_members,
Machine = {simple, fun erlang:'+'/2, 0},

% Start a cluster
{ok, _, _} =  ra:start_cluster(default, ClusterName, Machine, [{dyn_members, 'ra2@centos7-dev'}]).

% Add member
{ok, _, _} = ra:add_member({dyn_members, 'ra2@centos7-dev'}, {dyn_members, 'ra1@centos7-dev'}),

% Start the server
ok = ra:start_server(default, ClusterName, {dyn_members, 'ra1@centos7-dev'}, Machine, [{dyn_members, 'ra2@centos7-dev'}]).


% Add a new member
{ok, _, _} = ra:add_member({dyn_members, 'ra2@centos7-dev'}, {dyn_members, 'ra3@centos7-dev'}),

% Start the server
ok = ra:start_server(default, ClusterName, {dyn_members, 'ra3@centos7-dev'}, Machine, [{dyn_members, 'ra2@centos7-dev'}]).

ra:members({dyn_members, node()}).
% => {ok,[{dyn_members,'ra1@centos7-dev'},
% =>      {dyn_members,'ra2@centos7-dev'},
% =>      {dyn_members,'ra3@centos7-dev'}],
% =>      {dyn_members,'ra2@centos7-dev'}}

% Add a new member
{ok, _, _} = ra:add_member({dyn_members, 'ra2@centos7-dev'}, {dyn_members, 'ra4@centos7-dev'}),

% Start the server
ok = ra:start_server(default, ClusterName, {dyn_members, 'ra4@centos7-dev'}, Machine, [{dyn_members, 'ra2@centos7-dev'}]).

%% on ra4@centos7-dev
ra:leave_and_terminate(default, {ClusterName, node()}, {ClusterName, node()}).

ra:members({ClusterName, node()}).
% => {ok,[{dyn_members,'ra1@centos7-dev'},
% =>      {dyn_members,'ra2@centos7-dev'},
% =>      {dyn_members,'ra3@centos7-dev'}],
% =>      {dyn_members,'ra2@centos7-dev'}}
