# @manager.route('/querybook/', methods=['POST'])
# def querybook():
#     # 获取分页参数
#     page = int(request.args.get('page', 1))
#     per_page = int(request.args.get('per_page', 5))
#     print(page, per_page)
#     # 获取查询参数
#     name = request.args.get('name')
#     author = request.args.get('author')
#     version = request.args.get('version')
#     publish = request.args.get('publish')
#     ISBN = request.args.get('ISBN')
#
#     # 构建查询条件
#     conditions = []
#     if name:
#         conditions.append(BookTable.name.ilike(f'%{name}%'))
#     if author:
#         conditions.append(BookTable.author.ilike(f'%{author}%'))
#     if version:
#         conditions.append(BookTable.version.ilike(f'%{version}%'))
#     if publish:
#         conditions.append(BookTable.publish.ilike(f'%{publish}%'))
#     if ISBN:
#         conditions.append(BookTable.ISBN.ilike(f'%{ISBN}%'))
#
#     # 查询 BookTable 表格
#     booktables = BookTable.query.filter(and_(*conditions)).all()
#     print(booktables)
#     # 判断是否找到符合条件的书籍
#     if not booktables:
#         return jsonify({'code': 400, 'message': '没有找到符合条件的书籍'})
#
#     # 获取 ISBN 属性列表
#     booktable_ISBN_list = [booktable.ISBN for booktable in booktables]
#
#     # 根据 ISBN 查询 Book 表格
#     books = Book.query.filter(Book.ISBN.in_(booktable_ISBN_list)).paginate(page=page, per_page=per_page,
#                                                                            error_out=False)
#
#     # 构造响应数据
#     response = {
#         'code': 200,
#         'message': '查询成功',
#         'books': [
#             {
#                 'name': booktable.name,
#                 'ISBN': booktable.ISBN,
#                 'author': booktable.author,
#                 'version': booktable.version,
#                 'publish': booktable.publish,
#                 'num': booktable.num,
#                 'book': {
#                     'book_id': book.book_id,
#                     'location': book.location,
#                     'status': book.status
#                 } if book else None
#             } for booktable, book in zip(booktables, books.items)
#         ],
#         'total_count': books.total,
#         'page': books.page,
#         'per_page': books.per_page
#     }
#
#     return jsonify(response)