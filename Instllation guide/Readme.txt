
Setup Steps
1.Install python using the exe
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

default user details
name - admin
password - admin
hashed password - pbkdf2:sha256:600000$MfxtXWvDH7PNF6TG$54080262a87227d10afb586803b20f7bd337a8df2518fa2842de7f61d374bb07
