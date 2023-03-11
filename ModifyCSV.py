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
df = pd.read_csv('update_split.csv')

# convert 'College' column to string type
df['College'] = df['College'].astype(str)

# get unique values from 'College' column and sort them in alphabetical order
college_values = sorted(df['College'].unique())

# write unique values to new CSV file
pd.DataFrame(college_values, columns=['College']).to_csv('unique_colleges.csv', index=False)

print("Unique colleges written to 'unique_colleges1.csv'.")
"""

"""

import pandas as pd

# read 'update.csv' file into DataFrame
df = pd.read_csv('update.csv')

# split 'College' column into three columns at commas
college_split = df['College'].str.split(',', expand=True)

# rename the new columns
college_split.columns = ['College1', 'College2', 'College3','College4']

# fill missing values with 'NA'
college_split = college_split.fillna('NA')

# concatenate the original DataFrame and the new split columns
df = pd.concat([df, college_split], axis=1)

# drop the original 'College' column
df = df.drop('College', axis=1)

# save the updated DataFrame to a new CSV file
df.to_csv('update_split.csv', index=False)

print("Updated CSV file with split colleges saved as 'update_split.csv'.")


"""
"""
# Merge csv files
import pandas as pd

# read update.csv file into DataFrame
df_update = pd.read_csv('update_split.csv')

# read stadium.csv file into DataFrame
df_stadium = pd.read_csv('stadiums.csv')

# merge the two DataFrames based on the 'College' column
df_merged = pd.merge(df_update, df_stadium, on='College', how='outer')

# write the merged DataFrame to a new CSV file
df_merged.to_csv('merged.csv', index=False)

print("Merged data written to 'merged.csv'.")
"""
"""
import pandas as pd

# read in the csv file
df = pd.read_csv('GoodToPlayWithV4.csv')

# define a dictionary of state name abbreviations
state_abbrev = {
    'Alabama': 'AL', 'Alaska': 'AK', 'Arizona': 'AZ', 'Arkansas': 'AR',
    'California': 'CA', 'Colorado': 'CO', 'Connecticut': 'CT', 'Delaware': 'DE',
    'Florida': 'FL', 'Hawaii': 'HI', 'Idaho': 'ID',
    'Illinois': 'IL', 'Indiana': 'IN', 'Iowa': 'IA', 'Kansas': 'KS',
    'Kentucky': 'KY', 'Louisiana': 'LA', 'Maine': 'ME', 'Maryland': 'MD',
    'Massachusetts': 'MA', 'Michigan': 'MI', 'Minnesota': 'MN', 'Mississippi': 'MS',
    'Missouri': 'MO', 'Montana': 'MT', 'Nebraska': 'NE', 'Nevada': 'NV',
    'New Hampshire': 'NH', 'New Jersey': 'NJ', 'New Mexico': 'NM', 'New York': 'NY',
    'North Carolina': 'NC', 'North Dakota': 'ND', 'Ohio': 'OH', 'Oklahoma': 'OK',
    'Oregon': 'OR', 'Pennsylvania': 'PA', 'Rhode Island': 'RI', 'South Carolina': 'SC',
    'South Dakota': 'SD', 'Tennessee': 'TN', 'Texas': 'TX', 'Utah': 'UT',
    'Vermont': 'VT', 'Virginia': 'VA', 'Washington': 'WA', 'West Virginia': 'WV',
    'Wisconsin': 'WI', 'Wyoming': 'WY'
}

# define a function to replace state names with abbreviations
def replace_state_name(bp):
    if isinstance(bp, str):
        # loop over the state name abbreviations and replace any full state names with their abbreviations
        for state, abbrev in state_abbrev.items():
            if state in bp:
                bp = bp.replace(state, abbrev)
    return bp

# apply the replace_state_name function to the BirthPlace column
df['BirthPlace'] = df['BirthPlace'].apply(replace_state_name)

# write the updated dataframe to a new csv file
df.to_csv('GoodToPlayWithV5.csv', index=False)

"""
"""

import pandas as pd

# read in the csv file
df = pd.read_csv('GoodToPlayWith_updated.csv')

# define a function to replace " ," with ","
def replace_comma(bp):
    if isinstance(bp, str):
        return bp.replace(' ,', ',')
    else:
        return bp

# apply the replace_comma function to the BirthPlace column
df['BirthPlace'] = df['BirthPlace'].apply(replace_comma)

