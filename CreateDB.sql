-- Final Project Fitness center database -- 
CREATE DATABASE fitness_center;
USE  fitness_center;

-- Create the table for Centers
CREATE TABLE Center (
    center_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Create the table for Rooms
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    center_id INT,
    capacity INT NOT NULL CHECK (capacity > 0),
    number INT NOT NULL,
    FOREIGN KEY (center_id) REFERENCES Center(center_id) ON DELETE CASCADE
);

-- Create the table for Sessions
CREATE TABLE Session (
    session_id INT PRIMARY KEY,
    session_date DATE NOT NULL,
    start_hour TIME NOT NULL,
    type VARCHAR(255) NOT NULL,
    room_id INT,
    center_id INT,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE SET NULL,
    FOREIGN KEY (center_id) REFERENCES Center(center_id) ON DELETE CASCADE
);

-- Create the table for Persons
CREATE TABLE Person (
    person_id INT PRIMARY KEY,
    birth_date DATE NOT NULL,
    family_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL
);

-- Create the table for Trainers
CREATE TABLE Trainer (
    trainer_id INT PRIMARY KEY,
    person_id INT,
    diploma VARCHAR(255),
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE
);
-- Create the table for Group Sessions
CREATE TABLE GroupSession (
    session_id INT PRIMARY KEY,
    trainer_id INT,
    type VARCHAR(255) NOT NULL,
    FOREIGN KEY (session_id) REFERENCES Session(session_id) ON DELETE CASCADE,
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id) ON DELETE SET NULL
);

-- Create the table for Individual Sessions
CREATE TABLE IndividualSession (
    session_id INT PRIMARY KEY,
    FOREIGN KEY (session_id) REFERENCES Session(session_id) ON DELETE CASCADE
);



-- Create the table for Participations
CREATE TABLE Participation (
    participation_id INT PRIMARY KEY,
    person_id INT,
    session_id INT,
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (session_id) REFERENCES Session(session_id) ON DELETE CASCADE
);

INSERT INTO Center (center_id, name, address) VALUES
(1, 'Downtown Fitness', '123 Main St, New York, NY'),
(2, 'Uptown Gym', '456 Elm St, Los Angeles, CA'),
(3, 'Midtown Health Club', '789 Oak St, Chicago, IL'),
(4, 'Eastside Wellness', '101 Maple St, Houston, TX'),
(5, 'Westside Sports Center', '202 Pine St, Phoenix, AZ'),
(6, 'Southside Gym', '303 Cedar St, Philadelphia, PA'),
(7, 'Northside Fitness', '404 Birch St, San Antonio, TX'),
(8, 'Central Fitness', '505 Walnut St, San Diego, CA'),
(9, 'City Gym', '606 Ash St, Dallas, TX'),
(10, 'Town Health Center', '707 Chestnut St, San Jose, CA'),
(11, 'Metro Fitness', '808 Spruce St, Austin, TX'),
(12, 'Urban Wellness', '909 Willow St, Jacksonville, FL'),
(13, 'Suburban Gym', '1010 Fir St, Fort Worth, TX'),
(14, 'Local Health Club', '1111 Poplar St, Columbus, OH'),
(15, 'Community Fitness', '1212 Sycamore St, Charlotte, NC'),
(16, 'Neighborhood Gym', '1313 Hickory St, San Francisco, CA'),
(17, 'Village Fitness', '1414 Cypress St, Indianapolis, IN'),
(18, 'Borough Gym', '1515 Redwood St, Seattle, WA'),
(19, 'City Wellness', '1616 Palm St, Denver, CO'),
(20, 'Town Sports Center', '1717 Magnolia St, Washington, DC'),
(21, 'Metro Gym', '1818 Dogwood St, Boston, MA'),
(22, 'Urban Health Club', '1919 Linden St, El Paso, TX'),
(23, 'Suburban Fitness', '2020 Elmwood St, Detroit, MI'),
(24, 'Local Gym', '2121 Hawthorn St, Nashville, TN'),
(25, 'Community Wellness', '2222 Pineapple St, Memphis, TN'),
(26, 'Neighborhood Health Club', '2323 Olive St, Portland, OR'),
(27, 'Village Wellness', '2424 Lemon St, Oklahoma City, OK'),
(28, 'Borough Fitness', '2525 Lime St, Las Vegas, NV'),
(29, 'City Health Club', '2626 Peach St, Louisville, KY'),
(30, 'Town Gym', '2727 Apricot St, Baltimore, MD');

