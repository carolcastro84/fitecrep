select 'Dog ' || name
  from dogs
union
select 'Cat ' || name
  from cats;