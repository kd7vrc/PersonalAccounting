PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS "AcctType"
(
    "TypeID"        TINYINT     PRIMARY KEY AUTOINCREMENT,
    "AccountType"   VARCHAR(10) NOT NULL    UNIQUE,
    "MinAcctNum"    INT         NOT NULL,
    "MaxAcctNum"    INT         NOT NULL,
    "Debit"         TINYINT     NOT NULL CONSTRAINT ("Debit" IN (1,-1))
);


INSERT INTO "AcctType"
("AccountType","MinAcctNum","MaxAcctNum","Debit")
VALUES ("Asset",100,199,1);
INSERT INTO "AcctType"
("AccountType","MinAcctNum","MaxAcctNum","Debit")
VALUES ("Liability",200,299,-1);
INSERT INTO "AcctType"
("AccountType","MinAcctNum","MaxAcctNum","Debit")
VALUES ("Capital",300,399,-1);
INSERT INTO "AcctType"
("AccountType","MinAcctNum","MaxAcctNum","Debit")
VALUES ("Revenue",400,599,-1);
INSERT INTO "AcctType"
("AccountType","MinAcctNum","MaxAcctNum","Debit")
VALUES ("Expense",600,799,1);

CREATE TABLE IF NOT EXISTS "Account"
(
    "AcctID"        INT         PRIMARY KEY AUTOINCREMENT,
    "AcctType"      TINYINT     NOT NULL, --FK
    "AcctNum"       INT         NOT NULL,
    "AcctName"      VARCHAR(26) NOT NULL,
    "Description"   VARCHAR(64) NULL,
    FOREIGN KEY ("AcctType") REFERENCES "AcctType"
);

CREATE TABLE IF NOT EXISTS