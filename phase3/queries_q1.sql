\echo query #1
\echo this query produce proportion of successful campaign in different range of age, column SuccessProportion is proportion of successful previous campaign, column totalSuccess is total number of successful previos campaign, totalOutcome is total number of observation

select a.range as ageRange, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (
select case
when age between 17 and 31 then '17-31'
when age between 32 and 46 then '32-46'
when age between 47 and 61 then '47-61'
when age between 62 and 76 then '62-76'
when age >= 77 then 'equal or over 77'
end as range, id from person
) a join outcome on a.id = outcome.id
group by ageRange
order by ageRange;

\echo query #2
\echo this query produce proportion of successful campaign with different job, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1
CREATE VIEW HaveJob AS(
SELECT id
FROM Person
WHERE job = 'blue-collar' or job = 'entrepreneur' or job = 'services' or job = 'self-employed' or job = 'management' or job = 'technician' or job = 'admin.');

select a.job as haveJobOrNot, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (
select case
when id in (select id from HaveJob) then 'HaveJob'
when id not in (select id from HaveJob) then 'HaveNoJob'
end as job, id from person
) a join outcome on a.id = outcome.id
group by haveJobOrNot;


\echo query #3
\echo this query produce proportion of successful campaign in different marital group, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1
select marital, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from person join outcome on person.id = outcome.id
Where marital is not null
group by marital
order by marital;

\echo query #4
\echo this query produce proportion of successful campaign in different education, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1
CREATE VIEW HighEducation AS(
SELECT id
FROM Person
WHERE education = 'professional.course' or education = 'university.degree');

select a.education as educationLevel, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (
select case
when id in (select id from HighEducation) then 'Higher than High School'
when id not in (select id from HaveJob) then 'Lower than or eq to High School'
end as education, id from person
) a join outcome on a.id = outcome.id
Where a.education is not Null
group by a.education;

\echo query #5
\echo this query produce proportion of successful campaign in different default on credit, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select credit, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from person join outcome on person.id = outcome.id
where credit is not null
group by credit;

\echo query #6
\echo this query produce proportion of successful campaign in different house loan, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select housing, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from person join outcome on person.id = outcome.id
where housing is not null
group by housing
order by housing;

\echo query #7
\echo this query produce proportion of successful campaign in different personal loan, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select loan, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from person join outcome on person.id = outcome.id
where loan is not null
group by loan
order by SuccessProportion;

\echo query #8
\echo this query produce proportion of successful campaign in different previous number of contact, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select pcontact, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (select case
When pcontact = 1 then 'one contact'
When pcontact > 1 then 'multiple contact'
End as pcontact, id from person
) d join outcome on d.id = outcome.id
group by pcontact
order by successproportion;

\echo query #9
\echo this query produce proportion of successful campaign in different employment variation rate, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1
select empVarRate, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from index join outcome on index.id = outcome.id
where empVarRate is not null
group by empVarRate
order by empVarRate;

\echo query #10
\echo this query produce proportion of successful campaign in different consumer price index, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select c.range as cpiRange, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (select case
when cpi >= 92.0 and cpi < 93.0 then '92.0-93.0'
when cpi >= 93.0 and cpi < 94.0 then '93.0-94.0'
when cpi >= 94.0 and cpi < 95.0 then '94.0-95.0'
end as range, id from index
) c join outcome on c.id = outcome.id
group by cpiRange
order by cpiRange;

\echo query #11
\echo this query produce proportion of successful campaign in different comsumer confidence index, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select c.range as cciRange, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (select case
when cci >= -51 and cci < -42 then '-51 to -42'
when cci >= -42 and cci < -33 then '-42 to -33'
when cci >= -33 and cci < -24 then '-33 to -24'
end as range, id from index
) c join outcome on c.id = outcome.id
group by cciRange
order by cciRange;

\echo query #12
\echo this query produce proportion of successful campaign in different Euribor 3 month rate, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select e.range as euriborRange, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from (select case
when Euribor3m >= 0.0 and Euribor3m < 1.0 then '0.0-1.0'
when Euribor3m >= 1.0 and Euribor3m < 2.0 then '1.0-2.0'
when Euribor3m >= 2.0 and Euribor3m < 3.0 then '2.0-3.0'
when Euribor3m >= 3.0 and Euribor3m < 4.0 then '3.0-4.0'
when Euribor3m >= 4.0 and Euribor3m < 5.0 then '4.0-5.0'
end as range, id from index
) e join outcome on e.id = outcome.id
group by euriborRange
order by euriborRange;

\echo query #13
\echo this query produce proportion of successful campaign with Existence of subscription of a term deposit, column SuccessProportion, totalSuccess and totalOutcome have same meaning as query #1

select subscribed, sum(case when poutcome = 'success' then 1 else 0 end)*100/count(poutcome) as SuccessProportion, sum(case when poutcome = 'success' then 1 else 0 end) as totalSuccess, count(poutcome) as totalOutcome
from index join outcome on index.id = outcome.id
where subscribed is not null
group by subscribed
order by subscribed;
