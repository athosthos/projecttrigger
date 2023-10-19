-- part 1

use company;

create view vieww1 as select count(e.dnumber) as employee_counting, dname as department from employee e, department d where e.dnumber = d.dnumber group by d.dnumber;

create view view2 as select dname, fname from employee e, department d where Manager_ssn = ssn;

create view view3 as select count(w.pnumber) as project_counting, pname from works_on w, project p where p.pnumber = w.pnumber group by w.pnumber order by project_counting desc limit 1;

create view view4 as select pname, dname, fname from employee e, department d, project p where p.Dnumber = d.dnumber and Manager_ssn = ssn;

create view view5 as select distinct fname, dname from  dependent d, employee e left join department de on Manager_ssn = e.ssn where d.essn = e.ssn;

create user 'test'@localhost identified by '123';
grant all privileges on company.view1 to 'test'@localhost;

-- part2

use ecommerce;

delimiter $$

create trigger management_supplier before delete
on productsupplier for each row
begin
    delete p from product p where p.idProduct = old.idSupplier;
end $$

delimiter ;

delete from productsupplier where idSupplier = 2;

delimiter $$

create trigger management_product before update
on product for each row
begin
    insert into messages (user, message) values (current_user, 'dado modificado');
end $$

delimiter ;

