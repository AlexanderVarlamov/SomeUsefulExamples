Create table IF NOT EXISTS sales 
(sales_id INT PRIMARY KEY, 
sales_dt timestamp DEFAULT now(),  
customer_id INT, 
item_id INT, 
cnt INT, 
price_per_item DECIMAL(19,4));

INSERT INTO sales
(sales_id, sales_dt, customer_id, item_id, cnt, price_per_item)
VALUES
(1, '2020-01-10T10:00:00', 100, 200, 2, 30.15),
(2, '2020-01-11T11:00:00', 100, 311, 1, 5.00),
(3, '2020-01-12T14:00:00', 100, 400, 1, 50.00),
(4, '2020-01-12T20:00:00', 100, 311, 5, 5.00),
(5, '2020-01-13T10:00:00', 150, 311, 1, 5.00),
(6, '2020-01-13T11:00:00', 100, 315, 1, 17.00),
(7, '2020-01-14T10:00:00', 150, 200, 2, 30.15),
(8, '2020-01-14T15:00:00', 100, 380, 1, 8.00),
(9, '2020-01-14T18:00:00', 170, 380, 3, 8.00),
(10, '2020-01-15T09:30:00', 100, 311, 1, 5.00),
(11, '2020-01-15T12:45:00', 150, 311, 5, 5.00),
(12, '2020-01-15T21:30:00', 170, 200, 1, 30.15);

SELECT * FROM sales

SELECT sales_id, customer_id, cnt, 
SUM(cnt) OVER () as total,
SUM(cnt) OVER (ORDER BY customer_id ) AS cum,
SUM(cnt) OVER (ORDER BY customer_id, sales_id) AS cum_uniq
FROM sales
ORDER BY customer_id, sales_id;

SELECT EXTRACT(epoch from( timestamp '1900-01-01 12:00:00' - timestamp '1900-01-01 22:00:00' + INTERVAL '24 hour'))/60

--Упражнение 77
WITH dur as(
select trip_no,
case when time_in<time_out THEN  
			EXTRACT(epoch from(time_in - time_out + INTERVAL '24 hour'))/60
ELSE EXTRACT(epoch from(time_in - time_out))/60
END AS dur
from trip
)

SELECT (SELECT name FROM passenger p WHERE p.id_psg=pit.id_psg), sum(d.dur) 
FROM dur d JOIN pass_in_trip pit
ON d.trip_no=pit.trip_no
GROUP BY id_psg
HAVING count(DISTINCT pit.place)=count(pit.place)

--Упражнение 77
WITH cnts AS (
SELECT count(distinct trip_no) AS cnt, date
FROM pass_in_trip
WHERE trip_no IN (
					SELECT trip_no FROM TRIP
					WHERE town_from='Rostov')
GROUP BY date
)
SELECT cnt AS qty, date
FROM cnts
WHERE cnt = (SELECT max(cnt) FROM cnts)

--Упражнение 78
SELECT name, 
to_char(date_trunc('month', "date"), 'YYYY-MM-DD')  AS "first", 
to_char(date_trunc('month', date + INTERVAL '1 month') - INTERVAL '1 day', 'YYYY-MM-DD' ) AS last
FROM battles 

--Упражнение 79
WITH dur as(
SELECT id_psg, sum(dur) tm
FROM (select trip_no,
case when time_in<time_out THEN  
			EXTRACT(epoch from(time_in - time_out + INTERVAL '24 hour'))/60
ELSE EXTRACT(epoch from(time_in - time_out))/60
END AS dur
from trip) d JOIN pass_in_trip p
ON p.trip_no=d.trip_no
GROUP BY id_psg
)

SELECT name, tm
FROM dur d JOIN passenger p
ON p.id_psg=d.id_psg
WHERE tm=(SELECT max(tm) FROM dur)


--Упражнение 80
SELECT DISTINCT maker
FROM PRODUCT
EXCEPT
SELECT maker
FROM Product p1
WHERE TYPE='PC' AND model NOT in(SELECT MODEL FROM pc)
GROUP BY Maker
EXCEPT
SELECT DISTINCT maker
FROM Product
WHERE NOT EXISTS (SELECT 1 FROM product WHERE TYPE = 'PC')

--Упражнение 81
WITH mx AS
(SELECT sum(OUT) ot, to_char(date, 'YYYY-MM') AS overall 
FROM outcome
GROUP BY to_char(date, 'YYYY-MM'))
,

max_month AS (
SELECT overall AS max_month
FROM mx
WHERE ot = (SELECT max(ot) FROM mx)
)