# write the updated dataframe to a new csv file
df.to_csv('GoodToPlayWith_BP.csv', index=False)
"""
"""
import pandas as pd

# read in the csv file
df = pd.read_csv('us_cities.csv')

# combine city and state columns with a comma separator
df['City_State'] = df['City'] + ', ' + df['State']

# write the updated dataframe to a new csv file
df.to_csv('us_citiesV2.csv', index=False)
"""
"""
import pandas as pd

# read in the GoodToPlayWithV5.csv file
df = pd.read_csv('GoodToPlayWithV5.csv')

# read in the us_citiesv2.csv file
cities_df = pd.read_csv('us_citiesv2.csv')

# create a set of city_state strings from the cities_df
city_state_set = set(cities_df['City_State'].str.lower())

# define a function to replace "Georgia" with "GA" in the BirthPlace column if it is present in the us_cities file
def replace_state(bp):
    if isinstance(bp, str) and 'georgia' in bp.lower():
        # check if the city_state string is in the set of city_state strings from the cities_df
        if bp.lower() in city_state_set:
            # replace "Georgia" with "GA"
            bp = bp.replace('Georgia', 'GA')
    return bp

# apply the replace_state function to the BirthPlace column
df['BirthPlace'] = df['BirthPlace'].apply(replace_state)

# write the updated dataframe to a new csv file
df.to_csv('GoodToPlayWithV6.csv', index=False)
"""
"""
import pandas as pd

# Load the CSV file into a Pandas DataFrame
df = pd.read_csv('GoodToPlayWithV6.csv')

# Replace instances of "Left" or "left" with "L"
df.loc[df['Handedness'].str.lower() == 'left', 'Handedness'] = 'L'

# Replace instances of "Right" or "right" with "R"
df.loc[df['Handedness'].str.lower() == 'right', 'Handedness'] = 'R'

# Save the modified DataFrame to a new CSV file
df.to_csv('GoodToPlayWithV7.csv', index=False)

"""
"""
import pandas as pd

# Load the V7 file into a Pandas DataFrame
v7_df = pd.read_csv('GoodToPlayWithV7.csv')

# Load the Us_citiesV2 file into a Pandas DataFrame
us_cities_df = pd.read_csv('Us_cities_updated.csv')

# Join the two DataFrames based on "BirthPlace" and "Metro_State" columns
merged_df = pd.merge(v7_df, us_cities_df, how='left', left_on='BirthPlace', right_on='City_State')

# Save the merged DataFrame to a new CSV file
merged_df.to_csv('GoodToPlayWithV8.csv', index=False)
"""
"""
import pandas as pd

# Load the Us_citiesv2 file into a Pandas DataFrame
us_cities_df = pd.read_csv('Us_citiesv2.csv')

# Merge the "Alias" and "Abbr" columns into a new column
us_cities_df['Alias_Abbr'] = us_cities_df['Alias'].str.cat(us_cities_df['Abbr.'].apply(lambda x: ', ' + x))

# Save the updated DataFrame to a new CSV file
us_cities_df.to_csv('Us_citiesv3.csv', index=False)
"""
"""
import pandas as pd

# Load the Us_citiesv3 file into a Pandas DataFrame
us_cities_df = pd.read_csv('Us_citiesv3.csv')

# Get a list of all the values that show up more than once in the "Alias_Abbr" column
duplicates = us_cities_df['Alias_Abbr'][us_cities_df['Alias_Abbr'].duplicated(keep=False)].tolist()

# Remove duplicates from the list
duplicates = list(set(duplicates))

# Get the number of individual cities that have duplicates
num_cities_with_duplicates = len(us_cities_df[us_cities_df['Alias_Abbr'].isin(duplicates)]['County'].unique())

# Get the total number of extra cells (duplicates)
total_duplicates = len(duplicates)

# Create an empty DataFrame to store the duplicates
duplicates_df = pd.DataFrame(columns=['County', 'Alias_Abbr'])

# Loop through each city that is a duplicate and add it to the duplicates DataFrame
for city in duplicates:
    duplicates_df = duplicates_df.append(us_cities_df[us_cities_df['Alias_Abbr'] == city][['County', 'Alias_Abbr']])

# Write the duplicates DataFrame to a new CSV file called "duplicates.csv"
duplicates_df.to_csv('duplicates.csv', index=False)

