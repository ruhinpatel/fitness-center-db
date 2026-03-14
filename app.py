from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text
import os
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///fitness_center.db'
db = SQLAlchemy(app)

# Define models
class Center(db.Model):
    center_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    address = db.Column(db.String(255), nullable=False)

class Room(db.Model):
    room_id = db.Column(db.Integer, primary_key=True)
    center_id = db.Column(db.Integer, db.ForeignKey('center.center_id'), nullable=False)
    capacity = db.Column(db.Integer, nullable=False)
    number = db.Column(db.Integer, nullable=False)

class Session(db.Model):
    session_id = db.Column(db.Integer, primary_key=True)
    session_date = db.Column(db.Date, nullable=False)
    start_hour = db.Column(db.Time, nullable=False)
    type = db.Column(db.String(255), nullable=False)
    room_id = db.Column(db.Integer, db.ForeignKey('room.room_id'), nullable=False)
    center_id = db.Column(db.Integer, db.ForeignKey('center.center_id'), nullable=False)

class Person(db.Model):
    person_id = db.Column(db.Integer, primary_key=True)
    birth_date = db.Column(db.Date, nullable=False)
    family_name = db.Column(db.String(255), nullable=False)
    first_name = db.Column(db.String(255), nullable=False)

class Trainer(db.Model):
    trainer_id = db.Column(db.Integer, primary_key=True)
    person_id = db.Column(db.Integer, db.ForeignKey('person.person_id'), nullable=False)
    diploma = db.Column(db.String(255))

class GroupSession(db.Model):
    session_id = db.Column(db.Integer, primary_key=True)
    trainer_id = db.Column(db.Integer, db.ForeignKey('trainer.trainer_id'), nullable=False)
    type = db.Column(db.String(255), nullable=False)

class IndividualSession(db.Model):
    session_id = db.Column(db.Integer, primary_key=True)

class Participation(db.Model):
    participation_id = db.Column(db.Integer, primary_key=True)
    person_id = db.Column(db.Integer, db.ForeignKey('person.person_id'), nullable=False)
    session_id = db.Column(db.Integer, db.ForeignKey('session.session_id'), nullable=False)

def execute_sql_file(file_path):
    with app.app_context():
        with open(file_path, 'r') as file:
            sql_commands = file.read().split(';')
            connection = db.engine.raw_connection()
            cursor = connection.cursor()
            for command in sql_commands:
                if command.strip():
                    try:
                        cursor.execute(command)
                    except Exception as e:
                        print(f"Error executing command: {command}\n{e}")
            cursor.close()
            connection.commit()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/centers', methods=['GET', 'POST'])
def centers():
    if request.method == 'POST':
        name = request.form['name']
        address = request.form['address']
        new_center = Center(name=name, address=address)
        db.session.add(new_center)
        db.session.commit()
        return redirect(url_for('centers'))

    centers = Center.query.all()
    columns = ['center_id', 'name', 'address']
    return render_template('centers.html', centers=centers, columns=columns)

@app.route('/rooms', methods=['GET', 'POST'])
def rooms():
    if request.method == 'POST':
        center_id = request.form['center_id']
        capacity = request.form['capacity']
        number = request.form['number']
        new_room = Room(center_id=center_id, capacity=capacity, number=number)
        db.session.add(new_room)
        db.session.commit()
        return redirect(url_for('rooms'))

    rooms = Room.query.all()
    columns = ['room_id', 'center_id', 'capacity', 'number']
    return render_template('rooms.html', rooms=rooms, columns=columns)


@app.route('/sessions', methods=['GET', 'POST'])
def sessions():
    if request.method == 'POST':
        session_date = request.form['session_date']
        start_hour = request.form['start_hour']
        type = request.form['type']
        room_id = request.form['room_id']
        center_id = request.form['center_id']
        new_session = Session(session_date=session_date, start_hour=start_hour, type=type, room_id=room_id, center_id=center_id)
        db.session.add(new_session)
        db.session.commit()
        return redirect(url_for('sessions'))

    sessions = Session.query.all()
    columns = ['session_id', 'session_date', 'start_hour', 'type', 'room_id', 'center_id']
    return render_template('sessions.html', sessions=sessions, columns=columns)