SELECT *
FROM Outcome
WHERE to_char(date, 'YYYY-MM') IN (SELECT max_month FROM max_month )

--Упражение 82

WITH al AS(
SELECT
	code,
	avg(price) OVER(
ORDER BY
	code ROWS BETWEEN CURRENT ROW AND 5 FOLLOWING) AS avg,
	ROW_NUMBER() OVER (
ORDER BY
	code) AS rn
FROM
	PC
ORDER BY
	code
)

SELECT
	code,
	avg
FROM
	al
LIMIT (
SELECT
	max(rn)-5
FROM
	al)

	
--Упражнение 83
	
WITH al AS(
SELECT
	NAME,
	CASE
		WHEN numGuns = 8 THEN 1
		ELSE 0
	END AS NG,
	CASE
		WHEN bore = 15 THEN 1
		ELSE 0
	END AS B,
	CASE
		WHEN displacement = 32000 THEN 1
		ELSE 0
	END AS D,
	CASE
		WHEN TYPE = 'bb' THEN 1
		ELSE 0
	END t,
	CASE
		WHEN launched = 1915 THEN 1
		ELSE 0
	END AS l,
	CASE
		WHEN c.CLASS = 'Kongo' THEN 1
		ELSE 0
	END cl,
	CASE
		WHEN country = 'USA' THEN 1
		ELSE 0
	END AS co
FROM
	shipS s
JOIN classes c 
	ON
	s.CLASS = c.class
)

SELECT
	name
FROM
	al
WHERE
	ng + b + d + t + l + cl + co >= 4
	
--Упражнение 84
SELECT
	DISTINCT
	c.name,
	count(*) FILTER (
	WHERE
	p.date BETWEEN make_date(2003, 04, 1) AND make_date(2003, 04, 10)) OVER (PARTITION BY c.name) AS "1-10",
	count(*) FILTER (
	WHERE
	p.date BETWEEN make_date(2003, 04, 11) AND make_date(2003, 04, 20)) OVER (PARTITION BY c.name) AS "11-20",
	count(*) FILTER (
	WHERE
	p.date BETWEEN make_date(2003, 04, 21) AND make_date(2003, 04, 30)) OVER (PARTITION BY c.name) AS "21-30"
FROM
	pass_in_trip p
JOIN trip t
ON
	p.trip_no = t.trip_no
JOIN company c
ON
	c.id_comp = t.id_comp
WHERE
	(p.date) BETWEEN make_date(2003, 04, 1) AND make_date(2003, 04, 30)

--Упражение 85
SELECT
	maker
FROM
	product p1
WHERE
	p1.TYPE = 'PC'
	AND 
	NOT EXISTS (
	SELECT
		1
	FROM
		PRODUCT p2
	WHERE
		TYPE <> 'PC'
		AND p1.maker = p2.maker)
GROUP BY
	maker
HAVING
	count(model) > 2
UNION
SELECT
	maker
FROM
	product p1
WHERE
	p1.TYPE = 'Printer'
	AND 
	NOT EXISTS (
	SELECT
		1
	FROM
		PRODUCT p2
	WHERE
		TYPE <> 'Printer'
		AND p1.maker = p2.maker)
GROUP BY
	maker

	
--Упражнение 86
SELECT
	maker,
	string_agg(TYPE, '/' ORDER BY TYPE)
FROM
	(
	SELECT
		DISTINCT maker,
		TYPE
	FROM
		Product) p
GROUP BY
	maker
	
	
--Упражнение 87
WITH all_departs AS (
SELECT
	id_psg,
	t.trip_no,
	t.town_from,
	t.town_to,
	make_timestamp(
	EXTRACT(YEAR FROM pit.date)::int,
	EXTRACT(MONTH FROM pit.date)::int,
	EXTRACT(DAY FROM pit.date)::int,
	EXTRACT(HOUR FROM t.time_out)::int,
	EXTRACT(MINUTE FROM t.time_out)::int,
	0
) AS tm, 
	min(
	make_timestamp(
	EXTRACT(YEAR FROM pit.date)::int,
	EXTRACT(MONTH FROM pit.date)::int,
	EXTRACT(DAY FROM pit.date)::int,
	EXTRACT(HOUR FROM t.time_out)::int,
	EXTRACT(MINUTE FROM t.time_out)::int,
	0
)) OVER (PARTITION BY id_psg) AS min_tm
FROM
	pass_in_trip pit
JOIN trip t
ON
	pit.trip_no = t.trip_no
),
un_moscals AS
(
SELECT
	DISTINCT id_psg
FROM
	all_departs
WHERE
	id_psg NOT IN
(
	SELECT
		id_psg
	FROM
		all_departs
	WHERE
		tm = min_tm
		AND town_from = 'Moscow')
)

