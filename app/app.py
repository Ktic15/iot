 #app.py
import pandas
from fileinput import filename
from flask import Flask, render_template, request, redirect, url_for, flash, session
import psycopg2 #pip install psycopg2 
from psycopg2 import extras
import datetime
import re
from werkzeug.security import generate_password_hash, check_password_hash
import threading
import time
import aspose.pdf as pdf

# from win32com import client
# import jpype
# import asposecells
# jpype.startJVM()
# from asposecells.api import Workbook, FileFormatType

app = Flask(__name__)
app.secret_key = "cairocoders-ednalan"
 
DB_HOST = "localhost"
DB_NAME = "iot_company_project001"
DB_USER = "postgres"
DB_PASS = "gokul"
DB_PORT = "5432"

conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT )

# Global variables
list_data = []
table_vs_column=[]
userInput={}
stop_threads = False
autoRefresh = 1000*60*5 # 5 mins in millisec #auto refresh dashboard page and check shift change in thread loop


def havingAccess(roleCheck=[], errorMsg="Access Denied. Only "):
    if 'loggedin' in session:
        if roleCheck:
            if session["role"] in roleCheck or "admin"==session["role"] or "it-role"==session["role"]:
                return True
            else:
                return redirect(url_for('errorPage',errorMsg=errorMsg+', '.join(map(str, roleCheck))+", IT Role and admin have the access"))
        return True
    return redirect(url_for('login'))

def getCurrentShift():
      cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
      today = datetime.datetime.now()
      current_time = today.strftime("%H:%M")
      s = "SELECT * FROM shift_master WHERE start_time::time <= '{0}' and end_time::time >= '{0}'".format(current_time)
      cur.execute(s) # Execute the SQL
      shift_master = cur.fetchall()
      return shift_master[0][0]

previousShift=int(getCurrentShift())
previousShiftDate=datetime.datetime.now().strftime("%d-%m-%y")
currentEpochTime = time.time()
def loop():
    global previousShift
    global previousShiftDate
    global stop_threads, currentEpochTime
    while(True):
        if currentEpochTime+(autoRefresh/1000) < time.time():
            currentEpochTime = time.time()
            currentShift = int(getCurrentShift())
            if(previousShift!=currentShift):
                cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
                s = "SELECT * FROM machine_data"
                cur.execute(s) # Execute the SQL mo_efficiency mo_count
                machine_datas = cur.fetchall()

                for machine_data in machine_datas:
                    s="UPDATE machine_operator SET  mo_efficiency="+str(machine_data["efficiency"])+",mo_count="+str(machine_data["current_count"])+" where date_=\'"+str(previousShiftDate)+"\' AND shift=\'"+str(previousShift)+"\' AND machine_no=\'"+machine_data["machine_no"]+"\'"
                    cur.execute(s) # Execute the SQL mo_efficiency mo_count
                    conn.commit()

                previousShift=currentShift
                previousShiftDate=datetime.datetime.now().strftime("%d-%m-%y")
        if stop_threads:
            break


x = threading.Thread(target=loop)
#x.start()

@app.route('/')
def GhIndex():
     return  redirect("/dashboard")

@app.route('/login/', methods=['GET', 'POST'])
def login():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # Check if "username" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        print(password)
        # Check if account exists using MySQL
        cursor.execute('SELECT * FROM loginCredentials WHERE username = %s', [username])
        # Fetch one record and return result
        account = cursor.fetchone()
        if account:
            password_rs = account['password']
            print(password_rs)
            # If account exists in users table in out database
            if check_password_hash(password_rs, password):
                # Create session data, we can access this data in other routes
                session['loggedin'] = True
                session['id'] = account['id']
                session['username'] = account['username']
                session['role'] = account['role']
                # Redirect to home page
                return redirect('/')
            else:
                # Account doesnt exist or username/password incorrect
                flash('Incorrect username/password')
        else:
            # Account doesnt exist or username/password incorrect
            flash('Incorrect username/password')
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if 'loggedin' in session and session["role"]=="admin":
        cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        # Check if "username", "password" and "email" POST requests exist (user submitted form)
        if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
            # Create variables for easy access
            username = request.form['username']
            password = request.form['password']
            role = request.form['role']
            _hashed_password = generate_password_hash(password)
            #Check if account exists using MySQL
            cursor.execute('SELECT * FROM loginCredentials WHERE username = %s', [username])
            account = cursor.fetchone()
            print(account)
            # If account exists show error and validation checks
            if account:
                flash('Account already exists!')
            elif not re.match(r'[A-Za-z0-9]+', username):
                flash('Username must contain only characters and numbers!')
            elif not username or not password:
                flash('Please fill out the form!')
            else:
                # Account doesnt exists and the form data is valid, now insert new account into users table
                cursor.execute("INSERT INTO loginCredentials (username, password, role) VALUES (%s,%s,%s)", (username, _hashed_password, role))
                conn.commit()
                flash('You have successfully registered!.')
        elif request.method == 'POST':
            # Form is empty... (no POST data)
            flash('Please fill out the form!')
        # Show registration form with message (if any)
        return render_template('register.html')
    return render_template('error_msg.html',errorMsg="Access Denied. Only Admin have the access to register new user")

