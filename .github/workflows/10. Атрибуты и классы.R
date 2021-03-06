# --------
# Потанин Богдан Станиславович
# Введение в R :)
# Урок 10. Атрибуты и классы
# --------

# Атрибуты представляют собой дополнительные
# свойства объекта. Рассмотрим основные атрибуты
# на примере следующего вектора
v_1 <- c(1, 2, 3, 4, 5, 6)

# Атрибут names является объектом типа character
# и позволяет давать имена элементам объекта.
# Получить доступ к данному атрибуту можно с
# помощью функции names()
names(v_1)                          # то, что данный атрибут равен
                                    # NULL говорит о его отсутствии
                                    # у вектора v_1
names(v_1) <- c("cat", "dog",       # чтобы добавить атрибут объекту
                "bird", "fish",     # используется оператор <-
                "rhino", "rabbit") 
print(v_1)                          # теперь элемента вектора имеют имена
attributes(v_1)                     # функция attributes() позволяет
                                    # получить все атрибуты объекта
                                    # в форме листа
v_1[c("rhino", "cat", "bird")]      # атрибут names позволяет обращаться
                                    # к элементам объекта с помощью
                                    # указания имен в форме character вектора

# Атрибут class определяет класс объекта и классы, от
# которых данный класс наследует. Иногда названия класса 
# и типа объекта могут совпадать, но это не обязательно.
# Определить различия между классом и объектом в R затруднительно,
# поскольку объектам одного и того же (класса) типа могут 
# соответствовать разные классы (типы). Деление на классы
# создано преимущественно для того, чтобы одни и те же функции 
# работали по разному с объектами, имеющими разные классы.
class(c("a", "b"))                  # тип и класс совпадают 
typeof(c("a", "b"))                 # по названию
class(v_1)                          # тип и класс не совпадают
typeof(v_1)                         # по названию

# Атрибут dim определяет размерность объекта и
# позволяет превратить вектор в массив произвольной
# размерности. С изменением размерности вектор
# автоматически изменяет и свой класс.
dim(v_1) <- c(2, 3)
print(v_1)                                 # вследствие изменения размерности
class(v_1)                                 # переменная v_1 изменила class с
                                           # numeric на matrix, который наследует
                                           # от класса array
typeof(v_1)                                # при этом тип переменной все еще double
# Первое измерение отвечает за количество
# строк матрицы, а второе - за количество
# столбцов. Как именно работать с
# матрицами и по какому алгоритму вектор
# превращается в матрицу мы рассмотрим
# на следующих уроках
attributes(v_1)                            # также, вследствие изменения класса
                                           # объект может терять часть своих
                                           # атрибутов, но при этом получать 
                                           # возможность использовать новые
                                           # теперь стал доступен атрибут dimnames,
                                           # отвечающий за имена строк и столбцов
                                           # матрицы
colnames(v_1) <- c("car", "boat", "tank")  # изменим этот атрибут с помощью функций
rownames(v_1) <- c("house", "castle")      # rownames и colnames
print(v_1)
attributes(v_1)

# Получить любой атрибут можно с помощью 
# функции attr()
attr(x = v_1,                                    # объект
     which = "dim")                              # атрибут
attr(x = v_1,                                    # атрибут dimnames это лист, который
     which = "dimnames")                         # состоит из элементов, каждый из
                                                 # это объект типа character,
                                                 # содержащего имена соответствующих
                                                 # измерений
# Примечание: если создать лист, не указав имена
# некоторых из входящих в него элементов, то
l <- list(c(1,2,3), kolobok = 0, c("a, b, c"))   # вместо имен эти элементы получат
print(l)                                         # порядковые номера [[номер]] и
l[[1]]                                           # обращаться к ним можно будет лишь
l[[3]]                                           # по порядковому номеру и делать это
l[[2]]                                           # можно в том числе для элементов,
l$kolobok                                        # которые имеют имена

# С помощью функции attr изменять существующие
# и создавать новые атрибуты с помощью
# оператора <-
attr(x = v_1,                                    # в результате изменения атрибута
     which = "dim") <- c(1, 2, 3)                # dim мы получили трехмерную 
class(v_1)                                       # структуру данных, имеющую класс array
print(v_1)                                  
attr(x = v_1,                                    # мы создали атрибут cat                            
     which = "cat") <- c("good", "nice")         # как объект типа character        
attributes(v_1)

  # ЗАДАНИЯ
    # 1. Создайте переменную типа double, состоящую из трех элементов.
    #    При помощи функции names() присвойте атрибуту names данного 
    #    объекта character вектор, состоящий из произвольных строк. 
    #    Затем измените атрибут names() с помощью функции attr()
{
  b <- c(TRUE, FALSE, TRUE)
  names(b) <- c("a", "b", "c")
  attr(b, "names") <- c("I", "Like", "R")
}
    # 2. Создайте вектор из девяти элементов. Сделайте из него матрицу
    #    размером 3 на 3 с помощью функции dim(). При помощи функции attr() 
    #    измените атрибут dimnames таким образом, чтобы строки матрицы назывались
    #    "a", "b" и "c", а столбцы - "d", "e" и "f"
{
  v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
  dim(v) <- c(3, 3)
  attr(v, "dimnames") <- list(c("a", "b", "c"), 
                              c("d", "e", "f"))
  print(v)
}