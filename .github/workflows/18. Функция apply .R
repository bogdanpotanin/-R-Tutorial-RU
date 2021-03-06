# --------
# Потанин Богдан Станиславович
# Введение в R :)
# Урок 18. Функция apply и ее товарищи
# --------

# В качестве альтернативы циклу в R выступает
# функция apply, а также ряд похожих на нее функций

# Основные аргументы функции apply():
  # X - обычно матрица или датафрейм
  # MARGIN - равно 1, если функцию нужно применить
  # к каждой строке и 2 - если к каждому столбцу
  # FUN - какая функция должна быть применена
  # ... - аргументы функции из FUN (можно листом)
# Функция возвращает матрицу или датафрейм, где все 
# столбцы и строки будут одинаковой длины, в следствие того,
# что над ними была проделана одна и та же операция

# Применим функцию apply() для решения разных задач
m_1 <- matrix(data = c(2, 5, 5, 
                       3, 9, 10, 
                       3, 2, 90), 
              nrow = 3, ncol = 3, 
              byrow = TRUE)
apply(X = m_1,                     # посчитаем среднее по каждому столбцу
      MARGIN = 2, 
      FUN = mean)                
apply(m_1, 1, sum)                 # посчитаем сумму по каждой строке
apply(m_1, 2,                      # прибавим 10 к каждому элементу
      function (x)                 # можно создать функцию прямо в аргументе,
      {                            # где x это столбец матрицы если MARGIN = 2
                                   # или строка если MARGIN = 1        
        x <- sqrt(sum(x ^ 2))      # считаем длину вектора в математическом
        return (x)                 # смысле для каждого столбца матрицы
      })
apply(m_1, 2, rep, times = 3)      # повторим каждый столбец по 3 раза,
                                   # используя аргумент times из rep()
apply(m_1, 2,                      # умножаем каждый столбец матрицы
      function (x)                 # на ее первый столбец
      {
        return (x * m_1[, 1])
      })

# Функция tapply() позволяет применить функцию
# к каждому значению факторной переменной.
# Основные аргументы:
  # X - вектор, к которому будет применяться функция
  # INDEX - факторная переменная, которая разбивает
  # вектор X отдельно и позволяет применить к каждому
  # из элементов этого разбиения функцию FUN отдельно
  # FUN - применяемая функция
animal <- as.factor(c("cat", "dog", "bird", "cat", 
                      "dog", "dog", "cat", "bird"))
weight <- c(5.5, 3.2, 6.1, 2.2, 
            3.9, 1.1, 1.6, 2.3)
tapply(X = weight,               # считаем средний вес (weight) для 
       INDEX = animal,           # каждого из видов животного
       FUN = mean)     

tapply(weight, animal,           # возвращаем вектор квадрата весов
       function(x)               # для каждого животного
         {
           x <- x ^ 2
           return(x)
         })

# Функция aggregate() в отличие от tapply() позволяет применить функцию сразу
# к нескольким столбцам в зависимости от значений одной факторной переменной
# Основные аргументы:
  # x - столбцы или их названия (если задано значение параметра data), 
  #     к которым будет применять функция в зависимости от значений
  #     факторной переменной
  # by - одна или несколько факторных переменных. Если переменная не
  #      является факторной, то она будет автоматически преобразована
  #      в факторную
  # FUN - применяемая функция
  # data - датафреейм, из которого будут браться столбцы для переменной x

# Рассмотрим пример применения функции aggregate() 
# с помощью данных из массива mtcars
attach(mtcars)
aggregate(x = mtcars[, c("hp", "wt")],      # считаем среднее значение лошадиных сил
          by = mtcars[, c("cyl", "carb")],  # и веса автомобиля в зависимости от
          FUN = mean)                       # числа цилиндров и карбюраторов

aggregate(x = mtcars[, c("hp", "wt")],      # считаем разницу между наибольшим и
          by = mtcars[, c("cyl", "carb")],  # наименьшим значениями по отдельности для
          FUN = function(x)                 # лошадиных сил и веса автомобиля, где
                {                           # в качестве x выступают соответствующие
                  my_val <- max(x) - min(x) # переменные
                  return(my_val)
                })
# Обратите внимание, что аргумент by должен быть датафреймамом, а
# отдельный столбец может быть воспринят как вектор, что
# потребует его предварительного преобразования в датафрейм
# при помощи функции as.data.frame()
aggregate(x = mtcars$hp,
          by = as.data.frame(mtcars$cyl),   # без as.data.frame() функция
          FUN = mean)                       # выдаст вам ошибку

# Функция mapply() обычно применяется для того, чтобы применять функции, не
# поддерживающие аргументы в виде вектора, с аргументом в виде вектора
# Аргументы:
  # FUN - функция
  # ... - аргументы функции в виде листа или
  #       указанные по отдельности прямо внутри
  #       функции mapply как в примере ниже
mapply(rep, x = c(1, 2, 3),                 # повторим единицу три раза,
       times = c(3, 5, 7))                  # двойку пять раз и
                                            # тройку - семь раз

# Есть также и другие, схожие с apply() функции, 
# включая sapply(), by(), sweep(), vapply() и lapply()

  # ЗАДАНИЯ
    # 1. При помощи функций apply() и max() найдите максимальное значение
    #    в столбцах mpg, hp и wt датафрейма mtcars. Затем для каждой из
    #    датафрейма, составленного из соответствующих столбцов, найдите
    #    минимальное значение с помощью функции min()
{
  attach(mtcars)
  apply(mtcars[, c("mpg", "hp", "wt")], 2, max)
  apply(mtcars[, c("mpg", "hp", "wt")], 1, min)
}
    # 2. С помощью функции apply составьте датафрейм из столбцов mpg, hp и wt
    #    датафрейма mtcars, деленных на значения столбца carb
{
  apply(mtcars[, c("mpg", "hp", "wt")], 2, 
        function(x)
          {
            x / mtcars$carb
          return(x)
          })
}
    # 3. Используя функция tapply и датафрейм mtcars найдите максимальное
    #    число лошадиных сил hp в зависимости от числа карбюраторов carb.
{
  attach(mtcars)
  tapply(mtcars$hp, mtcars$carb, max)
}
    # 4. Используя функция tapply и датафрейм mtcars отсортируйте в порядке
    #    убывания значения столбца hp в завимости от значений столбца carb
{
  attach(mtcars)
  tapply(mtcars$hp, mtcars$carb, sort, decreasing = TRUE)
}
    # 5. С помощью функции aggregate() повторите предыдущий пункт
{
  attach(mtcars)
  aggregate(x = as.data.frame(mtcars$hp), 
            by = as.data.frame(mtcars$carb), 
            FUN = sort, decreasing = TRUE)
}