SELECT
	(SELECT
	name
FROM
	passenger p
WHERE
	p.id_psg=a1.id_psg) AS name,
	count(*)
FROM
	all_departs a1
WHERE
	ID_psg IN (
	SELECT
		id_psg
	FROM
		un_moscals)
	AND town_to = 'Moscow'
GROUP BY
	id_psg
HAVING
	count(*)>1
	
WITH all_departs AS
(
SELECT
	id_psg,
	t.town_to,
	FIRST_VALUE(town_from) over(PARTITION BY id_psg ORDER BY pit.date, t.time_out) AS born
FROM
	pass_in_trip pit
JOIN trip t
ON
	pit.trip_no = t.trip_no	
)

SELECT (SELECT
	name
FROM
	passenger p
WHERE
	p.id_psg=a1.id_psg) AS name, count(*)
FROM all_departs a1
WHERE born <> 'Moscow' AND town_to='Moscow'
GROUP BY id_psg
HAVING COUNT(*)>1

--Упражнение 88
WITH all_pass AS
(
SELECT
	DISTINCT
	p.name,
	FIRST_VALUE(t.id_comp) OVER(PARTITION BY pit.id_psg
ORDER BY
	t.id_comp),
	FIRST_VALUE(t.id_comp) OVER(PARTITION BY pit.id_psg
ORDER BY
	t.id_comp DESC) AS LAST_VALUE,
	count(*) OVER (PARTITION BY pit.id_psg) AS cnt,
	c.name AS company,
	pit.id_psg
FROM
	pass_in_trip pit
JOIN trip t
ON
	pit.trip_no = t.trip_no
JOIN passenger p
ON
	p.id_psg = pit.id_psg
JOIN company c 
ON
	c.id_comp = t.id_comp
)

SELECT
	name,
	cnt,
	company
FROM
	all_pass
WHERE
	FIRST_VALUE = LAST_VALUE
	AND cnt =(
	SELECT
		max(cnt)
	FROM
		all_pass
		WHERE
	FIRST_VALUE = LAST_VALUE)
	
	
--Упражнение 89
SELECT maker, cnt
FROM
(
SELECT maker, count(*) AS cnt, max(count(*)) over(), min(count(*)) over()	
FROM Product
GROUP BY maker
) r
WHERE cnt=max OR  cnt=min

--Упражнение 90
SELECT *
FROM PRODUCT
ORDER BY model
OFFSET 3 LIMIT (SELECT count(*) - 6 FROM Product)


--Упражнение 91
SELECT avg(sum(COALESCE(b_vol, 0))) OVER ()::Numeric(6,2)
FROM utQ q LEFT JOIN utB b
ON  q.q_id =b.b_q_id
GROUP BY q_id
LIMIT 1

--Упражение 92
--Вариант 1
WITH quant AS (
SELECT
	q.q_name AS square_name,
	B_Q_ID,
	B_V_ID,
	B_VOL,
	v.v_color,
	sum(b_vol) OVER (PARTITION BY b_q_id,
	v_color) AS color_on_square,
	sum(b_vol) OVER (PARTITION BY b_v_id) AS color_in_ballon
FROM
	utB b
JOIN utV v 
ON
	v.v_id = b.B_V_ID
JOIN
	utQ q ON
	b.b_q_id = q.q_ID
)

SELECT
	DISTINCT square_name
FROM
	quant q1
WHERE
	NOT EXISTS(
	SELECT
		color_in_ballon
	FROM
		quant q3
	WHERE
		q1.b_q_id = q3.b_q_id
		AND color_in_ballon <> 255
		AND color_on_square <> 255)

--вариант 2
SELECT q_name
FROM UTQ
WHERE q_id IN(
SELECT
	B_Q_ID
FROM
	utB u1
WHERE
	NOT EXISTS (
	SELECT
		1
	FROM
		utB u2
	WHERE
		u2.B_V_ID IN (SELECT B_V_ID FROM UTB u3 WHERE u1.B_Q_ID=u3.B_Q_ID)
	GROUP BY
		B_V_ID
	HAVING
		SUM(u2.B_VOL) <> 255)
	GROUP BY
		B_Q_ID
	HAVING
		SUM(b_vol)= 765
)


--Упражнение 93
SELECT 
--*, 
(SELECT name FROM COMPANY c WHERE c.id_comp=d.id_comp)
, sum(dur) 
FROM
(select trip_no, id_comp,
case when time_in<time_out THEN  
			EXTRACT(epoch from(time_in - time_out + INTERVAL '24 hour'))/60
ELSE EXTRACT(epoch from(time_in - time_out))/60
END AS dur
from trip) d JOIN (SELECT DISTINCT date, trip_no FROM pass_in_trip) p ON
d.trip_no=p.trip_no
GROUP BY id_comp
ORDER BY name

