with orders as (
    select * from {{ ref('raw_orders') }}
    )

select
    ordereid,
    sum(ordersellingprice) as total_sp
from orders
group by ordereid
having total_sp < 0
