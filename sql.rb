res = Models::Life.find_by_sql(["select count(lives.id), status, cancom,
      concat_ws(' ', students.first_name, students.last_name) student,
      concat_ws(' ', assessors.first_name, assessors.last_name) _assessor,
      date_format(cancom, '%M') month from workskills.lives
      inner join students on lives.student_id = students.id
      inner join assessors on lives.assessor_id = assessors.id
      where (cancom between ? and ?
      and status = 'CAN' or status = 'COM' or status = 'DNH') group by month, status
      order by cancom;" , start, fin])


The tables to select -

select count(lives.id), status, cancom,
      concat_ws(' ', students.first_name, students.last_name) student,
      concat_ws(' ', assessors.first_name, assessors.last_name) _assessor,
      date_format(cancom, '%M') month from workskills.lives

Joining by foriegn key -

inner join students on lives.student_id = students.id
inner join assessors on lives.assessor_id = assessors.id

Query -

 where (cancom between ? and ?
      and status = 'CAN' or status = 'COM' or status = 'DNH') group by month, status

 Ordering -

 order by cancom;" , start, fin])

-------------------------------------------

 "between ? and ? " corresponds to the variables
 "start, fin"


hidden result attributes can be accessed through result[i].attributes.keys
or results[i].to_json