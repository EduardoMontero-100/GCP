--arrays:
SELECT ['apple', 'orange', 'pear'] as fruit,
'Eduardo' as name

--flattend array:
select
name, 
fruit
from 
unnest(['apple', 'orange', 'pear'])  as fruit
cross join (select 'Eduardo' as name)


-- array_creation:

with fruits as(
select 'apple' as fruit
union all
select 'bannanas' as fruit
union all
select 'pear' as fruit
)


with groceries as 
(
select ['apple', 'banana', 'pear'] as list
union all
select ['carrot', 'apple'] as list
union all
select ['water', 'wine'] as list
)

select
  array(
    select items from unnest(list) as items
    where 'apple' in unnest(list)
  ) as contains_apple
from groceries ;

--struct: container of ordered fields could be multiple data types
select
struct(32 as age, 'Jacob' as name) as customer -- is like a python dictionary

-- structs and arrays:
select
struct(32 as age, 'Jacob' as name, ['apple', 'pear', 'peach'] as items) as customer

select
[
struct(35 as age, 'Jacob' as name, ['apple', 'pear', 'peach'] as items),
struct(33 as age, 'Miranda' as name, ['water', 'pineapple', 'ice cream'] as items)
] as customers

-- struct examples:
with orders as(
select
[
struct(35 as age, 'Jacob' as name, ['apple', 'pear', 'peach'] as items),
struct(33 as age, 'Miranda' as name, ['water', 'pineapple', 'ice cream'] as items)
] as customers
)

select
    customers
from orders as o
cross join unnest(o.customers) as customers
where 'ice cream' in unnest(customers.items)

-- nested records in Big Query are arrays of structs
-- git a