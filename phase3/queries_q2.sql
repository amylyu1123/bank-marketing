\echo #1
\echo personal information of people that have highest proportion of successful poutcome, column SuccessProportion is proportion of successful previous campaign, column totalSuccess is total number of successful previos campaign, totalOutcome is total number of observation

SELECT a.range as ageRange, b.education as educationLevel, c.job as havejobornot, d.pcontact, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) AS SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) AS totalOutcome

FROM (
select case
when age between 17 and 31 then '17-31'
when age between 32 and 46 then '32-46'
when age between 47 and 61 then '47-61'
when age between 62 and 76 then '62-76'
when age >= 77 then 'equal or over 77'
end as range, id from person
) a join outcome on a.id = outcome.id
Join 
(select case
when id in (select id from HaveJob) then 'HaveJob'
when id not in (select id from HaveJob) then 'HaveNoJob'
end as job, id from person
)  c on c.id = outcome.id
Join
(
select case
when id in (select id from HighEducation) then 'Higher than High School'
when id not in (select id from HaveJob) then 'Lower than or eq to High School'
end as education, id from person
) b on b.id = outcome.id
JOIN 
(
Select case
When pcontact = 1 then 'one contact'
When pcontact > 1 then 'multiple contact'
End as pcontact, id from person
) d on d.id = outcome.id
Where b.education is not Null
And c.job is not Null
group by a.range, c.job, b.education
, pcontact
order by successproportion;

\echo #2
\echo social and economic attributes of people that have highest proportion of successful poutcome, column SuccessProportion is proportion of successful previous campaign, column totalSuccess is total number of successful previos campaign, totalOutcome is total number of observation


select c.cpiRange as cpiRange, c.cciRange as cciRange, c.subscribed, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess,count(poutcome) AS totalOutcome

from (select case
when cpi >= 92.0 and cpi < 93.0 then '92.0-93.0'
when cpi >= 93.0 and cpi < 94.0 then '93.0-94.0'
when cpi >= 94.0 and cpi < 95.0 then '94.0-95.0'
end as cpiRange, 
case
when cci >= -51 and cci < -42 then '-51 to -42'
when cci >= -42 and cci < -33 then '-42 to -33'
when cci >= -33 and cci < -24 then '-33 to -24'
end as cciRange, 
id, subscribed from index
) c join outcome on c.id = outcome.id
where subscribed is not null
group by c.cpiRange, c.cciRange, c.subscribed
order by SuccessProportion;

