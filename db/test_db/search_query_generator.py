"""
SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title
FROM pdf, account, category
WHERE pdf.title LIKE '%Curiosidades%' AND pdf.summary LIKE '%Lee%' AND pdf.cont_18 = false 
AND pdf.category_id = category.category_id AND category.title = 'arte' 
AND account.account_id = pdf.account_id AND account.username = 'diego'
"""

def search_query_generator(title = None, summary = None, cont_18 = None, category_title = None, username = None):
    if title == None and summary == None and cont_18 == None and category_title == None and username == None:
        return 
    query = "SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title FROM pdf, account, category WHERE "
    if title != None:
        query += f"pdf.title LIKE '%{title}% AND "
    if summary != None:
        query += f"pdf.summary LIKE '%{summary}%' AND "
    if cont_18 != None:
        query += f"pdf.cont_18 LIKE '%{cont_18}%' AND "
    if category_title != None:
        query += f"category.title LIKE '%{category_title}%' AND "
    if username != None:
        query += f"account.username LIKE '%{username}%'"
    if query[-4:] == "AND ":
        name = query[:-4]
        query = name
    return query


print(search_query_generator("Titulo de Prueba","arte"))
print(search_query_generator(username = "pedro"))