"""
import pandas as pd
import difflib

# read the original CSV file into a DataFrame
df = pd.read_csv('update.csv')

# get a list of unique college names (excluding NaN and None values)
college_list = df['College'].dropna().unique().tolist()

# read the stadiums-geocoded CSV file into a DataFrame
stadiums_df = pd.read_csv('stadiums-geocoded.csv')

# iterate over rows in the stadiums-geocoded DataFrame
for i, row in stadiums_df.iterrows():
    # check if team name is similar to any unique college name
    matches = difflib.get_close_matches(row['team'], college_list, n=1, cutoff=0.5)
    if matches:
        # replace team name with closest match
        stadiums_df.at[i, 'team'] = matches[0]

# write updated stadiums-geocoded DataFrame to CSV file
stadiums_df.to_csv('updated-stadiums-geocoded.csv', index=False)
"""
"""
import pandas as pd

# read the original stadiums-geocoded CSV file into a DataFrame
old_df = pd.read_csv('stadiums-geocoded.csv')

# read the updated stadiums-geocoded CSV file into another DataFrame
new_df = pd.read_csv('updated-stadiums-geocoded.csv')

# find the differences between the two DataFrames
diff = pd.concat([old_df, new_df]).drop_duplicates(keep=False)

# print the rows with differences
print(diff)
"""

"""
## Unique CSV

import pandas as pd

# read CSV file into DataFrame
df = pd.read_csv('update.csv')

# convert 'College' column to string type
df['College'] = df['College'].astype(str)

# get unique values from 'College' column and sort them in alphabetical order
college_values = sorted(df['College'].unique())

# write unique values to new CSV file
pd.DataFrame(college_values, columns=['College']).to_csv('unique_colleges.csv', index=False)

print("Unique colleges written to 'unique_colleges.csv'.")
"""
import pandas as pd

# read update.csv file into DataFrame
df_update = pd.read_csv('update.csv')

# read stadium.csv file into DataFrame
df_stadium = pd.read_csv('stadiums.csv')

# merge the two DataFrames based on the 'College' column
df_merged = pd.merge(df_update, df_stadium, on='college_name', how='inner')

# write the merged DataFrame to a new CSV file
df_merged.to_csv('merged.csv', index=False)

print("Merged data written to 'merged.csv'.")


