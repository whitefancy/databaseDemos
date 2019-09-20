update library.book
set 数量=数量+10;

update library.book
set 数量=-10,
    价格=价格*0.8
where 作者1='三毛'
and 价格>17;