# Print the results
print(f'Number of cities with duplicates: {num_cities_with_duplicates}')
print(f'Total number of extra cells (duplicates): {total_duplicates}')
"""
"""
import pandas as pd

# Load the Us_citiesv3 file into a Pandas DataFrame
us_cities_df = pd.read_csv('Us_citiesv3.csv')

# Get a list of all the values that show up more than once in the "Alias_Abbr" column
duplicates = us_cities_df['Alias_Abbr'][us_cities_df['Alias_Abbr'].duplicated(keep=False)].tolist()

# Remove duplicates from the list
duplicates = list(set(duplicates))

# Get the rows that have a value in the "Alias_Abbr" column that is in the list of duplicates
duplicate_rows = us_cities_df[us_cities_df['Alias_Abbr'].isin(duplicates)].sort_values(by=['Alias_Abbr', 'County', 'City'])

# Write the duplicate rows to a new CSV file
duplicate_rows.to_csv('Duplicate_cities.csv', index=False)

# Get the number of individual cities that have duplicates
num_cities_with_duplicates = len(duplicate_rows['County'].unique())

# Get the total number of extra cells (duplicates)
total_duplicates = len(duplicate_rows)

# Print the results
print(f'Number of cities with duplicates: {num_cities_with_duplicates}')
print(f'Total number of extra cells (duplicates): {total_duplicates}')
"""
"""
import pandas as pd

# Read the Duplicate_cities file into a Pandas DataFrame
df = pd.read_csv('Duplicate_cities.csv')

# Get a list of all the values that show up more than once in the "Alias_Abbr" column
duplicates = df['Alias_Abbr'][df['Alias_Abbr'].duplicated(keep=False)].tolist()

# Remove duplicates from the list
duplicates = list(set(duplicates))

# Iterate over the rows in the DataFrame
rows_to_keep = []
for index, row in df.iterrows():
    if row['Alias_Abbr'] in duplicates:
        # Check if the "Alias_Abbr" value is a string
        if isinstance(row['Alias_Abbr'], str):
            # Split the "Alias_Abbr" value into city and state
            town, state = row['Alias_Abbr'].split(',')
            # Check if the city before the comma is found in the "City" value
            if town.strip() == row['City']:
                rows_to_keep.append(index)
        else:
            # Handle non-string values in the "Alias_Abbr" column
            print(f"Skipping row {index} with non-string Alias_Abbr value: {row['Alias_Abbr']}")

# Create a new DataFrame with the rows to keep
new_df = df.loc[rows_to_keep]

# Save the new DataFrame to a CSV file
new_df.to_csv('Duplicate_cities_filtered.csv', index=False)
"""
"""
import pandas as pd

# Load the CSV file
df = pd.read_csv('Duplicate_citiesV3.csv')

# Drop duplicates in the "Alias_Abbr" column, keeping only the first occurrence
df = df.drop_duplicates(subset=['Alias_Abbr'], keep='first')

# Save the updated dataframe to a new CSV file
df.to_csv('Duplicate_citiesV4.csv', index=False)
"""
"""
import csv