INSERT INTO Rooms (room_id, center_id, capacity, number) VALUES
(1, 1, 20, 101),
(2, 1, 15, 102),
(3, 2, 25, 201),
(4, 2, 30, 202),
(5, 3, 20, 301),
(6, 3, 15, 302),
(7, 4, 25, 401),
(8, 4, 30, 402),
(9, 5, 20, 501),
(10, 5, 15, 502),
(11, 6, 25, 601),
(12, 6, 30, 602),
(13, 7, 20, 701),
(14, 7, 15, 702),
(15, 8, 25, 801),
(16, 8, 30, 802),
(17, 9, 20, 901),
(18, 9, 15, 902),
(19, 10, 25, 1001),
(20, 10, 30, 1002),
(21, 11, 20, 1101),
(22, 11, 15, 1102),
(23, 12, 25, 1201),
(24, 12, 30, 1202),
(25, 13, 20, 1301),
(26, 13, 15, 1302),
(27, 14, 25, 1401),
(28, 14, 30, 1402),
(29, 15, 20, 1501),
(30, 15, 15, 1502);


INSERT INTO Session (session_id, session_date, start_hour, type, room_id, center_id) VALUES
(1, '2024-07-01', '08:00:00', 'Yoga', 1, 1),
(2, '2024-07-02', '09:00:00', 'Pilates', 2, 1),
(3, '2024-07-03', '10:00:00', 'Spinning', 3, 2),
(4, '2024-07-04', '11:00:00', 'Zumba', 4, 2),
(5, '2024-07-05', '08:00:00', 'HIIT', 5, 3),
(6, '2024-07-06', '09:00:00', 'Strength Training', 6, 3),
(7, '2024-07-07', '10:00:00', 'Cardio', 7, 4),
(8, '2024-07-08', '11:00:00', 'Dance', 8, 4),
(9, '2024-07-09', '08:00:00', 'Boxing', 9, 5),
(10, '2024-07-10', '09:00:00', 'Kickboxing', 10, 5),
(11, '2024-07-11', '10:00:00', 'Yoga', 11, 6),
(12, '2024-07-12', '11:00:00', 'Pilates', 12, 6),
(13, '2024-07-13', '08:00:00', 'Spinning', 13, 7),
(14, '2024-07-14', '09:00:00', 'Zumba', 14, 7),
(15, '2024-07-15', '10:00:00', 'HIIT', 15, 8),
(16, '2024-07-16', '11:00:00', 'Strength Training', 16, 8),
(17, '2024-07-17', '08:00:00', 'Cardio', 17, 9),
(18, '2024-07-18', '09:00:00', 'Dance', 18, 9),
(19, '2024-07-19', '10:00:00', 'Boxing', 19, 10),
(20, '2024-07-20', '11:00:00', 'Kickboxing', 20, 10),
(21, '2024-07-21', '08:00:00', 'Yoga', 21, 11),
(22, '2024-07-22', '09:00:00', 'Pilates', 22, 11),
(23, '2024-07-23', '10:00:00', 'Spinning', 23, 12),
(24, '2024-07-24', '11:00:00', 'Zumba', 24, 12),
(25, '2024-07-25', '08:00:00', 'HIIT', 25, 13),
(26, '2024-07-26', '09:00:00', 'Strength Training', 26, 13),
(27, '2024-07-27', '10:00:00', 'Cardio', 27, 14),
(28, '2024-07-28', '11:00:00', 'Dance', 28, 14),
(29, '2024-07-29', '08:00:00', 'Boxing', 29, 15),
(30, '2024-07-30', '09:00:00', 'Kickboxing', 30, 15);