--Упражнение 94
WITH cnts as(
SELECT date, count(DISTINCT trip_no) cd, first_value(date) over(order BY count(DISTINCT trip_no) desc) AS min_date
FROM pass_in_trip
WHERE trip_no IN (SELECT trip_no FROM trip WHERE town_from='Rostov')
GROUP BY date)

SELECT ds, coalesce(cd, 0)
FROM (
SELECT generate_series((SELECT min_date FROM cnts LIMIT 1), (SELECT min_date FROM cnts LIMIT 1)+ INTERVAL '6 day', '1 day') AS ds) ds
LEFT JOIN cnts ON
ds.ds=cnts.date


--Упражнение 95
SELECT
	c."name" ,
	count(DISTINCT date::varchar||p.trip_no::varchar) AS flights,
	count(DISTINCT plane) AS plane_types,
	count(DISTINCT p.id_psg) AS dist_psg,
	count(p.id_psg) AS total_psg
FROM
	trip t
JOIN Pass_in_trip p
ON
	t.trip_no = p.trip_no
JOIN company c ON
	t.id_comp = c.id_comp
GROUP BY
	c."name"

--Упражнение 96
SELECT DISTINCT v_name FROM
(
SELECT
	v.v_name,
	v_color,
	count(*) FILTER (WHERE v_color='B') over(PARTITION BY b_q_id) cblue,
	count(*) OVER (PARTITION BY B_v_ID) cballoons
FROM
	utb b
JOIN utv v
ON
	b.b_v_id = v.v_id
) cdd
WHERE cblue>=1 AND cballoons>1 AND v_color = 'R'

--Упражнение 97
WITH qnts AS 
(
SELECT
	code,
	COALESCE(LEAD(numb) OVER(PARTITION BY code ORDER BY numb), 0)/ numb AS quant
FROM
	(
	SELECT
		code,
		UNNEST(ARRAY[speed, ram, COALESCE(price, -1), screen]) AS numb
	FROM
		laptop l
	) rnks
	)
SELECT
	code,
	speed,
	ram,
	price,
	screen
FROM
	laptop l2
WHERE
	code IN(
	SELECT
		DISTINCT code
	FROM
		qnts q1
	WHERE
		NOT EXISTS (
		SELECT
			1
		FROM
			qnts q2
		WHERE
			q1.code = q2.code
			AND q2.quant <> 0
			AND q2.quant < 2))

			
SELECT * FROM laptop l 
INSERT INTO laptop VALUES
(8, '1298', 1, 1, 1, 1, 1)
DELETE FROM laptop
WHERE code=8

--Упражнение 98

SELECT
	code,
	speed,
	ram
FROM
	PC
WHERE (speed::int::BIT(20)| ram::int::BIT(20))::varchar LIKE '%1111%'	

--Упражнение 99

WITH allowed_day AS
(
SELECT
	point,
	UNNEST(ARRAY[generate_series(mind, maxd + INTERVAL '3 days', INTERVAL '1 day')]) AS outc_day
FROM
	(
	SELECT
		point,
		min(date) AS mind,
		max(date) AS maxd
	FROM
		outcome_o
	GROUP BY
		point
) minmax
EXCEPT
SELECT point, date
FROM outcome_o
) 

SELECT
	point,
	date AS date_of_inc,
	CASE
		WHEN OUT IS NULL THEN date
		ELSE 
		(
		SELECT
			min(outc_day)
		FROM
			allowed_day ad
		WHERE
			outc_day > io.date
			AND io.point = ad.point
			AND EXTRACT (dow
		FROM
			outc_day) <> 0)
	END AS incas_day
FROM
	income_o io
LEFT JOIN outcome_o oo
		USING (date,
	point)

--Упражение 100
SELECT
	COALESCE (o.date,
	i.date) AS d,
	COALESCE(o.rn, i.rn ) AS pos,
	i.point,
	inc,
	o.point,
	OUT
FROM
	(
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY date
	ORDER BY
		code) AS rn
	FROM
		income) i
FULL JOIN
(
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY date
	ORDER BY
		code) AS rn
	FROM
		outcome) o
ON
	i.date = o.date
	AND
i.rn = o.rn