# Read the US_citiesV3 CSV into a dictionary
us_cities = {}
with open('Us_citiesV3.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        us_cities[row['Alias_Abbr']] = row

# Read the Duplicate_citiesV4 CSV into a dictionary
duplicate_cities = {}
with open('Duplicate_citiesV4.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        duplicate_cities[row['Alias_Abbr']] = row

# Update the entries in the US_cities dictionary with the corresponding entries from the duplicate_cities dictionary
for alias_abbr, duplicate_city in duplicate_cities.items():
    if alias_abbr in us_cities:
        us_cities[alias_abbr] = duplicate_city

# Write the updated US_cities dictionary to a new CSV file
with open('Us_citiesV4.csv', 'w', newline='') as f:
    fieldnames = ['City','Abbr.', 'County', 'Alias_Abbr']
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    for row in us_cities.values():
        writer.writerow(row)
"""
"""
import pandas as pd
import numpy as np

# Load data from CSV file
data = pd.read_csv("filename.csv")

# Replace NaN values with empty strings
data = data.fillna("")

# Convert BirthPlace column to lowercase
data["BirthPlace"] = data["BirthPlace"].str.lower()

# Check if each entry in BirthPlace is in Alias_Abbr column
mask = data["BirthPlace"].isin(us_cities["Alias_Abbr"])

# Get rows where BirthPlace is not in Alias_Abbr
not_in_cities = data[~mask]

# Loop through rows not in Alias_Abbr
for index, row in not_in_cities.iterrows():
    # Get closest match to BirthPlace from Alias_Abbr column
    closest_match = get_closest_match(row["BirthPlace"], us_cities["Alias_Abbr"])
    # Replace BirthPlace with closest match
    data.at[index, "BirthPlace"] = closest_match
"""
""" useful
import pandas as pd

# Load the csv file into a DataFrame
df = pd.read_csv('us_citiesv4.csv')

# Create a new column by concatenating 'city' and 'state_id' columns
df['City_State'] = df['City'] + ', ' + df['Abbr.']

# Save the updated DataFrame to a new csv file with a newer version
df.to_csv('us_citiesv5.csv', index=False)
"""
""" useful
import pandas as pd

# Load the two csv files into DataFrames
full_df = pd.read_csv('us_cities_fullV2.csv')
v5_df = pd.read_csv('us_citiesv5.csv')

# Rename the column 'city_state' to 'City_State' in the full_df
full_df = full_df.rename(columns={'city_state': 'City_State'})

# Join the two DataFrames based on the 'City_State' column
merged_df = pd.merge(v5_df, full_df[['City_State', 'town_lat','town_lng','population','density']], on='City_State', how='left')

# Save the merged DataFrame to a new csv file
merged_df.to_csv('us_cities_merged.csv', index=False)
"""

""" useful
import pandas as pd

# read in the v7 file and create a dictionary from us_cities_merged.csv
v7_df = pd.read_csv('goodtoplaywithv7.csv')
city_dict = pd.read_csv('us_cities_merged.csv').set_index('Alias_Abbr')['City_State'].to_dict()

# create a list to store the old and new values
old_new_values = []

# iterate through the BirthPlace column of the v7 dataframe
for i, birthplace in enumerate(v7_df['BirthPlace']):
    # check if the birthplace value is in the dictionary
    if birthplace in city_dict:
        # if there is a match, replace the value in the BirthPlace column with the corresponding City_State value
        old_value = birthplace
        new_value = city_dict[birthplace]
        v7_df.at[i, 'BirthPlace'] = new_value
        old_new_values.append((old_value, new_value))
        
# write the old and new values to a separate CSV file
with open('old_new_values.csv', 'w') as f:
    f.write('old_value,new_value\n')
    for old_value, new_value in old_new_values:
        f.write(f'{old_value},{new_value}\n')

# write the updated v7 dataframe to a new file
v7_df.to_csv('goooooood.csv', index=False)
"""
""" useful
import csv

# read the old new values from the CSV file
with open('old_new_values.csv', 'r') as f:
    reader = csv.reader(f)
    next(reader)  # skip the header row
    old_new_values = list(reader)

# check if the first and third columns have different values, and write an "x" to the sixth column if they do
for row in old_new_values:
    if row[0] != row[2]:
        row.append('x')
    else:
        row.append('')

# write the updated old new values to the same CSV file
with open('old_new_values.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['old_value', 'new_value', 'x'])
    writer.writerows(old_new_values)
"""
import pandas as pd
count = 0
# read in the v7 file and create a dictionary from us_cities_merged.csv
v7_df = pd.read_csv('goodtoplaywithv7.csv')
city_dict = pd.read_csv('us_cities_merged.csv').set_index('Alias_Abbr')['City_State'].to_dict()

# create a new dataframe to hold values that are not in the dictionary
not_found_df = pd.DataFrame(columns=['BirthPlace'])

# iterate through the BirthPlace column of the v7 dataframe
for i, birthplace in enumerate(v7_df['BirthPlace']):
    # check if the birthplace value is in the dictionary
    if birthplace in city_dict:
        # if there is a match, replace the value in the BirthPlace column with the corresponding City_State value
        v7_df.at[i, 'BirthPlace'] = city_dict[birthplace]
        count += 1
    else:
        # if there is no match, add the value to the not_found_df dataframe
        not_found_df = not_found_df.append({'BirthPlace': birthplace}, ignore_index=True)

# write the updated v7 dataframe and the not_found_df dataframe to separate CSV files
v7_df.to_csv('updated_v8.csv', index=False)
not_found_df.to_csv('not_found.csv', index=False)

print(count)
