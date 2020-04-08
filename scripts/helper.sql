with cte as (
  select row_number() over (partition by ps.id_psg, pit.place order by pit.place) as rownumber,pit.place,
         datediff (minute, time_out,
dateadd(day, iif(time_in < time_out, 1, 0), time_in)) as timeflight,
         ps.id_psg, ps.name
  from pass_in_trip pit
    left join trip tr
      on pit.trip_no = tr.trip_no
    left join passenger ps
      on ps.id_psg = pit.id_psg)
select max(cte.name), sum(timeflight)
  from cte
group by cte.id_psg
having max(rownumber) = 1