--Упражнение 101
WITH grps AS(
SELECT
	*
FROM
	PRINTER
LEFT JOIN (
	SELECT
		code,
		CASE
			WHEN color = 'y' THEN 0
			ELSE 1
		END AS gr_num
	FROM
		printer
	WHERE
		CODE =(
		SELECT
			min(code)
		FROM
			printer)
UNION
	SELECT
		code,
		ROW_NUMBER() OVER (
	ORDER BY
		code) AS gr_num
	FROM
		printer
	WHERE
		color = 'n') pn
		USING (CODE)),
		

gr_nums as(	SELECT
		code,
		model,
		color,
		TYPE,
		price,
		COALESCE(gr_num, (SELECT max(gr_num) FROM grps g2 WHERE g2.code < g1.code)) AS p_group
	FROM
		grps g1
) 
		
SELECT
	code,
	model,
	color,
	TYPE,
	price,
	max(model) over(PARTITION BY p_group) AS max_model,
	(SELECT count(DISTINCT type) FROM gr_nums gr2 WHERE gr2.p_group=gr1.p_group) AS cnt_unique,
	avg(price) OVER (PARTITION BY p_group) AS avg_price
FROM gr_nums gr1


--Упражнение 102
SELECT name 
FROM passenger p 
WHERE id_psg IN (
SELECT id_psg FROM
(
SELECT 
	CASE 
		WHEN town_from>town_to THEN town_from||town_to
		ELSE town_to||town_from
		END AS route,
		id_psg
FROM pass_in_trip pit JOIN trip t 
USING(trip_no)
) rts
GROUP BY id_psg
HAVING count(DISTINCT route) = 1)

--Упражнение 103
WITH races AS (
SELECT *, ROW_NUMBER() OVER() AS rn
FROM
	(
(
	SELECT
		trip_no
	FROM
		trip t
	ORDER BY
		trip_no
	LIMIT 3)
UNION ALL
(
SELECT
	trip_no
FROM
	trip t
ORDER BY
	trip_no DESC
LIMIT 3)) ty
)
SELECT
	(SELECT max(trip_no) FROM races r2 WHERE rn=1),
	(SELECT max(trip_no) FROM races r2 WHERE rn=2),
	(SELECT max(trip_no) FROM races r2 WHERE rn=3),
	(SELECT max(trip_no) FROM races r2 WHERE rn=6),
	(SELECT max(trip_no) FROM races r2 WHERE rn=5),
	(SELECT max(trip_no) FROM races r2 WHERE rn=4)	
FROM races r1
LIMIT 1

--Упражнение 104
SELECT CLASS, 'bc-'||ng
FROM (
SELECT CLASS,  UNNEST(array[generate_series(1, numguns, 1)] ) AS ng
FROM classes
WHERE TYPE='bc') nc


--Упражнение 105
WITH ab AS (
SELECT
	maker, model,
	DENSE_RANK() OVER(ORDER BY maker, model) AS a,
	dense_rank() OVER(ORDER BY maker) AS b
FROM
	product p
)

SELECT *,
	(SELECT min(a) FROM ab ab2 WHERE ab1.maker=ab2.maker) AS c,
	(SELECT max(a) FROM ab ab2 WHERE ab1.maker=ab2.maker) AS d
FROM ab ab1

--Упражнение 106
WITH RECURSIVE numb AS(
WITH ord AS(
SELECT
	ROW_NUMBER() OVER(
ORDER BY
	b_datetime,
	b_q_id,
	b_v_id
) AS rn,
	*
FROM
	utb
)
SELECT
	rn,
	b_datetime,
	b_q_id,
	b_v_id,
	b_vol,
	b_vol::float AS v
FROM
	ord
WHERE
	rn = 1
UNION
SELECT
	o.rn,
	o.b_datetime,
	o.b_q_id,
	o.b_v_id,
	o.b_vol,
	CASE 
		WHEN o.rn%2 = 0 THEN (n.v / o.b_vol::float)
		ELSE (n.v * o.b_vol::float)
	END AS res
FROM
	numb n ,
	ord o
WHERE
	o.rn = n.rn + 1
	AND o.rn <= 
	(
	SELECT
		max(rn)
	FROM
		ord)

)

SELECT
	b_datetime,
	b_q_id,
	b_v_id,
	b_vol,
	v::numeric(15,8)
FROM
	numb
ORDER BY
	rn
	
	
--Упражнение 107
SELECT
	c.name,
	trip_no ,
	date
FROM
	Trip t
JOIN 
pass_in_trip pit
		USING (trip_no)
JOIN company c
		USING (ID_comp)
WHERE
	pit.date BETWEEN make_date(2003, 04, 1) AND make_date(2003, 04, 30)
	AND t.town_from = 'Rostov'
