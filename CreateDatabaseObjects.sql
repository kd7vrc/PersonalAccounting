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
    "AcctNum"       INT         NOT NULL UNIQUE,
    "AcctName"      VARCHAR(26) NOT NULL,
    "Description"   VARCHAR(64) NULL,
    FOREIGN KEY ("AcctType") REFERENCES "AcctType"("TypeID")
);

CREATE TABLE IF NOT EXISTS "SubAccount"
(
    "AcctID"    INT     NOT NULL,
    "SubID"     TINYINT NOT NULL,
    "AcctName"  VARCHAR(26) NOT NULL,
    PRIMARY KEY ("AcctID","SubID")
);

CREATE TABLE IF NOT EXISTS "GeneralLedger"
(
    "LedgerID"      BIGINT      PRIMARY KEY AUTOINCREMENT,
    "TransDate"     DATE        NOT NULL,
    "DayOrder"      INT         NOT NULL,
    "Committed"     BOOLEAN     NOT NULL,
    "Comment"       VARCHAR(128) NULL,
    "AuditTS"       DATETIME    NOT NULL,
    UNIQUE ("TransDate","DayOrder") ON CONFLICT FAIL
);

CREATE TABLE IF NOT EXISTS "TransactionLine"
(
    "LineID"    BIGINT          PRIMARY KEY AUTOINCREMENT,
    "LedgerID"  BIGINT          NOT NULL,
    "AcctID"    INT             NOT NULL,
    "SubID"     TINYINT         NULL,
    "Amt"       DECIMAL(11,2)   NOT NULL,
    FOREIGN KEY ("LedgerID") REFERENCES "GeneralLedger"("LedgerID"),
    FOREIGN KEY ("AcctID") REFERENCES "Account"("AcctID"),
    UNIQUE ("LedgerID","AcctID","SubID"),
    FOREIGN KEY ("AcctID","SubID") REFERENCES "SubAccount"("AcctID","SubID")
);