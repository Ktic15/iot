@app.route('/dashboard')
def DbIndex():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM Product_line_Master"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('Dashboard.html', list_product_line = list_users)
 
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
 