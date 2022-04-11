import pandas as pd


def clean_data():
    data = pd.read_csv('bank_marketing_dataset.csv')

    # delete attributes that we don't need
    del_attri = ['contact', 'month', 'day_of_week', 'duration', 'campaign',
                 'pdays', 'nr.employed']
    for attri in del_attri:
        del data[attri]

    # replace unknown to NULL in these attributes
    for col in data.columns:
        data[col] = data[col].replace({'unknown': None})

    # replace nonexistent to NULL in this attributes
    data['poutcome'] = data['poutcome'].replace({'nonexistent': None})

    # create column ID
    data.index.name = 'ID'

    # make csv file for table Person, Outcome, Index, MaritalCredit
    outcome = data[['poutcome']]
    outcome.index.name = 'ID'
    # drop any row(s) with missing value(for column poutcome)
    outcome = outcome.dropna()

    # inner join the outcome and data with rows that do not have missing
    # value on poutcome
    selected_poutcome = pd.merge(data, outcome, left_index=True,
                                 right_index=True)

    person = selected_poutcome[['age', 'job', 'marital', 'education', 'default'
                                , 'housing', 'loan', 'previous']]
    person.index.name = 'ID'
    # drop any row(s) with all columns missing (if necessary)
    person = person.dropna(how='all')

    index = selected_poutcome[['emp.var.rate', 'cons.price.idx',
                               'cons.conf.idx', 'euribor3m', 'subscribed']]
    index.index.name = 'ID'
    # drop any row(s) with all columns missing (if necessary)
    index = index.dropna(how='all')

    maritalcredit = data[['marital', 'education', 'job', 'default']]
    maritalcredit.index.name = 'ID'
    # drop any row(s) with all columns missing (if necessary)
    maritalcredit = maritalcredit.dropna(how='all')

    # output files
    outcome.to_csv('outcome.csv')
    person.to_csv('person.csv')
    index.to_csv('index.csv')
    maritalcredit.to_csv('MaritalCredit.csv')


if __name__ == '__main__':
    clean_data()

