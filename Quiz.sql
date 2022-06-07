create database Academy

drop table Students
drop table Groups

use Academy

create table Groups (
Id int constraint PK_GroupsId primary key identity,
Name nvarchar(40)
)

create table Students (
Id int primary key identity,
Name nvarchar(40),
Surname nvarchar(40),
GroupId int constraint FK_GoupsId foreign key references Groups(Id)
)

alter table Students
add Grade money

insert into Groups(Name)
Values
('P129'),
('P124'),
('P221')

insert into Students(Name, Surname, GroupId, Grade)
Values
('Ali','Valiev', 1, 80),
('Samir','Piriev', 3, 90),
('Ramiz','Miriev', 3, 95),
('Tahir','Aliev', 3, 100)


select s.Id, s.Name, s.Surname from Groups g
join Students s on s.GroupId = g.Id

select g.Name 'Group Name', count(*) 'Number of Students' from Groups g
join Students s on s.GroupId = g.Id
group by g.Name

create view usv_SName_GName_SSurname_SGrade
as
select s.Name, s.Surname, g.Name 'Group Name', s.Grade from Groups g
join Students s on s.GroupId = g.Id

create procedure usp_TheHighestScore @score int
as
begin
	select * from usv_SName_GName_SSurname_SGrade h
	where h.Grade > @score
end
exec usp_TheHighestScore 90

create function usf_GetAmountofStudents
(@groupName nvarchar(40))
returns int
as
begin
	declare @amountofstudents int

	select @amountofstudents = COUNT(*) from Students s
	join Groups g on g.Id = s.GroupId
	where g.Name = @groupName

	return @amountofstudents
end

select dbo.usf_GetAmountofStudents('p129') 'Amount of Students'