ORDER BY
	date, time_out, id_psg
	OFFSET 5
LIMIT 1


--Упражнение 108
SELECT
	DISTINCT
	u1.b_vol,
	u2.b_vol,
	u3.b_vol
FROM
	utb u1,
	utb u2,
	utb u3
WHERE
	u1.b_vol < u2.b_vol
	AND u2.b_vol < u3.b_vol
	AND (u1.b_vol ^ 2) + (u2.b_vol ^ 2) >= u3.b_vol ^ 2
	AND u1.b_vol + u2.b_vol > u3.b_vol
	
	
--Упражнение 109
SELECT 
q_name, 
count(*) FILTER (WHERE rgb = 765) OVER () AS w,
count(*) FILTER (WHERE rgb = 0 OR RGB IS NULL) OVER () AS b
FROM
(
SELECT
Distinct
	b_q_id ,
	COALESCE(sum(b_vol) FILTER (WHERE v_color='G') OVER (PARTITION BY b_q_id), 0) +
	COALESCE(sum(b_vol) FILTER (WHERE v_color='R') OVER (PARTITION BY b_q_id), 0) +
	COALESCE(sum(b_vol) FILTER (WHERE v_color='B') OVER (PARTITION BY b_q_id), 0) AS RGB
FROM utb JOIN utv
ON utb.b_v_id=utv.v_id
) b RIGHT JOIN utQ 
ON b.b_q_id=utq.q_id
WHERE RGB = 0 OR RGB = 765 OR RGB IS NULL


--Упражнение 110
WITH ids AS (
SELECT id_psg
	
FROM
	pass_in_trip pit
JOIN TRIP t
		USING (trip_no)
WHERE
	EXTRACT (dow
FROM
	make_timestamp(
		EXTRACT(YEAR FROM date)::int,
		EXTRACT(MONTH FROM date)::int,
		EXTRACT(DAY FROM date)::int,
		EXTRACT(HOUR FROM time_out)::int,
		EXTRACT(MINUTE FROM time_out)::int,
		EXTRACT(SECOND FROM time_out)::float
)
)= 6
	AND (
	CASE 
		WHEN time_out < time_in THEN
			EXTRACT (dow
	FROM
				make_timestamp(
				EXTRACT(YEAR FROM date)::int,
				EXTRACT(MONTH FROM date)::int,
				EXTRACT(DAY FROM date)::int,
				EXTRACT(HOUR FROM time_in)::int,
				EXTRACT(MINUTE FROM time_in)::int,
				EXTRACT(SECOND FROM time_in)::float
)
		) = 0
		ELSE 
EXTRACT (dow
	FROM
		make_timestamp(
		EXTRACT(YEAR FROM date)::int,
		EXTRACT(MONTH FROM date)::int,
		EXTRACT(DAY FROM date)::int,
		EXTRACT(HOUR FROM time_in)::int,
		EXTRACT(MINUTE FROM time_in)::int,
		EXTRACT(SECOND FROM time_in)::float
) + INTERVAL '1 day'
)= 0
	END)
)	
SELECT name FROM passenger p WHERE id_psg IN (SELECT id_psg FROM ids)


--Упражнение 111
SELECT 
q_name, 
r AS qty
FROM
(
SELECT
Distinct
	b_q_id ,
	COALESCE(sum(b_vol) FILTER (WHERE v_color='G') OVER (PARTITION BY b_q_id), 0) AS G,
	COALESCE(sum(b_vol) FILTER (WHERE v_color='R') OVER (PARTITION BY b_q_id), 0) AS R,
	COALESCE(sum(b_vol) FILTER (WHERE v_color='B') OVER (PARTITION BY b_q_id), 0) AS B
FROM utb JOIN utv
ON utb.b_v_id=utv.v_id
) b RIGHT JOIN utQ 
ON b.b_q_id=utq.q_id
WHERE G=R AND R=B AND NOT G IS NULL AND (R+G+B) <> 765


--Упражнение 112
SELECT CASE 
	WHEN (SELECT count(DISTINCT(v_color)) FROM utv)=3 THEN
	floor((min(sum(remains)) OVER () / 255))
	ELSE
	0
	END
FROM
(
SELECT v_color, v_name, 255-sum(CASE WHEN b_vol IS NULL THEN 0 ELSE b_vol end) AS remains
FROM utv LEFT JOIN utb
ON utv.v_id=utb.b_v_id
GROUP BY v_color, v_name
) rm
GROUP BY v_color
LIMIT 1.


