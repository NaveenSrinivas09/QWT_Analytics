select orderid,
avg(margin) as avg_margin
from {{ ref("fact_orders")}}
group by 1
having not (avg_margin > 0)