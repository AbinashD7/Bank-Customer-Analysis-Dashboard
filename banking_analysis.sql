use dap;

select * from banking;

# ---- 1.No of customer taken loan by age-group ----
select age_group, count(bank_loans) no_of_loan_customer from banking
where bank_loans <> 0
group by age_group
order by no_of_loan_customer desc;

# ---- 2.Avg income by nationality. Display nationality avg income >50000 -----
select nationality, round(avg(estimated_income), 2) avg_income from banking
group by nationality
having avg_income > 50000
order by avg_income desc;

# ----- 3.Top 10 customer by balance ----
select name, nationality, checking_accounts from banking
order by checking_accounts desc
limit 10;

# ----- 4.number of customers in each loyalty_classification who have more than 1 credit card -----
select loyalty_classification, count(*) total_customer from banking
where amount_of_credit_cards > 1
group by loyalty_classification;

# ----- 5.Nationality-wise Bank Balance -----
select nationality, round(sum(bank_deposits), 2) total_deposit, 
round(sum(checking_accounts), 2) total_balance, 
round(sum(saving_accounts), 2) total_saving from banking
group by nationality
order by total_deposit desc;

# ----- 6.Highest Loan Amount by Occupation -----
select occupation, name, bank_loans
from(select occupation, name,  bank_loans, 
row_number() over(partition by occupation
order by bank_loans desc) rn from banking) x
where rn = 1;

# ----- 7.High-Income Loan Customers ------
select name, estimated_income, bank_loans, nationality from banking
where estimated_income > (select avg(estimated_income) from banking) and
bank_loans > 0;

# ----- 8.Customers with High Financial Exposure -----
select name, bank_loans, business_lending, 
round(bank_loans + business_lending, 2) total_exposure from banking
where bank_loans + business_lending > 
(select avg(bank_loans + business_lending) from banking);

# ---- 9.Age Group with Highest Average Wealth -----
select age_group, round(avg(checking_accounts + saving_accounts + foreign_currency_account), 2) avg_balance
from banking
group by age_group
order by avg_balance desc;

# ---- 10.Top Customer in Each Nationality ------
select nationality, name, bank_deposits
from( select nationality, name, bank_deposits,
row_number() over(partition by nationality
order by bank_deposits desc) rn 
from banking) x
where rn = 1;

# ----- 11.Customers Whose Loans Are Higher Than Their Deposits -----
select name, bank_loans, bank_deposits, 
round(bank_loans - bank_deposits, 2) difference from banking
where bank_loans > bank_deposits;

# ----- 12.Loan Customers by Gender -----
select gender, count(*) total_customer from banking
where bank_loans > 0
group by gender
order by total_customer desc;

# ----- 13.Total customer by risk level -----
select risk_weighting, count(*) total_customer from banking
group by risk_weighting
order by total_customer desc;

# ---- 14. Total no of customer by fee strucure, avg income ----
select fee_structure, count(*) total_customer, round(avg(estimated_income), 2) avg_income from banking
group by fee_structure
order by avg_income desc;

# ---- 15.Customers Joined Each Year -----
select year(joined_date) year, count(*) total_customer from banking
group by year(joined_date)
order by total_customer desc;