--Упражнение 113
WITH qty AS (
SELECT DISTINCT q_name, 
255-COALESCE((sum(b_vol) FILTER (WHERE v_color='R') OVER(PARTITION BY b_q_id)), 0)  AS R,
255-COALESCE((sum(b_vol) FILTER (WHERE v_color='G') OVER(PARTITION BY b_q_id)), 0)  AS G,
255-COALESCE((sum(b_vol) FILTER (WHERE v_color='B') OVER(PARTITION BY b_q_id)), 0)  AS B
FROM utv JOIN utb
ON utv.v_id=utb.b_v_id
RIGHT JOIN utq
ON utq.q_id=utb.b_q_id
)

SELECT sum(r) AS red, sum(g) AS green, sum(b) AS blue
FROM qty


--Упражнение 114
SELECT
	(SELECT name FROM passenger p WHERE p.id_psg=ps.id_psg),
	qty
FROM
(
SELECT DISTINCT id_psg,count(*) AS qty, max(count(*)) OVER () AS max_qty
FROM pass_in_trip
GROUP BY id_psg, place
) ps
WHERE qty=max_qty

--Упражнение 115
SELECT DISTINCT up.b_vol AS up, down.b_vol AS down, side.b_vol AS side, (sqrt(up.b_vol::float*down.b_vol::float)/2)::numeric(10,2)
FROM UTB up, utb down, utb side
WHERE up.b_vol < down.b_vol AND side.b_vol::float = (up.b_vol+down.b_vol)::float/2

--Упражнение 116
WITH saf AS (
SELECT *,
CASE 
	WHEN lag(longing) OVER (ORDER BY b_datetime)=0 AND longing = 1 THEN 'start'
	ELSE Null
END AS "START",
CASE 
	WHEN lag(longing) OVER (ORDER BY b_datetime)=1 AND longing = 0 THEN 'finish'
	ELSE Null
END AS "Finish"
FROM
(
SELECT
	b_datetime,
	CASE 
		WHEN 			
			LEAD(b_datetime) OVER (
			ORDER BY b_datetime) - b_datetime = INTERVAL '1 sec' THEN 1
			ELSE 0
	END AS longing

FROM
	utb
	GROUP BY b_datetime
) intr
)
SELECT s.b_datetime AS START_TIME, f.b_datetime AS finish_time
FROM
(SELECT *, row_number() OVER (ORDER BY b_datetime) AS rn
FROM saf
WHERE "START"='start') s
JOIN
(SELECT *, row_number() OVER (ORDER BY b_datetime) AS rn
FROM saf
WHERE "Finish"='finish') f
USING (rn)

--Упражнение 117
WITH cte AS (
SELECT
	DISTINCT
	country,
	max(numguns * 5000) OVER (PARTITION BY country) AS numguns,
	max(bore * 3000) OVER (PARTITION BY country) AS bore,
	max(displacement) OVER (PARTITION BY country) AS displacement,
	ARRAY[max(numguns * 5000) OVER (PARTITION BY country),
	max(bore * 3000) OVER (PARTITION BY country),
	max(displacement) OVER (PARTITION BY country)] AS arr
FROM
	classes
	)
	,
	
maxes AS (
SELECT
	country,
	(
	SELECT
		max(numb)
	FROM
		(
		SELECT
			UNNEST(arr) AS numb
		FROM
			cte c2
		WHERE
			c1.country = c2.country) mx)
FROM
	cte c1
),	
	
	
allc AS (
SELECT
	country,
	'numguns' AS name,
	(
	SELECT
		numguns
	FROM
		cte c2
	WHERE
		c1.country = c2.country) AS number
FROM
	cte c1
UNION ALL
SELECT
	country,
	'bore',
	(
	SELECT
		bore
	FROM
		cte c2
	WHERE
		c1.country = c2.country)
FROM
	cte c1
UNION ALL
SELECT
	country,
	'displacement',
	(
	SELECT
		displacement
	FROM
		cte c2
	WHERE
		c1.country = c2.country)
FROM
	cte c1
)

SELECT
	country,
	max,
	name
FROM
	allc
JOIN maxes
		USING (country)
WHERE
	number = max
	
	


WITH cte AS (
SELECT 
		country,
		max(COALESCE(numguns, 0)* 5000) ng,
		max(COALESCE(bore, 0)* 3000) b,
		max(COALESCE(displacement, 0)) d
FROM
	classes
GROUP BY
	1
)	
SELECT
	country,
	max_val,
	name
FROM
	cte c1
