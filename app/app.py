 #app.py
import pandas
from fileinput import filename
from flask import Flask, render_template, request, redirect, url_for, flash
import psycopg2 #pip install psycopg2 
from psycopg2 import extras
 
app = Flask(__name__)
app.secret_key = "cairocoders-ednalan"
 
DB_HOST = "localhost"
DB_NAME = "iot_company_project001"
DB_USER = "postgres"
DB_PASS = "gokul"
DB_PORT = "5432"

conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST)

@app.route('/operator_assignment')
def Svindex():
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
    s = "SELECT * FROM Employee_Master"
    cur.execute(s) # Execute the SQL
    Eitem = cur.fetchall()
    s = "SELECT * FROM Employee_Master where employee_designation='Shift supervisor'"
    cur.execute(s) # Execute the SQL
    Svitem = cur.fetchall()
    s = "SELECT * FROM machine_operator where date_=current_date"
    cur.execute(s) # Execute the SQL
    opitems = cur.fetchall()
    return render_template('Operator_Assignment.html', Plitems = Plitem, Sitems = Sitem, Mitems=Mitem,Pitems=Pitem,Eitems=Eitem, Svitems = Svitem,list_operators=opitems)

@app.route('/oa/add_entry', methods=['POST'])
def add_entry():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        sno=0
        Product_line = request.form['proline']
        Date_ = request.form['cdate']
        Shift = request.form['shift']
        
        Shift_supervisor_name = request.form['svname']
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
            cur.execute("INSERT INTO Machine_operator (Product_line,Date_,Shift,Machine_No,Operator_Id,Part_No,Shift_supervisor_name,Time_,operator_change,old_alloc) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", (Product_line,Date_,Shift,Machine_No,Operator_Id,Part_No,Shift_supervisor_name,Time_,operator_change,sno))
            conn.commit()
        else:
            Machine_No = request.form['mno'].split(',')
            Operator_Id = request.form['oid'].split(',')
            Part_No = request.form['pno'].split(',')
            cur.execute("INSERT INTO Machine_operator (Product_line,Date_,Shift,Machine_No,Operator_Id,Part_No,Shift_supervisor_name,Time_,operator_change,old_alloc) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", (Product_line,Date_,Shift,Machine_No[1],Operator_Id[1],Part_No[1],Shift_supervisor_name,Time_,operator_change,sno))
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
  
  
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST port=DB_PORT )
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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Employee_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Employee_Master.html', list_users = list_users)
 
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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Part_Master"
    cur.execute(s) # Execute the SQL
    list_parts = cur.fetchall()
    return render_template('Part_Master.html', list_parts = list_parts)
 
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
        cur.execute("INSERT INTO part_Master (pcode,pdes,cpn,proline,npccps,pdesc) VALUES (%s,%s,%s,%s,%s,%s)", (pcode,pdes,cpn,proline,npccps,pdesc))
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
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Part_master
            SET 
            pcode = %s,
            pdes = %s,
            cpn = %s,
            proline = %s,
            npccps = %s,
            pdesc = %s
            WHERE pcode = %s
        """, (pcode,pdes,cpn,proline,npccps,pdesc,pcode))
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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Machine_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Machine_Master.html', list_machine = list_users)

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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Tool_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Tool_Master.html', list_tool = list_users)

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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Shift_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Shift_Master.html', list_shift = list_users)

@app.route('/shift/add_shift', methods=['POST'])
def add_shift():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        scode = request.form['scode']
        sname = request.form['sname']
        stime = request.form['stime']
        brlu = request.form['brlu']
        cur.execute("INSERT INTO Shift_Master (scode,sname,stime,brlu) VALUES (%s,%s,%s,%s)", (scode,sname,stime,brlu))
        conn.commit()
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
        stime = request.form['stime']
        brlu = request.form['brlu']
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE Shift_master
            SET 
            scode = %s,
            sname = %s,
            stime = %s,
            brlu = %s
            WHERE scode = %s
        """, (scode,sname,stime,brlu,scode))
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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Product_line_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Product_line_Master.html', list_product_line = list_users)
 
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
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Machine_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Dashboard.html', list_machine = list_users)
 
@app.route('/datahub')
def DhIndex():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Product_line_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Datahub.html', list_product_line = list_users)
 
@app.route('/report')
def RIndex():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Product_line_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Report.html', list_product_line = list_users)
 

if __name__ == "__main__":
    app.run(debug=True)
