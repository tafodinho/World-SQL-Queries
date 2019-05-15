-- JOIN QUERIES


-- 1 show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

-- 2 Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up 
-- information about game 1012 by finding that row in the game table.
SELECT id, stadium, team1, team2
  FROM game
    where id = 1012

-- 3 show the player, teamid, stadium and mdate for every German goal.
SELECT player,teamid,stadium, mdate
  FROM game JOIN goal ON (id=matchid)
    where teamid = 'GER'

-- 4 Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
select team1, team2, player 
  from game 
    join goal on id = matchid
      where player like 'Mario%'

-- 5 Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal 
    join eteam on teamid = id 
 WHERE gtime<=10

-- 6 List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
select mdate, teamname
  from eteam join game
    on eteam.id = team1 
     where coach = 'Fernando Santos'

-- 7 List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
select player
  from game 
    join goal on matchid = id 
      where stadium = 'National Stadium, Warsaw'

-- 8 The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.
SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE ((team1='GER' or team2='GER') and teamid != 'GER')

-- 9 Show teamname and the total number of goals scored.
SELECT teamname, count(gtime)
  FROM eteam JOIN goal ON id=teamid
 group BY teamname

-- 10 Show the stadium and the number of goals scored in each stadium. 
select stadium, count(gtime)
from game join goal on id = matchid 
group by stadium

-- 11 For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, count(gtime)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid, mdate

-- 12 For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
select matchid, mdate, count(gtime) 
  from game  
    join goal on matchid = id
      where teamid = 'GER' group by matchid, mdate

-- 13 List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
SELECT mdate, team1, CASE 
  WHEN teamid=team1 THEN count(team1) else 0
      END score1, team2,
  case when teamid=team2 then count(team2) else 0
  end score2
FROM game 
  JOIN goal 
  ON matchid = id 
GROUP BY mdate, matchid, teamid, team1, team2;