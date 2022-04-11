DROP SCHEMA IF EXISTS Bank CASCADE;
CREATE SCHEMA Bank;
SET SEARCH_PATH TO Bank;

CREATE DOMAIN MaritalType AS TEXT
        check (value in ('married', 'single', 'divorced'));

CREATE DOMAIN YesNo AS TEXT
        check(value in ('yes', 'no'));

CREATE DOMAIN OutcomeType AS TEXT
        check(value in ('success', 'failure'));

--a person's information about marital status and credit status.
--ID is a unique assigned person’s ID.
--marital is this person’s marital status.
--credit indicates whether this person has a credit or not.
CREATE TABLE MaritalCredit (
        ID INT,
        marital MaritalType,
        education TEXT,
        job TEXT,
        credit YesNo,
        PRIMARY KEY (ID)
);
--the outcome of the previous marketing campaign that this bank did for a certain person.
--ID is a unique assigned person's ID.
--poutcome is the outcome of the previous marketing campaign that this bank did for a certain person.

CREATE TABLE Outcome (
        ID INT,
        poutcome OutcomeType NOT NULL,
        PRIMARY KEY(ID)
);
-- a person that this bank is doing marketing campaigns to.
-- ID is a unique assigned person's ID, and age, job, education are obvious.
-- marital is this person's marital status.
-- credit indicates whether this person has credit or not.
-- housing indicates whether this person has a house loan, which can be either yes or no.
-- loan indicates whether this person has a personal loan.
-- pcontact is the number of times this bank contacted a certain person of the previous marketing campaign.
CREATE TABLE Person (
        ID INT,
        age INT,
        job TEXT,
        marital MaritalType,
        education TEXT,
        credit YesNo,
        housing YesNo,
        loan YesNo,
        pcontact INT,
        PRIMARY KEY (ID),
        FOREIGN KEY (ID) REFERENCES Outcome(ID),
        FOREIGN KEY (ID) REFERENCES MaritalCredit(ID)
);
--The social and economic context for a certain person that this bank is doing marketing campaigns.
--ID is a unique assigned person's ID.
--empVarRate is the employment variation rate, the variation of how many people are being hired or fired due to the shifts in the conditions of the economy, a quarterly indicator, for a certain person.
--CPI is the consumer price index, average change in prices over time that consumers pay for a basket of goods and services, a monthly indicator, for a certain person.
--CCI is the consumer confidence index, how optimistic consumers are regarding the bank, a monthly indicator, for a certain person.
--Euribor3m is the Euribor 3 month rate, the basis for the price and interest rates of all kinds of financial products, a daily indicator, for a certain person.
--subscribed denotes whether the person has a term deposit.
CREATE TABLE Index (
        ID INT,
        empVarRate FLOAT,
        CPI FLOAT,
        CCI FLOAT,
        Euribor3m FLOAT,
        subscribed YesNo,
        PRIMARY KEY (ID),
        FOREIGN KEY (ID) REFERENCES Outcome(ID)
);