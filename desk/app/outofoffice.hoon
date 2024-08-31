  ::  /app/outofoffice
::::
::
/-  *outofoffice, chat
/+  dbug,
    default-agent,
    *outofoffice,
    verb
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      on=?
      message=@t
      recp=(list @p)
  ==
+$  card  card:agent:gall
--
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
    aux      ~(. +> bowl)
++  on-init
  ^-  [(list card) _this]
  ~&  >  "%outofoffice initialized successfully."
  :-  :~  [%pass /dm %agent [our.bowl %chat] %watch /]
      ==
  this
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  [(list card) _this]
  :-  ^-  (list card)
      ~
  %=  this
    state  !<(state-0 old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  [(list card) _this]
  =^  cards  state
    ?+    mark  (on-poke:default mark vase)
        %outofoffice-action
      (take-action !<(action vase))
    ==
  [cards this]
++  on-agent 
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:default wire sign)
      [%dm ~]
    ?+    -.sign  (on-agent:default wire sign)
         %kick
      :_  this
      :~  [%pass /dm %agent [our.bowl %chat] %watch /]
      ==
    ::
        %fact 
      ?+    p.cage.sign  (on-agent:default wire sign)
        %writ-response
        ::~&  >  q.cage.sign
        ::~&  >>  +.-.q.q.cage.sign
        =/  wr  !<([whom:chat response:writs:chat] q.cage.sign)
        ~&  >>>  wr
        =/  from=@p  ;;(@p p.-.wr)
        =/  =id:chat  [from now.bowl]
        =/  =memo:d:chat  :*
          content=[i=[%inline p=[i=message.state t=[i=[%break ~] t=~]]] t=~]
          author=our.bowl
          sent=now.bowl
          ==
        =/  =delta:writs:chat  [%add memo ~ ~]
        =/  =diff:dm:chat  [id delta]
        =/  =action:dm:chat  [from diff]  
        ~&  >>  action
        ?.  on.state  `this
        ?~  (find recp.state ~[from])
          :_  this(recp [from recp])
          :~  [%pass /dm/response %agent [our.bowl %chat] %poke %chat-dm-action !>(action)]
          ==
        `this
      ==
    ==
  ==
::
++  on-watch  on-watch:default
++  on-arvo  on-arvo:default
++  on-peek  on-peek:default
++  on-leave  on-leave:default
++  on-fail   on-fail:default
--
::
::  Helper Core
::
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  take-action
  |=  act=action
  ^-  [(list card) _state]
  ?-  -.act
      %on
    ?:  reset.act  `[%0 %.y message.act ~]
    `[%0 %.y message.act recp.state]
    ::
      %off
    `[%0 %.n message.state recp.state]
    ::
  ==
++  send-update  do-nothing
--
