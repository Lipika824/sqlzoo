##1962 movies
#1.List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962

##When was Citizen Kane released?
#2.Give year of 'Citizen Kane'.
select yr from movie where title='Citizen Kane'

##Star Trek movies
#3.List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
select id,title,yr from movie where title like('%Star Trek%') order by yr

##id for actor Glenn Close
#4.What id number does the actor 'Glenn Close' have?
select id from actor where name='Glenn Close'

##id for Casablanca
#5.What is the id of the film 'Casablanca'
select id from movie where title='Casablanca'

##Cast list for Casablanca
#6.Obtain the cast list for 'Casablanca'.

##what is a cast list?
#Use movieid=11768, (or whatever value you got from the previous question)
SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
WHERE casting.movieid = 11768;

##Alien cast list
#7.Obtain the cast list for the film 'Alien'
select actor.name from actor join casting on actor.id=casting.actorid join movie on movie.id=casting.movieid where movie.title='Alien'

##Harrison Ford movies
#8.List the films in which 'Harrison Ford' has appeared
select movie.title from actor join casting on actor.id=casting.actorid join movie on movie.id=casting.movieid where actor.name='Harrison Ford';

##Harrison Ford as a supporting actor
#9.List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
select movie.title from actor join casting on actor.id=casting.actorid join movie on movie.id=casting.movieid where actor.name='Harrison Ford' and not ord=1

##Lead actors in 1962 movies
#10.List the films together with the leading star for all 1962 films.
select movie.title,actor.name from actor join casting on actor.id=casting.actorid join movie on movie.id=casting.movieid where movie.yr=1962 and casting.ord=1;

##Busy years for Rock Hudson
#11.Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name= 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

##Lead actor in Julie Andrews movies
#12.List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT movie.title,actor.name FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE ord=1 and title IN(SELECT movie.title from movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id where actor.name='Julie Andrews')

##Actors with 15 leading roles
#13.Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT actor.name FROM
  actor JOIN casting ON (actorid=actor.id
and (select count(ord) from casting  where actor.id=casting.actorid and ord=1)>=15) group by name

##released in the year 1978
#14.List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC

##with 'Art Garfunkel'
#15.List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name
