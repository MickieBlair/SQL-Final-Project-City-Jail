CREATE TABLE aliases
     (alias_ID NUMBER(6),
     criminal_ID NUMBER (6,0),
     alias VARCHAR2 (10));
	 
CREATE TABLE criminals
     (criminal_ID NUMBER (6,0),
     last VARCHAR2(15),
     first VARCHAR2(10),
     street VARCHAR2(30),
     city VARCHAR2(20),
     state CHAR(2),
     zip CHAR(5),
     phone CHAR(10),
     V_status CHAR (1) DEFAULT 'N',
     P_status CHAR (1) DEFAULT 'N');
	 
CREATE TABLE crimes
     (crime_ID NUMBER (9,0),
     criminal_ID NUMBER (6,0),
     classification CHAR (1),
     date_charged DATE,
     status CHAR (2),
     hearing_date DATE,
     appeal_cut_date DATE);
	 
CREATE TABLE sentences
     (sentence_ID NUMBER (6),
      criminal_ID NUMBER (6),
      type CHAR (1),
      prob_ID NUMBER (5),
      start_date DATE,
      end_date DATE,
      violations NUMBER (3));
	  
CREATE TABLE prob_officers
      (prob_id NUMBER (5),
      last VARCHAR2(15),
      first VARCHAR2(10),
      street VARCHAR2(30),
      city VARCHAR2(20),
      state CHAR(2),
      zip CHAR(5),
      phone CHAR(10),
      email VARCHAR(30),
      status CHAR(1) DEFAULT 'A');
	  
CREATE TABLE crime_charges
      (charge_id NUMBER (10,0),
      crime_ID NUMBER (9,0),
      crime_code NUMBER (3,0),
      charge_status CHAR (2),
      fine_amount NUMBER (7,2),
      court_fee NUMBER (7,2),
      amount_paid NUMBER (7,2),
      pay_due_date DATE);
	  
CREATE TABLE crime_officers
      (crime_ID NUMBER (9,0),
      officer_ID NUMBER (8,0));
	  
CREATE TABLE officers
      (officer_ID NUMBER (8,0),
      last VARCHAR2(15),
      first VARCHAR2(10),
      precinct CHAR (4),
      badge VARCHAR2 (14),
      phone CHAR (10),
      status CHAR(1) DEFAULT 'A');
	  
CREATE TABLE appeals
      (appeal_ID NUMBER (5),
      crime_ID NUMBER (9,0),
      filing_date DATE,
      hearing_date DATE,
      status CHAR(1) DEFAULT 'P');
	  
CREATE TABLE crime_codes
      (crime_code NUMBER (3,0),
      code_description VARCHAR2 (30));
	  
ALTER TABLE crimes
     MODIFY (classification DEFAULT 'U');
	 
ALTER TABLE crimes
     ADD (date_recorded DATE DEFAULT SYSDATE);
	 
