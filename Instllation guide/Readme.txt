
Setup Steps
1.Download and Install python using the link - https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe
  Website link - https://www.python.org/downloads/release/python-3114/
2.run the setup.bat to install the required modules
3.run the run.bat to start the product


Another method
pip install -r requirements.txt

Need to install

pip install aspose.pdf

additional modules required
pip install pandas
pip install flask
pip install psycopg2
pip install xlwt(not sure)
pip install openpyxl(not sure)
Werkzeug

DB querys
create table loginCredentials(
 	id serial primary key,
	username VARCHAR(100) NOT NULL,
	password varchar(255) not NULL,
	role varchar(50) NOT NULL
);

create table machine_data(
 	machine_no VARCHAR(255) NOT NULL primary key,
	current_count VARCHAR(255) NOT NULL,
	efficiency int not NULL,
    efficiency_count varchar(255) not NULL
)

ALTER TABLE part_master
ADD efficiency_tolarance int not NULL

ALTER TABLE shift_master
ADD start_time TIME not NULL,
ADD end_time TIME not NULL,
DROP COLUMN stime

_new_

ALTER TABLE machine_master
ADD mm_efficiency int

ALTER TABLE employee_master
ADD em_efficiency int

ALTER TABLE machine_operator
ADD mo_efficiency int,
ADD mo_count int
UPDATE machine_operator SET  mo_efficiency= 100,mo_count= 22;(this line is to put fake data)

_new-2_(13-08-2023)

create table tool_data(
 	id serial primary key,
	tool_no varchar(255) not NULL,
	machine_no VARCHAR(100) NOT NULL,
	Reason varchar(255) not NULL
)

ALTER TABLE machine_operator
ADD tool_no varchar(40)

_new-3_(27-08-2023)-for upload excel file for operator assignment

ALTER TABLE machine_operator ALTER COLUMN time_ SET DEFAULT NOW();
ALTER TABLE machine_operator ALTER COLUMN operator_change SET DEFAULT 'N';
ALTER TABLE machine_operator ALTER COLUMN old_alloc SET DEFAULT 0;

_new-4_(02-09-2023)
ALTER TABLE part_master ALTER COLUMN efficiency_tolarance SET DEFAULT 10;
ALTER TABLE employee_master ADD employee_alternate_mobile_no VARCHAR(40);
employee_address, employee_aadhaar, employee_mobile_no columns in employee_master table NOT NULL removed

_new-5_(14-10-2023)
ALTER TABLE machine_data ADD status VARCHAR(40);
ALTER TABLE machine_data ADD previous_count VARCHAR(40);
ALTER TABLE machine_data ADD machine_start_time TIME;
ALTER TABLE machine_data ADD previous_machine_start_time TIME;
ALTER TABLE machine_operator ADD machine_start_time TIME;

_new-6_(29-10-2023)
create table hourly_report(
 	sno serial primary key,
	dateandtime TIMESTAMP,
	w2 VARCHAR(16),
	w10 varchar(16)
)

_new-7_(06-11-2023)
ALTER TABLE machine_data
ADD previous_hour_count varchar(255)

_new-8_(08-11-2023)
ALTER TABLE hourly_report
ADD shift varchar(40)

_new-8_2_(08-11-2023)
removed shift column in hourly_report

_new-9_(24-03-2024)
create table machine_data_g as (select * from machine_data);
create table machine_data_12h as (select * from machine_data);
create table shift_master_g as (select * from shift_master);
create table shift_master_12h as (select * from shift_master);

git link https://github.com/Ktic15/iot

requirement generation
pip install pipreqs
pipreqs "D:\personal storage\aa win xp\iot projects\iot machine count report genarate companyProject001\repository"

test machine postgres connecitons
DB_HOST = "localhost"
DB_NAME = "iot-project"
DB_USER = "postgres"
DB_PASS = "espmqtt"
DB_PORT = "5432"

DB passwords
espmqtt, iot

pg connect to windows
https://blog.devart.com/configure-postgresql-to-allow-remote-connection.html

default user details
name - admin
password - admin
hashed password - pbkdf2:sha256:600000$MfxtXWvDH7PNF6TG$54080262a87227d10afb586803b20f7bd337a8df2518fa2842de7f61d374bb07

node red
http://127.0.0.1:1880/#flow/1ce336a1f129144e
http://127.0.0.1:1880/ui/#!/0?socketid=85zZPyOjCe3oPGfFAAAR
