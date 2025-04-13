import pyodbc
con_str = "DRIVER={SQL SERVER};SERVER=DESKTOP-V8BP0HD;DATABASE=homework;Trusted_Connection=yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()
cursor.execute("""
SELECT * FROM photos;
""")
row = cursor.fetchone()
id, img_shape = row
with open(f'name.png', 'wb') as f:
    f.write(img_shape)