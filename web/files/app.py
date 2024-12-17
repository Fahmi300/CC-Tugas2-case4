from flask import Flask, jsonify, render_template
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

db_config = {
    "host": "mysql1",
    "user": "myuser",
    "password": "mydb6789tyui",
    "database": "mydb",
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/data', methods=['GET'])
def get_gold_prices():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT price FROM gold_price ORDER BY id DESC LIMIT 1;")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(rows)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9999)