INSERT INTO Person (person_id, birth_date, family_name, first_name) VALUES
(1, '1985-05-15', 'Mcdowell', 'Jerri'),
(2, '1990-08-22', 'Sims', 'Esther'),
(3, '1988-11-03', 'Dixon', 'Tommie'),
(4, '1992-01-12', 'Terry', 'Jennie'),
(5, '1987-04-25', 'Mcdaniel', 'Joseph'),
(6, '1986-09-14', 'Curry', 'Denise'),
(7, '1984-03-19', 'White', 'Rolf'),
(8, '1991-07-07', 'Page', 'Bianca'),
(9, '1983-02-11', 'Villarreal', 'Ronda'),
(10, '1993-12-23', 'Bright', 'Troy'),
(11, '1989-06-05', 'Miranda', 'Kenya'),
(12, '1994-10-18', 'Foster', 'Briana'),
(13, '1982-12-29', 'Gordon', 'Vicente'),
(14, '1980-03-10', 'Mcguire', 'Deirdre'),
(15, '1995-11-22', 'Kim', 'Krista'),
(16, '1996-01-03', 'Bryant', 'Darrick'),
(17, '1981-05-16', 'Moreno', 'Catherine'),
(18, '1997-08-27', 'Richards', 'Dalton'),
(19, '1983-09-04', 'Choi', 'Sheri'),
(20, '1988-10-14', 'Simpson', 'Wes'),
(21, '1990-12-25', 'Bradford', 'Richie'),
(22, '1987-02-26', 'Mclean', 'Refugio'),
(23, '1991-05-07', 'Logan', 'Angelia'),
(24, '1985-08-17', 'Green', 'Tammi'),
(25, '1994-01-08', 'Cooley', 'Regina'),
(26, '1982-04-09', 'Banks', 'Curt'),
(27, '1989-07-30', 'Huff', 'Carmela'),
(28, '1984-02-20', 'Sawyer', 'Clare'),
(29, '1993-03-21', 'Zimmerman', 'Blake'),
(30, '1995-11-12', 'Chaney', 'Leona');


INSERT INTO Trainer (trainer_id, person_id, diploma) VALUES
(1, 1, 'Certified Personal Trainer'),
(2, 2, 'Certified Yoga Instructor'),
(3, 3, 'Certified Pilates Instructor'),
(4, 4, 'Certified Spin Instructor'),
(5, 5, 'Certified Zumba Instructor'),
(6, 6, 'Certified HIIT Trainer'),
(7, 7, 'Certified Strength Coach'),
(8, 8, 'Certified Cardio Trainer'),
(9, 9, 'Certified Dance Instructor'),
(10, 10, 'Certified Boxing Coach'),
(11, 11, 'Certified Kickboxing Instructor'),
(12, 12, 'Certified Yoga Instructor'),
(13, 13, 'Certified Pilates Instructor'),
(14, 14, 'Certified Spin Instructor'),
(15, 15, 'Certified Zumba Instructor'),
(16, 16, 'Certified HIIT Trainer'),
(17, 17, 'Certified Strength Coach'),
(18, 18, 'Certified Cardio Trainer'),
(19, 19, 'Certified Dance Instructor'),
(20, 20, 'Certified Boxing Coach'),
(21, 21, 'Certified Kickboxing Instructor'),
(22, 22, 'Certified Yoga Instructor'),
(23, 23, 'Certified Pilates Instructor'),
(24, 24, 'Certified Spin Instructor'),
(25, 25, 'Certified Zumba Instructor'),
(26, 26, 'Certified HIIT Trainer'),
(27, 27, 'Certified Strength Coach'),
(28, 28, 'Certified Cardio Trainer'),
(29, 29, 'Certified Dance Instructor'),
(30, 30, 'Certified Boxing Coach');

INSERT INTO Participation (participation_id, person_id, session_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20),
(21, 21, 21),
(22, 22, 22),
(23, 23, 23),
(24, 24, 24),
(25, 25, 25),
(26, 26, 26),
(27, 27, 27),
(28, 28, 28),
(29, 29, 29),
(30, 30, 30);


