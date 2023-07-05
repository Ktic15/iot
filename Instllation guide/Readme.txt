
Setup Steps
1.Install python using the exe
2.run the setup.bat to install the required modules
3.run the run.bat to start the product


Another method
pip install -r requirements.txt

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