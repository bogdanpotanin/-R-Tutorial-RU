# --------
# Потанин Богдан Станиславович
# Введение в R :)
# Урок 9. Листы
# --------

# Переменные (объекты) типа list представляют собой структуры данных, которые
# хранят любые другие объекты R, в том числе разных типов, и позволяют 
# обращаться к ним
  # Создадим несколько переменных разных типов
v_1 <- c(1, 2, 3, 4, 5)
s_1 <- c("My", "Character", "Vector")
myFunc <- function (x)
{
  return(x ^ 2)
}
# Создадим переменную типа list с помощью функции list().
# При этом вы сами придумываете названия аргументам этой функции, 
# которые определят название элементов в созданном листе.
my_list <- list(vec_double = v_1,
                vec_character = s_1,
                func = myFunc,
                some_number = 8)

# Обращаться к элементам листа можно по имени с помощью $Имя
my_list$vec_double       # достаем наш вектор из элементов типа double
my_list$vec_character    # достаем наш вектор из элементов типа character
my_list$func(3)          # достаем и используем нашу функцию
my_list$some_number      # достаем наше число
my_list$kolobok          # получаем NULL, потому что элемента 
                         # с таким именем не существует

# Над элементами листа можно выполнять операции как
# над обычными переменными соответствующего типа
my_list$vec_double * 2
paste(my_list$vec_character, 
      ", Hello!", 
      sep = "")
sqrt(my_list$func(5))
exp(my_list$some_number)
v_2 <- sin(my_list$vec_double) + v_1

# К элементам листа можно обращаться и с помощью ["Имя"],
# но тогда возвращаемый объект тоже будет листом
v_2 <- my_list["vec_double"]
v_2 * 2                       # этот код выдаст ошибку, так как
                              # v_2 воспринимается как list,
                              # из-за чего арифметические операции
                              # с этой переменной невозможны
  # два способа достать нужные значения из
  # v_2 и осуществить нужные операции
typeof(v_2)
v_2$vec_double * 2            # достаем vec_double из v_2
as.double(unlist(v_2)) * 2    # разворачиваем list командой
                              # unlist и присваиваем полученной
                              # переменной тип double

# Чтобы перезаписать объект, хранящийся в листе,
# можно использовать тот же подход, что я для переменных
my_list$vec_double <- cos(my_list$vec_double) * 5

# Добавить элемент в лист 
# можно двумя способами
my_list$str_1 <- "My String 1"                # через $Имя
my_list["str_2"] <- "My String 2"             # через ["Имя"]
paste(my_list$str_1, my_list$str_2)           # обе строки появились
                                              # в нашем листе

# Аргументы в функцию можно подавать с помощью листа с именами,
# соответствующими аргументам функции. Для этого используется
# функция do.call(), имеющая следующие ключевые аргументы:
  # what - название называемой функции
  # args - лист, который содержит объекты с именами такими же,
  # как и аргументы вызываемой функции
# Опробуем данный подход на примере функции log()
log_list <- list(x = 125, base = 5)         # лист с аргументами для функции log()
do.call(what = "log", args = log_list)      # название функции задается строкой
do.call(what = log, args = log_list)        # или пишется непосредственно
log(x = 125, base = 5)                      # получаем аналогичный результат

  # ЗАДАНИЯ
    # 1. Создайте лист, состоящий из векторов трех различных типов. При этом
    #    все векторы должны содержать разное число элементов. Соедините
    #    элементы вашего листа с помощью функции c() в один вектор и проверьте 
    #    его тип
{
  my_list <- list(v_1 = 1,
                  b_1 = c(TRUE, FALSE),
                  s_1 = c("a", "b", "c"))
  my_vec <- c(my_list$v_1, my_list$b_1, my_list$s_1)
  typeof(my_vec)
}
    # 2. Создайте лист, состоящий из двух чисел и лист, состоящий из двух
    #    строк. Затем, создайте третий лист, содержащий предыдущие два.
    #    Из нового листа достаньте первый и определите, какое из
    #    входящих в него чисел больше.
{
  md_1 <- list(x_1 = 1, x_2 = 2)
  md_2 <- list(y_1 = 3, y_2 = 4)
  md_3 <- list(md_1 = md_1, md_2 = md_2)
  max(md_3$md_1$x_1, md_3$md_1$x_2)
}
    # 3. С помощью функции do.call() рассчитайте вероятность того, что
    #    нормальная случайная величина с математическим ожиданием 10 и
    #    стандартным отклонением 12 превысит 20.
{
  pnorm_arg <- list(q = 20, mean = 10, sd = 12)
  1 - do.call(pnorm, pnorm_arg)
}