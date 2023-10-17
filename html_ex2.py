
start_part = "<html><body><table>"

for i in range(1,11):
    start_part += "<tr>"
    for j in range(1,11):
        start_part += "<td>" +  f"<a href=http://{i*j}.ru>" + str(i*j) + "</a>" + "</td>"
    start_part += "</tr>"

start_part += "</table></body></html>"

with open ("./resources/mult_table.html", "w") as file:
    print(start_part, file=file)
