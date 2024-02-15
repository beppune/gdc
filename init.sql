
INSERT INTO dcs(short_name,full_name,requests_box) VALUES ('TO1','TORINO','TO1Datacenter@posteitaliane.it'), ('RM2','ROMA EUR','RM2Datacenter@posteitaliane.it');

INSERT INTO persons(first_name,last_name) VALUES	('ENNIO', 'ANNIO');
INSERT INTO id_papers(number, type, person) VALUES('ABCD1', 'CI', @last_person_uuid);

INSERT INTO persons(first_name,last_name) VALUES ('ROSSI', 'MARIO');
INSERT INTO id_papers(number, type, person) VALUES('ABCD2', 'CI', @last_person_uuid);

INSERT INTO persons(first_name,last_name) VALUES ('UNO','OPERATORE');
INSERT INTO id_papers(number, type, person) VALUES('ABFDASF3', 'PA', @last_person_uuid);
INSERT INTO operators(id, username, email, dep) VALUES(@last_person_uuid, 'MANZOGI9', 'MANZOGI9@posteitaliane.it', 'IMDC');
-- INSERT INTO permissions(operator, dc, permission) VALUES(@last_person_uuid, 'TO1', 
    
INSERT INTO persons(first_name,last_name) VALUES ('DUE', 'RICHIEDENTE');
INSERT INTO id_papers(number, type, person) VALUES('QBVFSDNO', 'CI', @last_person_uuid);
    
INSERT INTO persons(first_name,last_name) VALUES ('TRE', 'ADMIN');
INSERT INTO id_papers(number, type, person) VALUES('WEGFASB', 'PA', @last_person_uuid); 

INSERT INTO locations(dc, name) VALUES
	('TO1', 'SALA 1'),
    ('TO1', 'SALA 2'),
    ('TO1', 'CARRIER A'),
    ('TO1', 'CARRIER B'),
    ('TO1', 'MAGAZZINO');
    
INSERT INTO locations(dc, name) VALUES
	('RM2', 'HH2'),
    ('RM2', 'HH1');
    