JOIN 
(
	SELECT
		ng AS max_val,
		'numguns' AS name,
		country
	FROM
		cte c2
	WHERE
		ng >= b
		AND ng >= d
UNION ALL
	SELECT
		b AS max_val,
		'bore' AS name,
		country
	FROM
		cte c2
	WHERE
		b >= ng
		AND b >= d
UNION ALL
	SELECT
		d AS max_val,
		'displacement' AS name,
		country
	FROM
		cte c2
	WHERE
		d >= ng
		AND d >= b
) cc2
		USING (country)
		
		
--Упражнение 118
WITH yr as(
SELECT name, date, yr AS myr, EXTRACT(dow FROM make_date(yr, 4,1)) AS dow
from(
SELECT
	name,
	date,
	UNNEST(ARRAY[generate_series(EXTRACT(YEAR FROM date)::int, EXTRACT(YEAR FROM date)::int + 8, 1)]) AS yr
FROM
	battles
	) yrs
WHERE (yr%4=0 AND yr%100<>0) OR (yr%400=0)
),

dz AS 
(SELECT 1 AS dow, 2 AS th
UNION
SELECT 2 AS dow, 8 AS th
UNION
SELECT 3 AS dow, 7 AS th
UNION
SELECT 4 AS dow, 6 AS th
UNION
SELECT 5 AS dow, 5 AS th
UNION
SELECT 6 AS dow, 4 AS th
UNION
SELECT 0 AS dow, 3 AS th
)


SELECT name, to_char(date, 'YYYY-MM-DD') AS b_date, min(make_date(myr, 04, th)) AS election_dt
FROM yr JOIN dz
USING (DOW)
WHERE  make_date(myr, 04, th) > date
GROUP BY name, date


--Упражнение 119
SELECT
	to_char(b_datetime, 'YYYY') AS PERIOD,
	sum(b_vol) AS vol
FROM
	utb u
GROUP BY
	to_char(b_datetime, 'YYYY')
HAVING
	count(DISTINCT b_datetime) > 10
UNION ALL
SELECT
	to_char(b_datetime, 'YYYY-MM'),
	sum(b_vol) AS vol
FROM
	utb u
GROUP BY
	to_char(b_datetime, 'YYYY-MM')
HAVING
	count(DISTINCT b_datetime) > 10
UNION ALL
SELECT
	to_char(b_datetime, 'YYYY-MM-DD'),
	sum(b_vol) AS vol
FROM
	utb u
GROUP BY
	to_char(b_datetime, 'YYYY-MM-DD')
HAVING
	count(DISTINCT b_datetime) > 10
	
	
--Упражение 120
	
WITH dur AS(
SELECT
	trip_no,
	id_comp,
	CASE
		WHEN time_in<time_out THEN  
			(EXTRACT(epoch
	FROM
		(time_in - time_out + INTERVAL '24 hour'))/ 60)::float
		ELSE (EXTRACT(epoch
	FROM
		(time_in - time_out))/ 60)::float
	END AS dur
FROM
	trip
)
SELECT
	CASE 
		WHEN c.name IS NULL THEN 'TOTAL'
		ELSE c.name
	END AS nm
	,
	avg(dur)::NUMERIC(10,
	2) AS a_a,
	((EXP(SUM(ln(dur))))^(1/count(dur)::float))::NUMERIC(10,
	2) AS a_g,
	sqrt(sum(dur^2)/count(dur))::NUMERIC(10,
	2) AS a_s,
	(count(dur)/sum(1/dur))::numeric(10,2) AS a_h
FROM
	dur
JOIN
(
	SELECT
		trip_no
	FROM
		pass_in_trip
	WHERE
		id_psg IS NOT NULL
	GROUP BY
		trip_no,
		date) r
		USING (trip_no)
		JOIN company c
		USING (id_comp)
GROUP BY
	ROLLUP(c.name)
	
--Упражнение 121
SELECT s.name AS ship,
		s.launched AS launched,
		NULL AS battle
FROM ships s
WHERE  make_date(s.launched,
		01,
		01) > (SELECT max(date) FROM battles b )
UNION
SELECT 
	ship,
	launched,
	battle
FROM
	(
	SELECT
		s.name AS ship,
		s.launched AS launched,
		b.name AS battle,
		b.date AS date,
		min(b.date) OVER (PARTITION BY s.name
	ORDER BY
		b.date ASC) AS mindate
	FROM
		ships s
	LEFT JOIN battles b
ON
		make_date(s.launched,
		01,
		01) <= b.date
) al
WHERE
	date = mindate
UNION 
SELECT
	name,
	launched,
	(
	SELECT
		name
	FROM
		battles b
	WHERE
		date =(
		SELECT
			max(date)
		FROM
			battles))
FROM
	SHIPS
WHERE
	launched IS NULL
	
--Упражнение 122


	