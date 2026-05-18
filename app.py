from flask import Flask, render_template, request, redirect, url_for
import psycopg2
from psycopg2.extras import RealDictCursor
import os

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="pharmacy",
        user="postgres",
        password="postgres"
    )
    return conn

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/medicines')
def medicines():
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute('SELECT m.*, c.name as category_name FROM medicines m JOIN categories c ON m.category_id = c.category_id ORDER BY m.name')
    medicines = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('medicines.html', medicines=medicines)

@app.route('/patients')
def patients():
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute('SELECT * FROM patients ORDER BY full_name')
    patients = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('patients.html', patients=patients)

@app.route('/sales')
def sales():
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute('''
        SELECT s.sale_id, s.sale_date, s.total_amount, s.payment_method,
               p.full_name as patient_name, e.full_name as employee_name
        FROM sales s
        LEFT JOIN patients p ON s.patient_id = p.patient_id
        JOIN employees e ON s.employee_id = e.employee_id
        ORDER BY s.sale_date DESC
    ''')
    sales = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('sales.html', sales=sales)

@app.route('/add_sale', methods=('GET', 'POST'))
def add_sale():
    if request.method == 'POST':
        patient_id = request.form['patient_id'] or None
        employee_id = request.form['employee_id']
        payment_method = request.form['payment_method']
        total_amount = request.form['total_amount']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO sales (patient_id, employee_id, total_amount, payment_method) VALUES (%s, %s, %s, %s)',
                    (patient_id, employee_id, total_amount, payment_method))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('sales'))

    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute('SELECT patient_id, full_name FROM patients')
    patients = cur.fetchall()
    cur.execute('SELECT employee_id, full_name FROM employees')
    employees = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('add_sale.html', patients=patients, employees=employees)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
