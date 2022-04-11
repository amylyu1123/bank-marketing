DROP SCHEMA IF EXISTS Data CASCADE;
CREATE SCHEMA Data;
SET SEARCH_PATH TO Data;

CREATE TABLE AllData (
        age INT,
        job TEXT,
        marital TEXT,
        education TEXT,
        credit TEXT,
        housing TEXT,
        loan TEXT,
        pcontact TEXT,
        month TEXT,
        dayofweek TEXT,
        duration INT,
        campaign INT,
        pdays INT,
        previous INT,
        poutcome TEXT,
        empVarRate FLOAT,
        CPI FLOAT,
        CCI FLOAT,
        Euribor3m FLOAT,
        nrEmployed FLOAT,
        subscribed TEXT
);