INSERT INTO GroupSession (session_id, trainer_id, type) VALUES
(1, 1, 'Yoga'),
(2, 2, 'Pilates'),
(3, 3, 'Spinning'),
(4, 4, 'Zumba'),
(5, 5, 'HIIT'),
(6, 6, 'Strength Training'),
(7, 7, 'Cardio'),
(8, 8, 'Dance'),
(9, 9, 'Boxing'),
(10, 10, 'Kickboxing'),
(11, 11, 'Yoga'),
(12, 12, 'Pilates'),
(13, 13, 'Spinning'),
(14, 14, 'Zumba'),
(15, 15, 'HIIT'),
(16, 16, 'Strength Training'),
(17, 17, 'Cardio'),
(18, 18, 'Dance'),
(19, 19, 'Boxing'),
(20, 20, 'Kickboxing'),
(21, 21, 'Yoga'),
(22, 22, 'Pilates'),
(23, 23, 'Spinning'),
(24, 24, 'Zumba'),
(25, 25, 'HIIT'),
(26, 26, 'Strength Training'),
(27, 27, 'Cardio'),
(28, 28, 'Dance'),
(29, 29, 'Boxing'),
(30, 30, 'Kickboxing');


INSERT INTO IndividualSession (session_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30);

INSERT INTO Session (session_id, session_date, start_hour, type, room_id, center_id) VALUES
(31, '2024-07-01', '08:00:00', 'Yoga', 1, 1),
(32, '2024-07-01', '09:00:00', 'Pilates', 2, 1),
(33, '2024-07-02', '10:00:00', 'Spinning', 3, 2),
(34, '2024-07-02', '11:00:00', 'Zumba', 4, 2),
(35, '2024-07-03', '08:00:00', 'HIIT', 5, 3),
(36, '2024-07-03', '09:00:00', 'Strength Training', 6, 3),
(37, '2024-07-04', '10:00:00', 'Cardio', 7, 4),
(38, '2024-07-04', '11:00:00', 'Dance', 8, 4),
(39, '2024-07-05', '08:00:00', 'Boxing', 9, 5),
(40, '2024-07-05', '09:00:00', 'Kickboxing', 10, 5),
(41, '2024-07-06', '08:00:00', 'Yoga', 1, 1),
(42, '2024-07-06', '09:00:00', 'Pilates', 2, 1),
(43, '2024-07-07', '10:00:00', 'Spinning', 3, 2),
(44, '2024-07-07', '11:00:00', 'Zumba', 4, 2),
(45, '2024-07-08', '08:00:00', 'HIIT', 5, 3),
(46, '2024-07-08', '09:00:00', 'Strength Training', 6, 3),
(47, '2024-07-09', '10:00:00', 'Cardio', 7, 4),
(48, '2024-07-09', '11:00:00', 'Dance', 8, 4),
(49, '2024-07-10', '08:00:00', 'Boxing', 9, 5),
(50, '2024-07-10', '09:00:00', 'Kickboxing', 10, 5);

INSERT INTO Participation (participation_id, person_id, session_id) VALUES
(31, 1, 31),
(32, 2, 32),
(33, 3, 33),
(34, 4, 34),
(35, 5, 35),
(36, 6, 36),
(37, 7, 37),
(38, 8, 38),
(39, 9, 39),
(40, 10, 40),
(41, 11, 41),
(42, 12, 42),
(43, 13, 43),
(44, 14, 44),
(45, 15, 45),
(46, 16, 46),
(47, 17, 47),
(48, 18, 48),
(49, 19, 49),
(50, 20, 50),
(51, 21, 31),
(52, 22, 32),
(53, 23, 33),
(54, 24, 34),
(55, 25, 35),
(56, 26, 36),
(57, 27, 37),
(58, 28, 38),
(59, 29, 39),
(60, 30, 40);

INSERT INTO GroupSession (session_id, trainer_id, type) VALUES
(31, 1, 'Yoga'),
(32, 2, 'Pilates'),
(33, 3, 'Spinning'),
(34, 4, 'Zumba'),
(35, 5, 'HIIT'),
(36, 6, 'Strength Training'),
(37, 7, 'Cardio'),
(38, 8, 'Dance'),
(39, 9, 'Boxing'),
(40, 10, 'Kickboxing'),
(41, 11, 'Yoga'),
(42, 12, 'Pilates'),
(43, 13, 'Spinning'),
(44, 14, 'Zumba'),
(45, 15, 'HIIT'),
(46, 16, 'Strength Training'),
(47, 17, 'Cardio'),
(48, 18, 'Dance'),
(49, 19, 'Boxing'),
(50, 20, 'Kickboxing');

INSERT INTO IndividualSession (session_id) VALUES
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50);

