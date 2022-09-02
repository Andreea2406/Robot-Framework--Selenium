import openpyxl
import xlsxwriter
import xlrd
workbook = xlsxwriter.Workbook('info.xlsx')
worksheet = workbook.add_worksheet()
worksheet.set_margins(left=1.2)
format1 = workbook.add_format({'border': 1,'bold': True})
worksheet.write('A1', 'Titlu Lucrare', format1)
format1.set_border_color('pink')
worksheet.write('B1', 'Linkuri', format1)
format1.set_border_color('pink')
worksheet.write('C1', 'Id articol', format1)
format1.set_border_color('pink')
worksheet.write('D1', 'DOI', format1)
format1.set_border_color('pink')
worksheet.write('E1', 'Data', format1)
format1.set_border_color('pink')
worksheet.write('F1', 'Citari', format1)
format1.set_border_color('pink')

j=1
def writelink(title,link,id,doi,date,citation):
    global j
    worksheet.write(j, 0, title)
    worksheet.write(j, 1, link)
    worksheet.write(j, 2, id)
    worksheet.write(j, 3, doi)
    worksheet.write(j, 4, date)
    worksheet.write(j, 5, citation)
    j = j + 1


def closing():
    workbook.close()

