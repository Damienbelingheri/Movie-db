# MCD

```
CATEGORY: id, label
HAS, 1N MOVIE, 0N CATEGORY

WRITE, 0N PERSON, 0N MOVIE

MOVIE: id, title, release_date
ACT, 0N MOVIE, 0N PERSON: character
PERSON: id, name, birth_date

DIRECT, 0N PERSON, 11 MOVIE

POST: id, title, content, date
REFER, 0N POST, 0N MOVIE
```

