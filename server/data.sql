CREATE DATABASE videosapp;

CREATE TABLE
    videos (
        id VARCHAR(255) PRIMARY KEY,
        title VARCHAR(255),
        url VARCHAR(255),
        rating INT
    );

\set content `cat 'exampleresponse.json'`

 INSERT INTO videos SELECT * FROM json_populate_recordset(null::videos, :'content');

-- .............. --

with customer_json (doc) as (
   values 
    ('[
  {
    "id": 523523,
    "title": "Never Gonna Give You Up",
    "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    "rating": 23
  },
  {
    "id": 523427,
    "title": "The Coding Train",
    "url": "https://www.youtube.com/watch?v=HerCR8bw_GE",
    "rating": 230
  },
  {
    "id": 82653,
    "title": "Mac & Cheese | Basics with Babish",
    "url": "https://www.youtube.com/watch?v=FUeyrEN14Rk",
    "rating": 2111
  },
  {
    "id": 858566,
    "title": "Videos for Cats to Watch - 8 Hour Bird Bonanza",
    "url": "https://www.youtube.com/watch?v=xbs7FT7dXYc",
    "rating": 11
  },
  {
    "id": 453538,
    "title": "The Complete London 2012 Opening Ceremony | London 2012 Olympic Games",
    "url": "https://www.youtube.com/watch?v=4As0e4de-rI",
    "rating": 3211
  },
  {
    "id": 283634,
    "title": "Learn Unity - Beginner''s Game Development Course",
    "url": "https://www.youtube.com/watch?v=gB1F9G0JXOo",
    "rating": 211
  },
  {
    "id": 562824,
    "title": "Cracking Enigma in 2021 - Computerphile",
    "url": "https://www.youtube.com/watch?v=RzWB5jL5RX0",
    "rating": 111
  },
  {
    "id": 442452,
    "title": "Coding Adventure: Chess AI",
    "url": "https://www.youtube.com/watch?v=U4ogK0MIzqk",
    "rating": 671
  },
  {
    "id": 536363,
    "title": "Coding Adventure: Ant and Slime Simulations",
    "url": "https://www.youtube.com/watch?v=X-iSQQgOd1A",
    "rating": 76
  },
  {
    "id": 323445,
    "title": "Why the Tour de France is so brutal",
    "url": "https://www.youtube.com/watch?v=ZacOS8NBK6U",
    "rating": 73
  }
]
'::json)
)
insert into videos (id, title, url,rating)
select p.*
from customer_json l
  cross join lateral json_populate_recordset(null::videos, doc) as p
on conflict (id) do update 
  set title = excluded.title, 
      url = excluded.url,
	  rating= excluded.rating;