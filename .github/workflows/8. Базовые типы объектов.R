# --------
# Потанин Богдан Станиславович
# Введение в R :)
# Урок 8. Базовые типы объектов в R
# --------

# Объект в R - очень широкое понятие: с точки 
# зрения R все является объектами
# Переменной мы будем именовать объекты, которые
# мы сохранили под определенным названием
5 + 3                   # объект
my_vec <- c(5, 8.5, 6)  # объект, являющийся переменной
sqrt(my_vec)            # объект
new_vec <- sqrt(my_vec) # объект, являющийся переменной
mean(c(1, 2, 5))        # объект

# Подробней о том, что обсуждается в данном уроке, можно
# узнать из: stat.ethz.ch/R-manual/R-devel/doc/manual/R-lang.html

#-----------------------------------------
# Некоторые типы объектов в R
#-----------------------------------------

# 1. Тип closure - функции
myFunc <- function (x)
{
  return(x ^ 2)
}
typeof(myFunc)
typeof(mean)

# 2. Тип NULL - пустые объекты
a <- NULL
typeof(a)
c(NULL, NULL, NULL)

# 3. Тип logical (bool) - векторы, состоящие из TRUE и FALSE
# Векторы, с конкретным указанием типа, можно 
# создавать при помощи функции vector()
b_1 <- vector(mode = "logical",            # указываем тип вектора
              length = 5)                  # и его длину
typeof(b_1)

# 4. Тип character - векторы, состоящие из строк
s_1 <- vector(mode = "character",          # указываем тип вектора
              length = 5)                  # и его длину
typeof(s_1)

# 5. Тип double - векторы, состоящие из вещественных чисел
v_1 <- vector(mode = "double",             # указываем тип вектора
              length = 5)                  # и его длину
typeof(v_1)

# 6. Тип integer - векторы, состоящие из целых чисел
i_1 <- vector(mode = "integer",            # указываем тип вектора
              length = 5)                  # и его длину
typeof(i_1)

# 7. Тип complex - вектор, состоящие из комплексных чисел
c_1 <- vector(mode = "complex",            # указываем тип вектора
              length = 5)                  # и его длину
typeof(c_1)

# 8. Тип raw - вектор, состоящие из байтов
r_1 <- vector(mode = "raw",                # указываем тип вектора
              length = 5)                  # и его длину
typeof(r_1)

# Векторами в R называют объекты, имеющие тип double, character,
# raw, logical, integer или complex. Чтобы проверить, является
# ли объект вектором, можно использовать функцию is.vector()
is.vector(mean)     # функция mean() является объектом, который 
                    # имеет тип closure, а значит не является вектором
is.vector(v_1)      # данный объект является вектором, поскольку
                    # имеет тип double

# В R не существует скаляров в привычном смысле: все вещественные 
# числа, строки и т.д. являются векторами, а скаляром условно
# называют векторы, состоящие из одного элемента
x <- 10.5                     # скаляр 10.5
is.vector(x)                  # является вектором
length(x)                     # длины 1
v_1 <- c(1, 3, 5)             # создаем вещественный вектор
is.vector(v_1[1],             # убеждаемся, что его элемент также
          mode = "double")    # является вещественным вектором  
# Иногда векторы в R называют atomic vectors, тем самым подчеркивая,
# что они представляют собой структуру, состоящую из объектов
# одного и того же типа

# Проверить, соответствует ли переменная определенному типу можно
# двумя способами
# Первый способ: с помощью функций вида is.(тип переменной):
# Получаем TRUE
is.logical(b_1)
is.character(s_1)
is.double(v_1)
is.integer(i_1)
is.complex(c_1)
is.function(max)
is.null(NULL)
# Получаем FALSE
is.character(v_1)
is.integer(b_1)
is.null(s_1)
is.function(c_1)
is.integer(sqrt)
  # Второй способ: сравнив значение, возвращаемое 
# функцией typeof() с ожидаемым
typeof(v_1) == "double"    # получаем TRUE
typeof(v_1) == "character" # получаем FALSE

# Некоторые функции применимы лишь в отношении  
# переменных определенных типов
sqrt(v_1)             # можно
sqrt(s_1)             # нельзя
# Иногда функции в R могут преобразовать
# тип переменной и уже затем применить
# к ней функцию
as.character(b_1)
paste(as.character(b_1), "Done!")     # оба способа дают
paste(b_1, "Done!")                   # эквивалентный результат
sqrt(c("1","2","3"))                  # но так не работает, несмотря
sqrt(as.double(c("1","2","3")))       # на то, что так уже работает

# Существует и множество других базовых типов, 
# основные из них мы рассмотрим в дальнейшем.
# Обо всех типах можно узнать в:
# stat.ethz.ch/R-manual/R-devel/doc/manual/R-lang.html