@app.route('/logout')
def logout():
    # Remove session data, this will log the user out
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('role', None)
    # Redirect to login page
    return redirect(url_for('login'))

@app.route('/error_msg/<errorMsg>')
def errorPage(errorMsg):
    return render_template('error_msg.html',errorMsg=errorMsg)

@app.route('/operator_assignment')
def Svindex():
    if(havingAccess(["supervisor"])==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Product_Line_Master"
        cur.execute(s) # Execute the SQL
        Plitem = cur.fetchall()
        s = "SELECT * FROM Shift_Master"
        cur.execute(s) # Execute the SQL
        Sitem = cur.fetchall()
        s = "SELECT * FROM Machine_Master"
        cur.execute(s) # Execute the SQL
        Mitem = cur.fetchall()
        s = "SELECT * FROM Part_Master"
        cur.execute(s) # Execute the SQL
        Pitem = cur.fetchall()
        s = "SELECT * FROM Employee_Master  where employee_designation='Operator'"
        cur.execute(s) # Execute the SQL
        Eitem = cur.fetchall()
        s = "SELECT * FROM Employee_Master where employee_designation='Shift supervisor'"
        cur.execute(s) # Execute the SQL
        Svitem = cur.fetchall()
        s = "SELECT * FROM machine_operator where date_=current_date"
        cur.execute(s) # Execute the SQL
        opitems = cur.fetchall()
        return render_template('Operator_Assignment.html', Plitems = Plitem, Sitems = Sitem, Mitems=Mitem,Pitems=Pitem,Eitems=Eitem, Svitems = Svitem,list_operators=opitems)
    return havingAccess(["supervisor"])

@app.route('/oa/add_entry', methods=['POST'])
def add_entry():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        sno=0
        Product_line = request.form['proline']
        Date_ = request.form['cdate']
        Shift = request.form['shift']
        
        Shift_supervisor_name = request.form['svname'].split(',')
        Time_ = request.form['ctime']
        operator_change = request.form['opc']
        
        if(operator_change =='Y'): 
            Machine_No = request.form['mno']
            Operator_Id = request.form['oid']
            Part_No = request.form['pno']
            sno=request.form['sno']
            reason=request.form['reason']
            cur.execute("INSERT INTO change_reason (sno,reason,time_) VALUES (%s,%s,current_time)", (int(sno),reason))
            conn.commit()
            cur.execute("INSERT INTO Machine_operator (Product_line,Date_,Shift,Machine_No,Operator_Id,Part_No,Shift_supervisor_name,Time_,operator_change,old_alloc) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", (Product_line,Date_,Shift,Machine_No,Operator_Id,Part_No,Shift_supervisor_name[0],Time_,operator_change,sno))
            conn.commit()
        else:
            Machine_No = request.form['mno'].split(',')
            Operator_Id = request.form['oid'].split(',')
            Part_No = request.form['pno'].split(',')
            cur.execute("INSERT INTO Machine_operator (Product_line,Date_,Shift,Machine_No,Operator_Id,Part_No,Shift_supervisor_name,Shift_supervisor_Id,Time_,operator_change,old_alloc) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", (Product_line,Date_,Shift,Machine_No[1],Operator_Id[1],Part_No[1],Shift_supervisor_name[0],Shift_supervisor_name[1],Time_,operator_change,sno))
            conn.commit()
        
        flash('Operator Added successfully')
        return redirect(url_for('Svindex'))
    
@app.route('/oa/change/<sno>', methods = ['POST', 'GET'])
def get_operator(sno):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM machine_operator WHERE sno = %d "% int(sno))
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_operator.html', operator = data[0])

@app.route('/tool_change')
def tool_change():
    return render_template('Tool_Change.html')

@app.route('/machine_stoppage')
def machine_stoppage():
    return render_template('Machine_Stoppage.html')


@app.post('/view')
def view():
 
    # Read the File using Flask request
    file = request.files['file']
    # save file in local directory
    file.save(file.filename)
 
    # Parse the data as a Pandas DataFrame type
    data = pandas.read_excel(file)
    
    # Return HTML snippet that will render the tabl
    
    def execute_values(conn, df, table):
  
        tuples = [tuple(x) for x in df.to_numpy()]
  
        cols = ','.join(list(df.columns))
     # SQL query to execute
        query = "INSERT INTO %s(%s) VALUES %%s" % (table, cols)
        cursor = conn.cursor()
        try:
            extras.execute_values(cursor, query, tuples)
            conn.commit()
        except (Exception, psycopg2.DatabaseError) as error:
            print("Error: %s" % error)
            conn.rollback()
            cursor.close()
            return 1
        print("the dataframe is inserted")
        cursor.close()
  
  
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT )
    tn=""
    if(request.form['fname']=="EIndex"):
        tn="employee_master"
    if(request.form['fname']=="Svindex"):
        tn="machine_operator"
    if(request.form['fname']=="MIndex"):
        tn="machine_master"
    execute_values(conn, data,tn)
    return redirect(url_for(request.form['fname']))
  