@app.route('/persons', methods=['GET', 'POST'])
def persons():
    if request.method == 'POST':
        birth_date_str = request.form['birth_date']
        birth_date = datetime.strptime(birth_date_str, '%Y-%m-%d').date()
        family_name = request.form['family_name']
        first_name = request.form['first_name']
        new_person = Person(birth_date=birth_date, family_name=family_name, first_name=first_name)
        db.session.add(new_person)
        db.session.commit()
        return redirect(url_for('persons'))

    persons = Person.query.all()
    columns = ['person_id', 'birth_date', 'family_name', 'first_name']
    return render_template('persons.html', persons=persons, columns=columns)


@app.route('/trainers', methods=['GET', 'POST'])
def trainers():
    if request.method == 'POST':
        person_id = request.form['person_id']
        diploma = request.form['diploma']
        new_trainer = Trainer(person_id=person_id, diploma=diploma)
        db.session.add(new_trainer)
        db.session.commit()
        return redirect(url_for('trainers'))

    trainers = Trainer.query.all()
    columns = ['trainer_id', 'person_id', 'diploma']
    return render_template('trainers.html', trainers=trainers, columns=columns)


@app.route('/participations', methods=['GET', 'POST'])
def participations():
    if request.method == 'POST':
        person_id = request.form['person_id']
        session_id = request.form['session_id']
        new_participation = Participation(person_id=person_id, session_id=session_id)
        db.session.add(new_participation)
        db.session.commit()
        return redirect(url_for('participations'))

    participations = Participation.query.all()
    columns = ['participation_id', 'person_id', 'session_id']
    return render_template('participations.html', participations=participations, columns=columns)

