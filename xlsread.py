import xlrd3

wb = xlrd3.open_workbook('resources/salaries.xlsx')
sheet_names = wb.sheet_names()
sh = wb.sheet_by_name(sheet_names[0])

number_of_columns = sh.ncols
number_of_rows = sh.nrows
jobs = sh.row_values(0)[1:]
regions = sh.col_values(0)[1:]
medians = []
for i in range(1, number_of_rows):
    list_of_salaries_by_region = []
    for j in range(1, number_of_columns):
        list_of_salaries_by_region.append(sh.row_values(i)[j])
    medians.append(sorted(list_of_salaries_by_region)[int((number_of_columns - 1) / 2)])

average_salaries = []
for i in range(1, number_of_columns):
    salary_to_append = 0
    for j in range(1, number_of_rows):
        salary_to_append += sh.row_values(j)[i]
    average_salaries.append(salary_to_append / number_of_rows - 1)

index_of_max_salary = average_salaries.index(max(average_salaries))

index_of_max = medians.index(max(medians))
print(f"Best region is: {regions[index_of_max]}")
print(f"Best job is: {jobs[index_of_max_salary]}")
print(regions[index_of_max] + " " + jobs[index_of_max_salary])
