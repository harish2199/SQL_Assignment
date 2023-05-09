create database KeepNote

use KeepNote
--Table 1
create table user_records(
	user_id int primary key,
	user_name varchar(20),
	user_added_date date,
	user_password varchar(20),
	user_mobile varchar(10)
)

--drop table user_records

insert into user_records 
values(112233,'Maya','2019-01-02','Maya1214','8012345679'),
	  (112244,'Nair','2019-01-11','Welcome','9023778467')

--delete user_records 
select * from user_records

--Table-2
create table note_records(
	note_id int primary key,
	note_title varchar(20),
	note_content varchar(80),
	note_status varchar(15),
	note_creation_date date,
	user_id int,
    constraint fk_note_records foreign key(user_id) references user_records(user_id)
)

--drop table note_records

insert into note_records 
values(1,'Today Tasks','1.Check emails and reply to them 2.Start the pro...','In Progress','2019-01-21',112233),
      (2,'Training to plan','1.Application related 2.Technical related','Yet To Start','2019-01-31',112244),
	  (3,'Things to have today','1.Fruits 2.More water','In Progress','2019-01-25',112244)

select * from note_records

--Table-3
create table category_records(
	category_id int primary key,
	category_Name varchar(20),
	category_descr varchar(50),
	category_creation_date date,
	category_creator int
	constraint fk_category_records foreign key(category_creator) references user_records(user_id)
)

insert into category_records
values(1,'Official','Office related notes','2019-01-21',112233),
      (2,'Diet','Health related notes','2019-01-24',112244)

select * from category_records

--Table-4
create table reminder_records(
	reminder_id int primary key,
	reminder_Name varchar(20),
	reminder_descr varchar(50),
	reminder_type varchar(30),
	reminder_creation_date date,
	reminder_creator int
	constraint fk_remainder_records foreign key(reminder_creator) references user_records(user_id)
)

insert into reminder_records
values(1,'KT reminder','Session on technical queries','Office reminders','2019-02-12',112233),
      (2,'Personal reminder','Pick Children','Personal reminders','2019-02-14',112244)

select * from reminder_records

--Table-5

create table note_category(
	notecategory_id int primary key,
	note_id int,
	category_id int,
	constraint fk_note_category_1 foreign key(note_id) references note_records(note_id),
	constraint fk_note_category_2 foreign key(category_id) references category_records(category_id),
)

--drop table note_category

insert into note_category
values(1,1,1),
      (2,2,1),
	  (3,3,2)

select * from note_category

--Table-6
create table note_Reminder(
	notereminder_id int primary key,
	note_id int,
	reminder_id int,
	constraint fk_note_reminder_1 foreign key(note_id) references note_records(note_id),
	constraint fk_note_reminder_2 foreign key(reminder_id) references reminder_records(reminder_id),
)

insert into note_Reminder
values(1,3,2),
      (2,2,1)

select * from note_Reminder


--Displaying all tables
select * from user_records
select * from note_records
select * from category_records
select * from reminder_records
select * from note_category
select * from note_Reminder


-----------------------------Query-1-----------------------------------
--Fetch the row from User table with Id=112233 and Password=’Maya1214’.
select * from user_records
select * from user_records where user_id = 112233 and user_password = 'Maya1214'

-----------------------------Query-2-----------------------------------
--Fetch all the rows from Note table with note_creation_date=’01/31/2019’.
select * from note_records
select * from note_records where note_creation_date = '01/31/2019'

-----------------------------Query-3-----------------------------------
--Fetch all the Categories created after ‘01/22/2019’.
select * from category_records
select * from category_records where category_creation_date > '01/22/2019'

-----------------------------Query-4-----------------------------------
--Fetch all category details which belongs to note with note id=1.
select * from category_records
select * from note_records
select * from category_records where category_creator = (select user_id from note_records where note_id = 1)

-----------------------------Query-5-----------------------------------
--Fetch all the Notes from the Note table with userId=112244.
select * from note_records
select * from note_records where user_id = 112244

-----------------------------Query-6-----------------------------------
--Fetch all the Notes from the Note table for category_id=1.
select * from note_records
select * from category_records
select * from note_records where user_id = (select category_creator from category_records where category_id = 1)

-----------------------------Query-7-----------------------------------
--Fetch all the reminder details for note id=2.
select * from reminder_records
select * from note_records
select * from reminder_records where reminder_creator = (select user_id from note_records where note_id = 2)

-----------------------------Query-8-----------------------------------
--Write a query to change the note_status to ‘Completed’ with note Id=3.

update note_records
set note_status = 'completed'
where note_id = 3
select * from note_records

-----------------------------Query-9-----------------------------------
--Write a query to set a reminder of type ‘Personal Reminders’ for Note with note id=1. 
--[Find reminder id based upon reminder_type]
select * from reminder_records
select * from note_Reminder
select * from note_records

update reminder_records
set reminder_type = 'Personal Reminder'
where reminder_creator = (select user_id from note_records where note_id = 1)

select * from reminder_records


-----------------------------Query-9-----------------------------------
--Write a query to remove all reminders from Note with note_id=2.

delete from note_Reminder
where note_id = 2

select * from note_Reminder