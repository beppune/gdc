
DROP TABLE IF EXISTS persons;
CREATE TABLE persons(
	id			BIGINT UNSIGNED NOT NULL,
    first_name	VARCHAR(100) NOT NULL,
    last_name	VARCHAR(100) NOT NULL,
    
    cf			TEXT NULL,
    birth_date	DATE NULL,
    
    PRIMARY KEY(id)
);
DELIMITER //
CREATE TRIGGER generate_person_id_trigger BEFORE INSERT ON persons
	FOR EACH ROW
    BEGIN
		SET NEW.id = UUID_SHORT();
        SET @last_person_uuid = NEW.id;
	END//
    
DELIMITER ;

DROP TABLE IF EXISTS dcs;
CREATE TABLE dcs(
	short_name		CHAR(4) NOT NULL,
    full_name		VARCHAR(100) NOT NULL,
    
    requests_box	VARCHAR(256) NOT NULL,
    
    PRIMARY KEY(short_name)
);

DROP TABLE IF EXISTS id_papers;
CREATE TABLE id_papers(
	number		VARCHAR(255) NOT NULL,
    type		ENUM( 'CI', 'PASS', 'PA', 'PU' ) NOT NULL,
    expires		DATE NULL,
    
    person		BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY(NUMBER),
    FOREIGN KEY (person) REFERENCES persons(id)
);

DROP TABLE IF EXISTS operators;
CREATE TABLE operators(
	id			BIGINT UNSIGNED NOT NULL,
    username	VARCHAR(8) NOT NULL UNIQUE,
    email		VARCHAR(256) NOT NULL UNIQUE,
    dep			VARCHAR(100) NOT NULL,
    password	VARCHAR(256) NULL,
    
    PRIMARY KEY(id),
    UNIQUE(id, dep),
    FOREIGN KEY (id) REFERENCES persons(id)
);

DROP TABLE IF EXISTS locations;
CREATE TABLE locations(
	dc		CHAR(4) NOT NULL,
    name	VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (dc,name),
    FOREIGN KEY (dc) REFERENCES dcs(short_name)
);

DROP TABLE IF EXISTS permissions;
CREATE TABLE permissions(
	operator	BIGINT UNSIGNED NOT NULL,
    dc			CHAR(4) NOT NULL,
    
    permission	ENUM( 'READ', 'WRITE', 'ADMIN' ) NOT NULL,
    
    PRIMARY KEY (operator,dc),
    FOREIGN KEY (operator) REFERENCES operators(id),
    FOREIGN KEY (dc) REFERENCES dcs(short_name)
);

DROP TABLE IF EXISTS requests;
CREATE TABLE requests(
	id				BIGINT UNSIGNED NOT NULL,
	
    description		VARCHAR(1000) NOT NULL,
    
    dc				CHAR(4) NOT NULL,
    
    star_date		DATE NOT NULL,
    end_date		DATE NOT NULL,
    
    start_time		TIME NOT NULL,
    end_time		TIME NOT NULL,
    
    owner			BIGINT UNSIGNED NOT NULL,
    
    dep				VARCHAR(100) NOT NULL,
    
    locations		VARCHAR(200) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (dc) REFERENCES dcs(short_name),
    FOREIGN KEY (owner,dep) REFERENCES operators(id,dep)
    
);
CREATE TRIGGER generate_request_id_trigger BEFORE INSERT ON requests
	FOR EACH ROW SET NEW.id = UUID_SHORT();

DROP TABLE IF EXISTS visits;
CREATE TABLE visits(
	visitor			BIGINT UNSIGNED NOT NULL,
    visitor_paper	VARCHAR(256) NOT NULL,
    
    request			BIGINT UNSIGNED NOT NULL,
    
    badge			VARCHAR(100) NOT NULL,
    
    -- OVERRIDE
    star_date		DATE NOT NULL,
    end_date		DATE NOT NULL,
    
    start_time		TIME NOT NULL,
    end_time		TIME NOT NULL,
    
    locations		VARCHAR(200) NULL,
    
    PRIMARY KEY (visitor,request),
    FOREIGN KEY (visitor) REFERENCES persons(id),
    FOREIGN KEY (request) REFERENCES requests(id),
    FOREIGN KEY (visitor,visitor_paper) REFERENCES id_papers(person,number)
);

DROP VIEW IF EXISTS papers_persons;    
CREATE VIEW papers_persons AS
	SELECT type,number,last_name,first_name
	FROM id_papers JOIN persons ON(id_papers.person = persons.id);




