
# Базовая информация о данных
call GET_USERS()
call GET_USERS_IN_ROOM(1)
call GET_USER(15)
call GET_ROOMS(15)
call GET_ROOM(1)
call GET_TASKS(1)
call GET_TASKS_PROGRESS(1)
call GET_GROUPS(1)
call GET_ACTIVITIES(1)
call GET_COMMENTS(5)

# Работа с пользователем
call ADD_USER('anna', 'password', NULL)
call GET_USERS()
call UPDATE_USER_PASSWORD(21, 'new password')
call UPDATE_USER_PHOTO(21, 'www.example.com/photos/photo-1.jpg')
call GET_USER(21)

# Добавление пользователя в комнату
call ADD_USER_ROOM(21, 1)
call GET_USERS_IN_ROOM(1)

# Удаление пользователя из комнату
call REMOVE_USER_ROOM(21, 1)
call GET_USERS_IN_ROOM(1)

# Добавление пользователя в комнату
call ADD_USER_ROOM(21, 1)
call GET_USERS_IN_ROOM(1)

# Добавление групп
call GET_GROUPS(1)
call ADD_GROUP(1, 21, 'Group', '#000111', '#111000')
call ADD_GROUP(1, 21, 'Group2', '#111000', '#000111')
call GET_GROUPS(1)
call GET_TASKS_PROGRESS(1)
call GET_ACTIVITIES(1)

# Изменение названия группы
call UPDATE_GROUP_NAME(16, 'Another name')
call GET_GROUPS(1)
call GET_ACTIVITIES(1)

# Изменение вторичного цвета группы
call UPDATE_GROUP_SECONDARY_COLOR(16, '#111111')
call GET_GROUPS(1)
call GET_ACTIVITIES(1)

# Изменение основного цвета группы
call UPDATE_GROUP_MAIN_COLOR(16, '#000000')
call GET_GROUPS(1)
call GET_ACTIVITIES(1)

# Добавление задачи
call ADD_TASK(1, 16, 21, 'To do something', 'READY')
call ADD_TASK(1, 16, 21, 'To do something', 'READY')
call GET_TASKS_PROGRESS(1)
call GET_TASK(1, 51)
call GET_ACTIVITIES(1)

# Изменение статуса задачи
call UPDATE_TASK_STATUS(51, 'DONE')
call GET_TASKS_PROGRESS(1)
call GET_TASK(1, 51)
call GET_ACTIVITIES(1)

# Изменение контента задачи
call UPDATE_TASK_CONTENT(51, 'Rework sth')
call GET_TASK(1, 51)
call GET_ACTIVITIES(1)

# Изменение группы задачи
call UPDATE_TASK_GROUP(51, 17)
call GET_TASKS_PROGRESS(1)
call GET_TASK(1, 51)
call GET_ACTIVITIES(1)

# Удаление задачи
call REMOVE_TASK(51)
call GET_TASKS_PROGRESS(1)
call GET_TASKS(1)
call GET_ACTIVITIES(1)

# Удаление группы
call REMOVE_GROUP(17)
call GET_GROUPS(1)
call GET_ACTIVITIES(1)
call GET_TASKS_PROGRESS(1)

# Добавление комментария
call GET_COMMENTS(52)
call ADD_COMMENT(52,21, 'Boring task')
call ADD_COMMENT(52,21, 'Boring task 2')
call GET_COMMENTS(52)
call GET_ACTIVITIES(1)

# Изменение содержания комментария
call UPDATE_COMMENT_CONTENT(100, 'Very boring task')
call GET_COMMENTS(52)
call GET_ACTIVITIES(1)

# Удаление комментария
call REMOVE_COMMENT(100)
call GET_COMMENTS(52)
call GET_ACTIVITIES(1)

# Каскадное удаление группы, задачи, комментария
call REMOVE_GROUP(16)
call GET_TASK(1, 52)
call GET_COMMENTS(52)
call GET_ACTIVITIES(1)
call GET_TASKS_PROGRESS(1)

# Каскадное удаление содержимого комнаты
call REMOVE_ROOM(1)
call GET_ROOMS(21)
call GET_ROOM(1)
call GET_TASKS(1)
call GET_TASKS_PROGRESS(1)
call GET_GROUPS(1)
call GET_ACTIVITIES(1)

# Добавление комнаты
call ADD_ROOM('Name', 'Description')
call ADD_USER_ROOM(21, 4)
call GET_ROOMS(21)

# Изменение названия комнаты
call UPDATE_ROOM_NAME(4, 'Room 1. Again')
call GET_ROOMS(4)

# Изменение содержания комнаты
call UPDATE_ROOM_DESCRIPTION(4, 'Room1 description')
call GET_ROOMS(21)
