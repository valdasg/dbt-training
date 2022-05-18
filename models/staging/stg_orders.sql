select 
-- from raw orders 
{{ dbt_utils.surrogate_key(['o.ORDEREID', 'c.customerid', 'p.productid']) }} as sk_orders,
o.ordereid,
o.orderdate,
o.shipdate,
o.shipmode,
o.ordersellingprice - o.ordercostprice as orderprofit,
o.ordercostprice,
o.ordersellingprice,
-- from raw customer
c.customerid,
c.customername,
c.segment,
c.country,
-- from raw product
p.productid,
p.category,
p.productname,
p.subcategory,
{{ markup('ordersellingprice', 'ordercostprice') }} as markup,
-- from seed delivery team
d.delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
left join {{ ref('delivery_team') }} as d
on 
o.shipmode = d.shipmode

--{{limit_data_in_dev('orderdate')}}
