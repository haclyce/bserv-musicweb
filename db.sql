CREATE TABLE auth_user (
    id serial PRIMARY KEY,
    username character varying(255) NOT NULL UNIQUE,
    password character varying(255) NOT NULL,
    is_superuser boolean NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    is_active boolean NOT NULL
);

CREATE TABLE music(
    id serial PRIMARY KEY,
    sid int,
    musicname character varying(255) NOT NULL UNIQUE,
    length int default(0) NOT NULL,
    year int default(0),
    language character varying(255) NOT NULL,
    sname character varying(255),
    
    FOREIGN KEY (sid) REFERENCES singers(id)

);

CREATE TABLE COLLECTION(
    uname character varying(255) NOT NULL,
    mname character varying(255) NOT NULL,
    freq int,
    is_favorite boolean NOT NULL,
    PRIMARY KEY (uname,mname),
    FOREIGN KEY (uname) REFERENCES auth_user(username),
    FOREIGN KEY (mname) REFERENCES music(musicname)
);

CREATE TABLE singers(
    id serial PRIMARY KEY,
    sname character varying(   255) NOT NULL,
    sex character varying(1),
    birthyear int,
    area character varying(255),
    message character varying(1000),
    award  character varying(1000)
);







 insert into singers(sname,sex,birthyear,area)
 values('JayChou','M',1979,'China'),
        ('Imagine Dragons','T', 2008,'America'),
        ('jj-Lin','M',1981,'Singapore');

select x.musicname,x.sname,x.language,x.length,x.id,x.year
from music as x
where x.language in (select y.language
from music as y,collection as z
where z.uname='super' and y.musicname=z.mname
group by y.language
                    having sum(z.freq)>=
                        all (select sum (freq)
                                from music,collection
                                where music.musicname=collection.mname
                                    and collection.uname='super'
                                group by music.language)   
      
)
limit 10 offset 0;

