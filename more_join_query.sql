-- MOER JOIN QUERIES


-- 1 List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962
 
-- 2 Give year of 'Citizen Kane'. 
select yr from movie where title = 'Citizen Kane'

-- 3 List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
select id, title, yr from movie where title like '%Star Trek%'

-- 4 What id number does the actor 'Glenn Close' have? 
select id from actor where name = 'Glenn Close'

-- 5 What is the id of the film 'Casablanca' 
select id from movie where title = 'Casablanca'

-- 6 Obtain the cast list for 'Casablanca'. 
select name from casting join actor on actorid = id where movieid=11768

-- 7 Obtain the cast list for the film 'Alien' 
select name 
  from actor join casting  
    on actor.id = actorid 
      join movie 
        on movieid = movie.id 
where title = 'Alien'

-- 8 List the films in which 'Harrison Ford' has appeared
select title from movie join casting on movieid = movie.id join actor on actorid = actor.id where name = 'Harrison Ford'

-- 9 List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of 
-- the actor. If ord=1 then this actor is in the starring role] 
select title from movie join casting on movieid = movie.id join actor on actorid = actor.id where name = 'Harrison Ford' and ord != 1

-- 10 List the films together with the leading star for all 1962 films. 
select title, name from movie join casting on movieid = movie.id join  actor on actorid = actor.id where yr = 1962 and ord = 1

-- 11 Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made 
-- more than 2 movies. 
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

-- 12 Lead actor in Julie Andrews movies
SELECT title, name FROM casting
join movie on (movieid = movie.id and ord = 1) join actor on actorid = actor.id
WHERE movie.id IN (
  SELECT movieid FROM casting
    WHERE actorid in (
      select id from actor where name ='Julie Andrews'))

-- 13 Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 
SELECT name FROM casting JOIN movie 
	ON movieid=movie.id 
JOIN actor ON actorid=actor.id WHERE ord=1 GROUP BY name having count(ord) >= 30 order by name

-- 14 List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
select title, count(actorid) from movie join casting on movieid = movie.id join actor on actor.id = actorid where yr = 1978 group by title order by count(actorid) desc, title

-- 15 List all the people who have worked with 'Art Garfunkel'. 
SELECT distinct name FROM casting
join movie on (movieid = movie.id) join actor on actorid = actor.id
WHERE movie.id IN (
  SELECT movieid FROM casting
    WHERE actorid in (
      select id from actor where name ='Art Garfunkel'))