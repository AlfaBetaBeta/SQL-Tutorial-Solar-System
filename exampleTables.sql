-- Create Tables

CREATE TABLE ELEMENTS (
	ID SMALLINT NOT NULL PRIMARY KEY,
	NAME VARCHAR(12) NOT NULL);

CREATE TABLE STARPLANETS (
	NAME VARCHAR(10) NOT NULL PRIMARY KEY,
	MASS DECIMAL(10,4) NOT NULL,
	DISTTOSUN DECIMAL(4,2) NOT NULL,
	SIDEREALP DECIMAL(10,6) NOT NULL,
	ROTATIONP DECIMAL(11,8) NOT NULL,
	NUMSATELLITES SMALLINT NOT NULL);

CREATE TABLE SATELLITES (
	NAME VARCHAR(10) NOT NULL PRIMARY KEY,
	PLANETNAME VARCHAR(10) NOT NULL REFERENCES STARPLANETS (NAME),
	MASS DECIMAL(10,4));
/*
Note: the satellite mass is left as a nullable feature, as for distant satellites of
      small size this magnitude may be hard to measure reliably (e.g. Nereid orbiting around Neptune).
*/

CREATE TABLE PLANETELEMENTS (
	ID SMALLINT NOT NULL PRIMARY KEY,
	SPNAME VARCHAR(10) NOT NULL REFERENCES STARPLANETS (NAME),
	IDELEMENTS SMALLINT NOT NULL REFERENCES ELEMENTS (ID),
	ELEMENTRATIO DECIMAL(3,2) NOT NULL);


-- Populate tables with sample data (only illustrative!)

INSERT INTO ELEMENTS VALUES 
(1, 'HYDROGEN'),
(2, 'HELIUM'),
(6, 'CARBON'),
(7, 'NITROGEN'),
(8, 'OXYGEN'),
(10,'NEON'),
(14,'SILICON'),
(26,'IRON');

INSERT INTO STARPLANETS VALUES
('SUN', 333000, 0, 0, 24.47, 213),
('MERCURY', 0.0553, 0.39, 0.240846, 58.6462, 0),
('VENUS', 0.815, 0.72, 0.615, -243.0187, 0),
('EARTH', 1, 1, 1, 1, 1),
('MARS', 0.11, 1.52, 1.881, 1.025957, 2),
('JUPITER', 317.8, 5.20, 11.86, 0.41007, 79),
('SATURN', 95.2, 9.54, 29.46, 0.426, 82),
('URANUS', 14.6, 19.18, 84.01, -0.71833, 27),
('NEPTUNE', 17.2, 30.06, 164.8, 0.67125, 14);

INSERT INTO SATELLITES VALUES
('MOON ', 'EARTH ', 73.46),
('PHOBOS ', 'MARS ', 0.0001),
('DEIMOS ', 'MARS ', 0.0001),
('IO ', 'JUPITER ', 89.3),
('EUROPA ', 'JUPITER ', 48),
('GANYMEDE', 'JUPITER ', 148),
('CALISTO ', 'JUPITER ', 108),
('TITAN ', 'SATURN ', 135),
('IAPETUS', 'SATURN', 1.806),
('DIONE', 'SATURN', 1.095),
('TITANIA', 'URANUS', 3.52),
('OBERON', 'URANUS', 3.01),
('ARIEL', 'URANUS', 1.25),
('UMBRIEL', 'URANUS', 1.28),
('TRITON', 'NEPTUNE', 21.4),
('NEREID', 'NEPTUNE', NULL),
('GALATEA', 'NEPTUNE', 0.0021);

INSERT INTO PLANETELEMENTS VALUES
(1, 'SUN', 1, 0.7),
(2, 'SUN', 2, 0.3),
(3, 'MERCURY', 14, 0.5),
(4, 'MERCURY', 26, 0.5),
(5, 'VENUS', 6, 0.3),
(6, 'VENUS', 8, 0.6),
(7, 'VENUS', 7, 0.1),
(8, 'EARTH', 8, 0.47),
(9, 'EARTH', 14, 0.30),
(10, 'EARTH', 26, 0.23),
(11, 'MARS', 14, 0.35),
(12, 'MARS', 8, 0.2),
(13, 'MARS', 26, 0.45),
(14, 'JUPITER', 1, 0.75),
(15, 'JUPITER', 2, 0.25),
(16, 'SATURN', 1, 0.75),
(17, 'SATURN', 2, 0.25),
(18, 'URANUS', 1, 0.83),
(19, 'URANUS', 2, 0.15),
(20, 'URANUS', 7, 0.02),
(21, 'NEPTUNE', 1, 0.8),
(22, 'NEPTUNE', 2, 0.2);