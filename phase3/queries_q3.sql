\echo #1
\echo proportion of having default on credit in different marital groups, column CreditProportion is proportion of have default on credit, HaveCredit is total number of default on credit, totalCredit is total number of observation
select marital, Cast(sum(case when credit = 'yes' then 1 else 0 end) as float)/Cast(count(credit) as float) as CreditProportion, sum(case when credit = 'yes' then 1 else 0 end) as HaveCredit, count(credit) as totalCredit
from maritalcredit
where credit is not null
And marital is not null
group by marital
order by CreditProportion;

\echo #2
\echo proportion of having default on credit in different education groups, column CreditProportion is proportion of have default on credit, HaveCredit is total number of default on credit, totalCredit is total number of observation
select education, CAST(sum(case when credit = 'yes' then 1 else 0 end) as float)/CAST(count(credit) as float) as CreditProportion, sum(case when credit = 'yes' then 1 else 0 end) as HaveCredit, count(credit) as totalCredit
from maritalcredit
where credit is not null
And education is not null
group by education
order by CreditProportion;


\echo #3
\echo proportion of having default on credit in different job groups, column CreditProportion is proportion of have default on credit, HaveCredit is total number of default on credit, totalCredit is total number of observation
Select job, CAST(sum(case when credit = 'yes' then 1 else 0 end) as float)/CAST(count(credit) as float) as CreditProportion, sum(case when credit = 'yes' then 1 else 0 end) as HaveCredit, count(credit) as totalCredit
from maritalcredit
where credit is not null
And job is not null
group by job
order by CreditProportion;