@app.route('/interesting-questions', methods=['GET', 'POST'])
def interesting_questions():
    questions = {
        'most_popular_sessions': "Which sessions are the most popular (have the highest number of participants)?",
        'average_room_capacity': "What is the average capacity of rooms in each fitness center?",
        'most_sessions_by_trainer': "Which trainers are leading the most sessions?",
        'distribution_of_session_types': "What is the distribution of session types (e.g., Yoga, Pilates, etc.) across all centers?",
        'sessions_per_day': "How many sessions are conducted per day in each center?",
        'busiest_times': "Identify the busiest times of the day for sessions in each center.",
        'most_used_rooms': "Which rooms are most frequently used for sessions?",
        'group_vs_individual_sessions': "Find the ratio of group sessions to individual sessions in each center.",
        'most_participant_sessions': "Which participants attend the most sessions?",
        'average_age_by_session_type': "What is the average age of participants in different types of sessions?"
    }

    query_results = None
    columns = None

    if request.method == 'POST':
        selected_question = request.form.get('question')
        
        queries = {
            'most_popular_sessions': text("""
                SELECT 
                    s.session_id, s.session_date, s.type, COUNT(pa.person_id) AS total_participants
                FROM 
                    Session s
                JOIN 
                    Participation pa ON s.session_id = pa.session_id
                GROUP BY 
                    s.session_id, s.session_date, s.type
                ORDER BY 
                    total_participants DESC
                LIMIT 10;
            """),
            'average_room_capacity': text("""
                SELECT 
                    c.center_id, c.name AS center_name, AVG(r.capacity) AS average_room_capacity
                FROM 
                    Center c
                JOIN 
                    Rooms r ON c.center_id = r.center_id
                GROUP BY 
                    c.center_id, c.name;
            """),
            'most_sessions_by_trainer': text("""
                SELECT 
                    t.trainer_id, p.first_name, p.family_name, COUNT(gs.session_id) AS total_sessions
                FROM 
                    Trainer t
                JOIN 
                    Person p ON t.person_id = p.person_id
                JOIN 
                    GroupSession gs ON t.trainer_id = gs.trainer_id
                GROUP BY 
                    p.first_name, p.family_name, t.trainer_id
                ORDER BY 
                    total_sessions DESC
                LIMIT 10;
            """),
            'distribution_of_session_types': text("""
                SELECT 
                    s.type, COUNT(s.session_id) AS total_sessions
                FROM 
                    Session s
                GROUP BY 
                    s.type
                ORDER BY 
                    total_sessions DESC;
            """),
            'sessions_per_day': text("""
                SELECT 
                    c.center_id, c.name AS center_name, s.session_date, COUNT(s.session_id) AS total_sessions
                FROM 
                    Center c
                JOIN 
                    Session s ON c.center_id = s.center_id
                GROUP BY 
                    c.center_id, c.name, s.session_date
                ORDER BY 
                    s.session_date, total_sessions DESC;
            """),
            'busiest_times': text("""
                SELECT 
                    c.center_id, c.name AS center_name, s.start_hour, COUNT(s.session_id) AS total_sessions
                FROM 
                    Center c
                JOIN 
                    Session s ON c.center_id = s.center_id
                GROUP BY 
                    c.center_id, c.name, s.start_hour
                ORDER BY 
                    c.center_id, s.start_hour;
            """),
            'most_used_rooms': text("""
                SELECT 
                    r.room_id, r.number AS room_number, COUNT(s.session_id) AS total_sessions
                FROM 
                    Rooms r
                LEFT JOIN 
                    Session s ON r.room_id = s.room_id
                GROUP BY 
                    r.room_id, r.number
                ORDER BY 
                    total_sessions DESC
                LIMIT 10;
            """),
            'group_vs_individual_sessions': text("""
                SELECT 
                    c.center_id, c.name AS center_name, 
                    SUM(CASE WHEN gs.session_id IS NOT NULL THEN 1 ELSE 0 END) AS group_sessions,
                    SUM(CASE WHEN isession.session_id IS NOT NULL THEN 1 ELSE 0 END) AS individual_sessions,
                    SUM(CASE WHEN gs.session_id IS NOT NULL THEN 1 ELSE 0 END) / 
                    NULLIF(SUM(CASE WHEN isession.session_id IS NOT NULL THEN 1 ELSE 0 END), 0) AS ratio
                FROM 
                    Center c
                LEFT JOIN 
                    Session s ON c.center_id = s.center_id
                LEFT JOIN 
                    GroupSession gs ON s.session_id = gs.session_id
                LEFT JOIN 
                    IndividualSession isession ON s.session_id = isession.session_id
                GROUP BY 
                    c.center_id, c.name;
            """),
            'most_participant_sessions': text("""
                SELECT 
                    p.first_name, p.family_name, COUNT(pa.session_id) AS total_sessions
                FROM 
                    Person p
                JOIN 
                    Participation pa ON p.person_id = pa.person_id
                GROUP BY 
                    p.first_name, p.family_name
                ORDER BY 
                    total_sessions DESC
                LIMIT 10;
            """),
            'average_age_by_session_type': text("""
                SELECT 
                    s.type, 
                    AVG((julianday('now') - julianday(p.birth_date)) / 365.25) AS average_age
                FROM 
                    Session s
                JOIN 
                    Participation pa ON s.session_id = pa.session_id
                JOIN 
                    Person p ON pa.person_id = p.person_id
                GROUP BY 
                    s.type
                ORDER BY 
                    average_age;
            """)
        }
        
        sql_query = queries.get(selected_question)
        result_proxy = db.session.execute(sql_query)
        query_results = result_proxy.fetchall()
        columns = result_proxy.keys() if result_proxy.returns_rows else []

    return render_template('interesting_questions.html', questions=questions, query_results=query_results, columns=columns)


if __name__ == '__main__':
    with app.app_context():
        if os.path.exists('fitness_center.db'):
            os.remove('fitness_center.db')
        db.create_all()
        execute_sql_file('CreateDB.sql')

    # if not os.path.exists('fitness_center.db') or os.path.getsize('fitness_center.db') == 0:
    #     execute_sql_file('CreateDB.sql')

    app.run(debug=True, use_reloader=False)
