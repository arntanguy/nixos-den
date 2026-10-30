{ den, ... }:
{
  den.aspects.lirmm.teams.idh = {
    includes = [
      den.aspects.communication
    ]
    ++ (with den.aspects.lirmm; [
      printing.idh-robcolor
      networking.panda-robots
      networking.rhps1-robot
    ]);
  };
}