@app.route('/employee')
def EIndex():
    if(havingAccess(["hr","supervisor"])==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Employee_Master"
        cur.execute(s) # Execute the SQL
        list_users = cur.fetchall()
        return render_template('Employee_Master.html', list_users = list_users)
    else:
        return havingAccess(["hr","supervisor"])

@app.route('/add_Employee', methods=['POST'])
def add_Employee():
     cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
     if request.method == 'POST':
         ecode = request.form['ecode']
         emaster = request.form['emaster']
         Edeg = request.form['edeg']
         aow = request.form['aow']
         eaddress = request.form['eaddress']
         eaadhar = request.form['eaadhar']
         emobile = request.form['emobile']
         Fmanager = request.form['fmanager']
         cur.execute("INSERT INTO Employee_Master (Employee_Code,Employee_Name,Employee_designation,Area_of_Work,Employee_Address,Employee_Aadhaar,Employee_Mobile_No,Function_Manager) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)", (ecode,emaster,Edeg,aow,eaddress,eaadhar,emobile,Fmanager))
         conn.commit()
         flash('Employee Added successfully')
         return redirect(url_for('EIndex'))

@app.route('/edit/<ecode>', methods = ['POST', 'GET'])
def get_employee(ecode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM Employee_Master WHERE Employee_Code = %s", [ecode])
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_employee.html', Employee_Master = data[0])
 
@app.route('/update/<ecode>', methods=['POST'])
def update_employee(ecode):
    if request.method == 'POST':
        ecode = request.form['ecode']
        emaster = request.form['emaster']
        Edeg = request.form['edeg']
        aow = request.form['aow']
        eaddress = request.form['eaddress']
        eaadhar = request.form['eaadhar']
        emobile = request.form['emobile']
        Fmanager = request.form['fmanager']
         
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Employee_master
            SET 
            Employee_Code = %s,
            Employee_Name = %s,
            Employee_designation = %s,
            Area_of_Work = %s,
            Employee_Address = %s,
            Employee_Aadhaar = %s,
            Employee_Mobile_No = %s,
            Functional_Manager = %s
            WHERE Employee_Code = %s
        """, (ecode,emaster,Edeg,aow,eaddress,eaadhar,emobile,Fmanager,ecode))
        flash('Employee Updated Successfully')
        conn.commit()
        return redirect(url_for('EIndex'))
 
@app.route('/delete/<string:ecode>', methods = ['POST','GET'])
def delete_employee(ecode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute('DELETE FROM Employee_Master WHERE Employee_Code = %s', [ecode])
    conn.commit()
    flash('Employee Removed Successfully')
    return redirect(url_for('EIndex'))
 
@app.route('/part')
def PIndex():
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Part_Master"
        cur.execute(s) # Execute the SQL
        list_parts = cur.fetchall()
        return render_template('Part_Master.html', list_parts = list_parts)
    return havingAccess()
 
@app.route('/part/add_part', methods=['POST'])
def add_part():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        pcode = request.form['pcode']
        pdes = request.form['pdes']
        cpn = request.form['cpn']
        proline = request.form['proline']
        npccps = request.form['npccps']
        pdesc = request.form['pdesc']
        efficiency_tolarance = request.form['efficiency_tolarance']
        cur.execute("INSERT INTO part_Master (pcode,pdes,cpn,proline,npccps,pdesc,efficiency_tolarance) VALUES (%s,%s,%s,%s,%s,%s,%s)", (pcode,pdes,cpn,proline,npccps,pdesc,efficiency_tolarance))
        conn.commit()
        flash('Part Added successfully')
        return redirect(url_for('PIndex'))
 
@app.route('/part/edit/<pcode>', methods = ['POST', 'GET'])
def get_part(pcode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM Part_Master WHERE pcode = %s", [pcode])
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_part.html', Part_Master = data[0])
 
@app.route('/part/update/<pcode>', methods=['POST'])
def update_part(pcode):
    if request.method == 'POST':
        pcode = request.form['pcode']
        pdes = request.form['pdes']
        cpn = request.form['cpn']
        proline = request.form['proline']
        npccps = request.form['npccps']
        pdesc = request.form['pdesc']
        efficiency_tolarance = request.form['efficiency_tolarance']
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Part_master
            SET 
            pcode = %s,
            pdes = %s,
            cpn = %s,
            proline = %s,
            npccps = %s,
            pdesc = %s,
            efficiency_tolarance = %s
            WHERE pcode = %s
        """, (pcode,pdes,cpn,proline,npccps,pdesc,efficiency_tolarance,pcode))
        flash('Part Updated Successfully')
        conn.commit()
        return redirect(url_for('PIndex'))
 
@app.route('/part/delete/<string:pcode>', methods = ['POST','GET'])
def delete_part(pcode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute('DELETE FROM Part_Master WHERE pcode = %s', [pcode])
    conn.commit()
    flash('Part Removed Successfully')
    return redirect(url_for('PIndex'))

@app.route('/machine')
def MIndex():
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Machine_Master"
        cur.execute(s) # Execute the SQL
        list_users = cur.fetchall()
        return render_template('Machine_Master.html', list_machine = list_users)
    return havingAccess()

@app.route('/machine/add_machine', methods=['POST'])
def add_machine():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        Mno = request.form['Mno']
        mname = request.form['mname']
        mcat = request.form['mcat']
        mmnu = request.form['mmnu']
        contdet = request.form['contdet']
        doc = request.form['doc']
        mkva = request.form['mkva']
        cur.execute("INSERT INTO Machine_Master (Mno,mname,mcat,mmnu,contdet,doc,mkva) VALUES (%s,%s,%s,%s,%s,%s,%s)", (Mno,mname,mcat,mmnu,contdet,doc,mkva))
        conn.commit()
        flash('Machine Added successfully')
        return redirect(url_for('MIndex'))
 
@app.route('/machine/edit/<Mno>', methods = ['POST', 'GET'])
def get_machine(Mno):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM Machine_Master WHERE Mno = %s", [Mno])
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_machine.html', Machine_Master = data[0])
 
@app.route('/machine/update/<Mno>', methods=['POST'])
def update_machine(Mno):
    if request.method == 'POST':
        Mno = request.form['Mno']
        mname = request.form['mname']
        mcat = request.form['mcat']
        mmnu = request.form['mmnu']
        contdet = request.form['contdet']
        doc = request.form['doc']
        mkva = request.form['mkva']
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Machine_master
            SET 
            Mno = %s,
            mname = %s,
            mcat = %s,
            mmnu = %s,
            contdet = %s,
            doc = %s,
            mkva = %s
            WHERE Mno = %s
        """, (Mno,mname,mcat,mmnu,contdet,doc,mkva,Mno))
        flash('Machine Updated Successfully')
        conn.commit()
        return redirect(url_for('MIndex'))
 
@app.route('/machine/delete/<string:Mno>', methods = ['POST','GET'])
def delete_machine(Mno):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute('DELETE FROM Machine_Master WHERE Mno = %s', [Mno])
    conn.commit()
    flash('Machine Removed Successfully')
    return redirect(url_for('MIndex'))
 
@app.route('/tool')
def TIndex():
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Tool_Master"
        cur.execute(s) # Execute the SQL
        list_users = cur.fetchall()
        return render_template('Tool_Master.html', list_tool = list_users)
    return havingAccess()

@app.route('/tool/add_tool', methods=['POST'])
def add_tool():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        tno = request.form['tno']
        tname = request.form['tname']
        ttype = request.form['ttype']
        tlpc = request.form['tlpc']
        maccat = request.form['maccat']
        cur.execute("INSERT INTO Tool_Master (tno,tname,ttype,tlpc,maccat) VALUES (%s,%s,%s,%s,%s)", (tno,tname,ttype,tlpc,maccat))
        conn.commit()
        flash('Tool Added successfully')
        return redirect(url_for('TIndex'))
 
@app.route('/tool/edit/<tno>', methods = ['POST', 'GET'])
def get_tool(tno):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM Tool_Master WHERE tno = %s", [tno])
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_tool.html', Tool_Master = data[0])
 
@app.route('/tool/update/<tno>', methods=['POST'])
def update_tool(tno):
    if request.method == 'POST':
        tno = request.form['tno']
        tname = request.form['tname']
        ttype = request.form['ttype']
        tlpc = request.form['tlpc']
        maccat = request.form['maccat']
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Tool_master
            SET 
            tno = %s,
            tname = %s,
            ttype = %s,
            tlpc = %s,
            maccat = %s
            WHERE tno = %s
        """, (tno,tname,ttype,tlpc,maccat,tno))
        flash('Tool Updated Successfully')
        conn.commit()
        return redirect(url_for('TIndex'))
 
@app.route('/tool/delete/<string:tno>', methods = ['POST','GET'])
def delete_tool(tno):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute('DELETE FROM Tool_Master WHERE tno = %s', [tno])
    conn.commit()
    flash('Tool Removed Successfully')
    return redirect(url_for('TIndex'))

@app.route('/shift')
def SIndex():
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Shift_Master"
        cur.execute(s) # Execute the SQL
        list_users = cur.fetchall()
        return render_template('Shift_Master.html', list_shift = list_users)
    return havingAccess()

@app.route('/shift/add_shift', methods=['POST'])
def add_shift():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        scode = request.form['scode']
        sname = request.form['sname']
        brlu = request.form['brlu']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        cur.execute("INSERT INTO Shift_Master (scode,sname,brlu,start_time,end_time) VALUES (%s,%s,%s,%s,%s)", (scode,sname,brlu,start_time,end_time))
        conn.commit()
        cur.close()
        flash('Shift Added successfully')
        return redirect(url_for('SIndex'))
 
@app.route('/shift/edit/<scode>', methods = ['POST', 'GET'])
def get_shift(scode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM Shift_Master WHERE scode = %s", [scode])
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_shift.html', Shift_Master = data[0])
 
@app.route('/shift/update/<scode>', methods=['POST'])
def update_shift(scode):
    if request.method == 'POST':
        scode = request.form['scode']
        sname = request.form['sname']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        brlu = request.form['brlu']
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Shift_master
            SET 
            scode = %s,
            sname = %s,
            brlu = %s,
            start_time = %s,
            end_time = %s
            WHERE scode = %s
        """, (scode,sname,brlu,start_time,end_time,scode))
        flash('Shift Updated Successfully')
        conn.commit()
        return redirect(url_for('SIndex'))
 
@app.route('/shift/delete/<string:scode>', methods = ['POST','GET'])
def delete_shift(scode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute('DELETE FROM Shift_Master WHERE scode = %s', [scode])
    conn.commit()
    flash('Shift Removed Successfully')
    return redirect(url_for('SIndex'))

@app.route('/product_line')
def PLIndex():
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM Product_line_Master"
        cur.execute(s) # Execute the SQL
        list_users = cur.fetchall()
        return render_template('Product_line_Master.html', list_product_line = list_users)
    return havingAccess()

@app.route('/product_line/add_product_line', methods=['POST'])
def add_product_line():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        
        pcode = request.form['pcode']
        pline = request.form['pline']
        cur.execute("INSERT INTO Product_line_Master (pcode,pline) VALUES (%s,%s)", (pcode,pline))
        conn.commit()
        flash('Product_line Added successfully')
        return redirect(url_for('PLIndex'))
 
@app.route('/product_line/edit/<pcode>', methods = ['POST', 'GET'])
def get_product_line(pcode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute("SELECT * FROM Product_line_Master WHERE pcode = %s", [pcode])
    data = cur.fetchall()
    cur.close()
    print(data)
    return render_template('edit_product_line.html', Product_line_Master = data[0])
 
@app.route('/product_line/update/<pcode>', methods=['POST'])
def update_product_line(pcode):
    if request.method == 'POST':
        
        pcode = request.form['pcode']
        pline = request.form['pline']
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Product_line_master
            SET 
            pcode = %s,
            pline = %s
            WHERE pcode = %s
        """, (pcode,pline,pcode))
        flash('Product_line Updated Successfully')
        conn.commit()
        return redirect(url_for('PLIndex'))
 
@app.route('/product_line/delete/<string:pcode>', methods = ['POST','GET'])
def delete_product_line(pcode):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute('DELETE FROM Product_line_Master WHERE pcode = %s', [pcode])
    conn.commit()
    flash('Product_line Removed Successfully')
    return redirect(url_for('PLIndex'))
 
@app.route('/dashboard')
def DbIndex():
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        s = "SELECT * FROM machine_master INNER JOIN machine_data ON machine_master.mno=machine_data.machine_no"
        cur.execute(s) # Execute the SQL
        machine_list = cur.fetchall()

        currentShift = getCurrentShift()



        dashboard_machine_data = []
        for machine in machine_list:
            machine_details={}
            machine_details["mname"] = machine["mname"]
            machine_details["mno"] = machine["mno"]
            machine_details["current_count"] = machine["current_count"]
            machine_details["efficiency"] = machine["efficiency"]
            machine_details["efficiency_tolarance"] = 5
            cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
            s = "SELECT * FROM machine_operator INNER JOIN part_master ON machine_operator.part_no=part_master.pcode INNER JOIN machine_master ON machine_operator.machine_no=machine_master.mno INNER JOIN employee_master ON machine_operator.operator_id=employee_master.employee_code where machine_operator.shift=\'"+str(currentShift)+"\' AND machine_operator.machine_no=\'"+machine["mno"]+"\' AND machine_operator.date_=current_date"
            cur.execute(s) # Execute the SQL
            users_parts_list_for_machine = cur.fetchall()
            for list_details in users_parts_list_for_machine:
                machine_details["employee_code"] = list_details["employee_code"]
                machine_details["employee_name"] = list_details["employee_name"]
                machine_details["pcode"] = list_details["pcode"]
                machine_details["pdes"] = list_details["pdes"]
                machine_details["npccps"] = list_details["npccps"]
                machine_details["efficiency_tolarance"] = list_details["efficiency_tolarance"]
            dashboard_machine_data.append(machine_details)
        # dashboard_machine_data.extend(dashboard_machine_data)
        dashboard_machine_data_split=[]
        dashboard_machine_data_container=[]
        max_per_page=12
        count=0
        for data in dashboard_machine_data:
            dashboard_machine_data_container.append(data)
            count+=1
            if count==12:
                count=0
                dashboard_machine_data_split.append(dashboard_machine_data_container)
                dashboard_machine_data_container=[]
        dashboard_machine_data_split.append(dashboard_machine_data_container)
        page_count = len(dashboard_machine_data_split)
        return render_template('Dashboard.html', dashboard_machine_data_split = dashboard_machine_data_split ,currentShift=currentShift,page_count=page_count,autoRefresh=autoRefresh)
    return havingAccess()

@app.route('/datahub')
def DhIndex():
    return redirect("/machine")
    # cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # s = "SELECT * FROM Product_line_Master"
    # cur.execute(s) # Execute the SQL
    # list_users = cur.fetchall()
    # return render_template('Datahub.html', list_product_line = list_users)

@app.route('/manage')
def manage():
    return redirect("/operator_assignment")

@app.route('/report', methods=['POST','GET'])
def RIndex():
    return  redirect("/employees_report")
    # Check if user is loggedin
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        global list_data
        global table_vs_column
        status = ""
        #app.logger.warning('testing warning log')
        #app.logger.error('testing error log')
        #app.logger.info('testing info log')
        #print('Hi', flush=True)
        if request.method == 'POST':
            if "save" in request.form:
                list_data = []
                table_vs_column=[]
                for selected_column in request.form:
                    if selected_column!="save":
                        table_vs_column.append(selected_column)

                s = "SELECT "
                for column in table_vs_column:
                    s+=column+","
                s=s[0:-1]
                s+=" FROM machine_operator INNER JOIN employee_master ON machine_operator.operator_id=employee_master.employee_code INNER JOIN machine_master ON machine_operator.machine_no=machine_master.mno INNER JOIN machine_data ON machine_operator.machine_no=machine_data.machine_no"
                cur.execute(s) # Execute the SQL
                list_data = cur.fetchall()
            elif "export" in request.form:
                if list_data!=[]:
                    df = pandas.DataFrame(list_data,index=[x for x in range(1,len(list_data)+1)], columns=table_vs_column)
                    df.to_excel('Reports/report_'+datetime.datetime.utcnow().strftime("%Y-%m-%d_%H.%M.%S.%f")[:-4]+".xlsx", sheet_name='sheet 1')
                    status="export success"
                else:
                    status="No date to export"
            if "reset" in request.form:
                list_data = []
                table_vs_column=[]

        s= "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = \'employee_master\'"
        cur.execute(s) # Execute the SQL
        employee_master = cur.fetchall()

        s= "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = \'machine_master\'"
        cur.execute(s) # Execute the SQL
        machine_master = cur.fetchall()

        s= "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = \'machine_operator\'"
        cur.execute(s) # Execute the SQL
        machine_operator = cur.fetchall()

        s= "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = \'machine_data\'"
        cur.execute(s) # Execute the SQL
        machine_data = cur.fetchall()

        return render_template('Report.html', employee_master=employee_master, machine_master=machine_master, machine_data=machine_data,machine_operator=machine_operator, table_vs_column=table_vs_column, list_data = list_data, status=status)
    # User is not loggedin redirect to login page
    return havingAccess()

@app.route('/employees_report', methods=['POST','GET'])
def employees_report():
    # Check if user is loggedin
    if(havingAccess()==True):
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        global list_data
        global table_vs_column
        global userInput
        status = ""
        columns = ["Employee Code","Employee Name","Shift","Date","Product Line","Part No","part Name","Machine No","Machine Name","Supervisor","Efficiency(%)","count"]
        table_vs_column=["employee_master.employee_code","employee_master.employee_name","machine_operator.shift","machine_operator.date_","machine_operator.product_line","machine_operator.part_no","part_master.pdes","machine_operator.machine_no","machine_master.mname","machine_operator.shift_supervisor_name","machine_operator.mo_efficiency","machine_operator.mo_count"]
        #app.logger.warning('testing warning log')
        #app.logger.error('testing error log')
        #app.logger.info('testing info log')
        #print('Hi', flush=True)
        if request.method == 'POST':
            if "save" in request.form:
                list_data = []
                employeeCode = request.form["employeeCode"]
                machineCode = request.form["machineCode"]
                supervisorCode = request.form["supervisorCode"]
                partCode = request.form["partCode"]
                fromDate = request.form["fromDate"]
                toDate = request.form["toDate"]
                shiftCode = request.form["shiftCode"]
                userInput ={"employeeCode":employeeCode,"machineCode":machineCode,"supervisorCode":supervisorCode,"partCode":partCode,"fromDate":fromDate,"toDate":toDate,"shiftCode":shiftCode}
                s = "SELECT "
                for column in table_vs_column:
                    s+=column+","
                s=s[0:-1]
                s+=" FROM machine_operator INNER JOIN employee_master ON machine_operator.operator_id=employee_master.employee_code INNER JOIN machine_master ON machine_operator.machine_no=machine_master.mno INNER JOIN part_master ON machine_operator.part_no=part_master.pcode"
                s+=" WHERE machine_operator.date_::date >= \'"+fromDate+"\' AND machine_operator.date_::date <= \'"+toDate+"\'"
                if employeeCode!="all":
                    s+=" AND machine_operator.operator_id=\'"+employeeCode+"\'"
                if shiftCode!="all":
                    s+=" AND machine_operator.shift=\'"+shiftCode+"\'"
                if machineCode!="all":
                    s+=" AND machine_operator.machine_no=\'"+machineCode+"\'"
                if supervisorCode!="all":
                    s+=" AND machine_operator.shift_supervisor_Id=\'"+supervisorCode+"\'"
                if partCode!="all":
                    s+=" AND machine_operator.shift=\'"+partCode+"\'"

                cur.execute(s) # Execute the SQL
                list_data = cur.fetchall()
                length = len(list_data)
                if length!=0:
                    total=["" for i in range(len(columns)-3)]
                    total.append("Total Average")
                    efficiency=0
                    count=0
                    for list in list_data:
                        if list["mo_efficiency"]!=None:
                            efficiency+=int(list["mo_efficiency"])
                        if list["mo_count"]!=None:
                            count+=int(list["mo_count"])
                    total.extend([format(efficiency/length,'.2f'),format(count/length,'.2f')])
                    list_data.append(total)
            elif "export" in request.form:
                if list_data!=[]:
                    df = pandas.DataFrame(list_data,index=[x for x in range(1,len(list_data)+1)], columns=columns)
                    fileName='Reports/Employee_report_'+datetime.datetime.utcnow().strftime("%Y-%m-%d_%H.%M.%S.%f")[:-4]
                    df.to_excel(fileName+".xlsx", sheet_name='employee')
                    if "export_pdf" in request.form:
                        pass
#                         license = pdf.License()
#                         license.set_license("Aspose.Total.lic")

                        # Instantiate a new PDF document
                        pdfFile = pdf.Document()

                        # Create a page in the PDF file
                        newPage = pdfFile.pages.add()

                        text_fragment = pdf.text.TextFragment("AVO Carbon Report")
                        text_fragment.text_state.font_size = 22
                        text_fragment.horizontal_alignment = 2
                        text_fragment.margin = pdf.MarginInfo(0,0,0,-40)
                        newPage.paragraphs.add(text_fragment)

                        # Create a table
                        table = pdf.Table()
                        table.column_widths = '37'
                        # table.alignment = 20
                        # table.column_adjustment = 50
                        table.default_cell_padding = pdf.MarginInfo(2,2,2,2)
                        table.margin = pdf.MarginInfo(left=-80,top=10,right=-80,bottom=0) # left,top,right,bottom
                        # Set border width
                        table.default_cell_border =  pdf.BorderInfo(pdf.BorderSide.ALL, 1.0, pdf.Color.black)
                        row = table.rows.add()
                        cell = row.cells.add()
                        cell.alignment = 2
                        textCell= pdf.text.TextFragment("Sno")
                        textCell.text_state.font_size = 10
                        cell.paragraphs.add(textCell);
                        for title in columns:
                            cell = row.cells.add()
                            cell.alignment = 2
                            textCell = pdf.text.TextFragment(title)
                            textCell.text_state.font_size = 10
                            cell.paragraphs.add(textCell)
                        sno=0
                        list_data.extend(list_data)
                        for rows in list_data:
                            # Add a row to the table
                            row = table.rows.add()
                            sno+=1
                            row.cells.add(str(sno))
                            for datas in rows:
                                # Add table cells
                                row.cells.add(str(datas))

                        # Add table to the target page
                        newPage.paragraphs.add(table)

                        # Save the PDF on the disk
                        pdfFile.save(fileName+".pdf")

                        print("Table in PDF created successfully")

                        # var headerTable = new Aspose.PDF.Table {DefaultCellBorder = new PDF.BorderInfo(PDF.BorderSide.Top, 0.1F)};
                        # var margin = new PDF.MarginInfo { Top = 2f, Left = 0f, Right = 0f, Bottom = 5f };
                        # headerTable.DefaultCellPadding = margin;
                        #
                        # var row1 = headerTable.Rows.Add();
                        # var cell1= row1.Cells.Add();
                        # cell1.Alignment = PDF.HorizontalAlignment.Left;
                        # var textCell= new TextFragment(“my column text that should stretch…”);
                        # cell1.Paragraphs.Add(textCell);
                        # header.Paragraphs.Add(headerTable);

                        # workbook = Workbook(fileName+".xlsx")
                        # saveOptions = PdfSaveOptions()
                        # saveOptions.setOnePagePerSheet(True)
                        # workbook.save(fileName+".pdf", saveOptions)
                        # Import Module
                         # Open Microsoft Excel
                         # excel = client.Dispatch("Excel.Application")
                         #
                         # # Read Excel File
                         # sheets = excel.Workbooks.Open(fileName+".xlsx")
                         # work_sheets = sheets.Worksheets[0]
                         #
                         # # Convert into PDF File
                         # work_sheets.ExportAsFixedFormat(0, fileName+".pdf")
                    status="export success"
                else:
                    status="No date to export"
            if "reset" in request.form:
                list_data = []
                userInput={}

        s = "SELECT * FROM Employee_Master  where employee_designation='Operator'"
        cur.execute(s) # Execute the SQL
        employeesItem = cur.fetchall()

        s = "SELECT * FROM Shift_Master"
        cur.execute(s) # Execute the SQL
        shiftItem = cur.fetchall()

        s = "SELECT * FROM Machine_Master"
        cur.execute(s) # Execute the SQL
        machinesItem = cur.fetchall()

        s = "SELECT * FROM Part_Master"
        cur.execute(s) # Execute the SQL
        partsItem = cur.fetchall()

        s = "SELECT * FROM Employee_Master where employee_designation='Shift supervisor'"
        cur.execute(s) # Execute the SQL
        supervisorsItem = cur.fetchall()

    return render_template('Employees_Report.html',employeesItem=employeesItem, shiftItem=shiftItem,machinesItem=machinesItem,partsItem=partsItem, supervisorsItem=supervisorsItem, columns=columns, list_data = list_data, status=status,userInput=userInput)
    # User is not loggedin redirect to login page
    return havingAccess()

if __name__ == "__main__":
    app.run( debug=True,host="0.0.0.0")
    stop_threads=True