ALTER TABLE prob_officers
     ADD (pager# CHAR (10));
	  
ALTER TABLE aliases
     MODIFY (alias VARCHAR2 (20));

Part 3
	 
DROP TABLE appeals;
	
DROP TABLE crime_officers;
	
DROP TABLE crime_charges;
	
ALTER TABLE aliases
	ADD CONSTRAINT aliases_alias_id_pk PRIMARY KEY (alias_ID);

ALTER TABLE criminals
   ADD CONSTRAINT criminals_criminal_id_pk PRIMARY KEY (criminal_ID);

 ALTER TABLE crimes
   ADD CONSTRAINT crimes_crime_id_pk PRIMARY KEY (crime_ID);

ALTER TABLE officers
   ADD CONSTRAINT officers_officer_id_pk PRIMARY KEY (officer_ID); 

ALTER TABLE sentences
   ADD CONSTRAINT sentences_sentence_id_pk PRIMARY KEY (sentence_ID);

ALTER TABLE prob_officers
   ADD CONSTRAINT prob_officers_prob_id_pk PRIMARY KEY (prob_ID);

ALTER TABLE crime_codes
   ADD CONSTRAINT crime_codes_crime_code_pk PRIMARY KEY (crime_code);

ALTER TABLE aliases
	ADD CONSTRAINT aliases_criminal_id_fk FOREIGN KEY (criminal_ID)
        REFERENCES criminals (criminal_ID);
		
ALTER TABLE crimes
	ADD CONSTRAINT crimes_criminal_id_fk FOREIGN KEY (criminal_ID)
        REFERENCES criminals (criminal_ID);
		
ALTER TABLE sentences
	ADD CONSTRAINT sentences_criminal_id_fk FOREIGN KEY (criminal_ID)
        REFERENCES criminals (criminal_ID);
		
ALTER TABLE sentences
	ADD CONSTRAINT sentences_prob_id_fk FOREIGN KEY (prob_ID)
        REFERENCES prob_officers (prob_ID);
		
ALTER TABLE criminals
   ADD CONSTRAINT criminals_V_status_ck CHECK (V_status IN ('Y', 'N'));
   
ALTER TABLE criminals
   ADD CONSTRAINT criminals_P_status_ck CHECK (P_status IN ('Y', 'N'));
   
ALTER TABLE crimes
   ADD CONSTRAINT crimes_classification_ck CHECK (classification IN ('F', 'M', 'O', 'U'));
   
ALTER TABLE crimes
   ADD CONSTRAINT crimes_status_ck CHECK (status IN ('CL', 'CA', 'IA'));
   
ALTER TABLE sentences
   ADD CONSTRAINT sentences_type_ck CHECK (type IN ('J', 'H', 'P'));
   
ALTER TABLE prob_officers
   ADD CONSTRAINT prob_officers_status_ck CHECK (status IN ('A', 'I'));
   
ALTER TABLE officers
   ADD CONSTRAINT officers_status_ck CHECK (status IN ('A', 'I'));
   
CREATE TABLE appeals
      (appeal_ID NUMBER (5),
      crime_ID NUMBER (9,0),
      filing_date DATE,
      hearing_date DATE,
      status CHAR(1) DEFAULT 'P',
      CONSTRAINT appeals_appeals_ID_pk PRIMARY KEY (appeal_ID),
      CONSTRAINT appeals_crime_ID_fk FOREIGN KEY (crime_ID)
        REFERENCES crimes (crime_ID),
      CONSTRAINT appeals_status CHECK (status IN ('P', 'A', 'D')));
	  
CREATE TABLE crime_officers
      (crime_ID NUMBER (9,0),
      officer_ID NUMBER (8,0),
      CONSTRAINT crime_officers_crime_ID_fk FOREIGN KEY (crime_ID)
         REFERENCES crimes (crime_ID),
      CONSTRAINT crime_officers_officer_ID_fk FOREIGN KEY (officer_ID)
         REFERENCES officers (officer_ID));
		 
CREATE TABLE crime_charges
      (charge_id NUMBER (10,0),
      crime_ID NUMBER (9,0),
      crime_code NUMBER (3,0),
      charge_status CHAR (2),
      fine_amount NUMBER (7,2),
      court_fee NUMBER (7,2),
      amount_paid NUMBER (7,2),
      pay_due_date DATE,
      CONSTRAINT crime_charges_charge_ID_pk PRIMARY KEY (charge_ID),
      CONSTRAINT crime_charges_crime_ID_fk FOREIGN KEY (crime_ID)
           REFERENCES crimes (crime_ID),
      CONSTRAINT crime_charges_crime_code_fk FOREIGN KEY (crime_code)
           REFERENCES crime_codes (crime_code),
      CONSTRAINT crime_codes_charge_status_ck CHECK (charge_status IN ('PD', 'GL', 'NG'))); 
	  
Part 4

INSERT INTO criminals 
	VALUES ('&criminal_ID', '&last', '&first', '&street', '&city','&state','&zip', '&phone', '&V_status', '&P_status');

INSERT INTO criminals (criminal_ID, last, first, city, state, zip)
     VALUES (1015,'Fenter', 'Jim', 'Chesapeake', 'VA', 23320);

INSERT INTO criminals (criminal_ID, last, first, street, city, state, zip, phone)
    VALUES (1016,'Saunder', 'Bill', '11 Apple Rd', 'Virginia Beach', 'VA',23455,7678217443); 
	
INSERT INTO criminals (criminal_ID, last, first, street, city, state, zip, phone)
     VALUES (1017,'Painter', 'Troy', '77 Ship Lane', 'Norfolk', 'VA', 22093,7677655454);

ALTER TABLE criminals
	ADD (mail_flag CHAR(1));

UPDATE criminals
	SET mail_flag='Y';

UPDATE criminals
	SET mail_flag='N'
	WHERE street IS NULL;

UPDATE criminals
	SET phone='7225659032'
	WHERE criminal_ID=1016;

DELETE FROM criminals
	WHERE criminal_ID=1017;
		

   
 

	
	
	
	





































