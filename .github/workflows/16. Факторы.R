# --------
# Потанин Богдан Станиславович
# Введение в R :)
# Урок 16. Факторы
# --------

# Функция unique() убирает все повторяющиеся
# значения из вектора
animals <- c("dog", "cat", "cat", "dog", "cat", 
             "dog", "fish", "cat", "fish")
animal_types <- unique(animals)

# Факторные переменные принимают ограниченное число
# значений, заранее определяемых пользователем. Они
# создаются из обычных векторов.
  # Первый способ: указываем факторы явно
animals_f <- factor(x = animals,                       # вектор, превращаемый в факторную переменную   
                    levels = animal_types)             # уровни создаваемой факторной переменной
  # Второй способ: автоматически делаем так,  
  # что уровни будут совпадать с возможными 
  # названиями объектов, поскольку по умолчанию
  # задается levels = sort(unique(x))
animals_f <- factor(animals)

# От обычного вектора факторная переменная 
# в первую очередь отличается наличием атрибута levels
levels(animals_f) 
attributes(animals_f)
                
# В факторную переменную можно записывать лишь 
# значения, соответствующие ее уровням, либо NA
animals_f[2] <- "bird"                            # превратится в NA, поскольку
                                                  # уровень bird не существует
print(animals_f)                                  # вместо bird имеем NA
levels(animals_f) <- c(levels(animals_f), "bird") # добавляем новый уровень
                                                  # bird для animals_f
animals_f[2] <- "bird"                            # теперь ошибки нет

# Факторные переменные, как правило, позволяют красивее
# и удобней агрегировать различную информацию.

# Рассмотрим датафрейм mtcars
attach(mtcars)
d <- mtcars
# Создадим в нем факторную переменную на число цилиндров (cyl)
# и на число карбюраторов (carb)
d$cyl <- as.factor(d$cyl)
d$carb <- as.factor(d$carb)
# Посмотрим таблицу, которая показывает, скольку имеется в
# датафрейме машин с заданным число цилиндров и карбюраторов
table(d$cyl, d$carb,
      dnn = c("Number of cylinders",
              "Number of carburetors"))

# Факторные переменные имеют тип integer
typeof(animals_f)
as.integer(animals_f)         # несмотря на то, что R отображает значения факторной
                              # переменной словами, на самом деле он воспринимает их
                              # как целые числа, где объекты, соответствующие уровню,
                              # идущему под порядковым номером i в levels соответствует
                              # число i
# Факторные переменные имеют класс factor
class(animals_f)

# Даже если факторные переменные принимают числовые значения,
# попытка осуществить над ними арифметические операции приведет
# к тому, что все они станут равны NA
d$cyl * 2                         # все значения стали NA
# При преобразовании факторных переменных в переменные
# другого типа следует помнить о том, что факторные
# переменные имеют тип integer и именно целые числа,
# соответствующие определенным уровням, будут
# использоваться при преобразовании
as.numeric(d$cyl)
data.frame("cyl_factor" = d$cyl, 
           "cyl_numeric" = as.numeric(d$cyl))
# Чтобы корректно преобразовать факторные переменные
# в числовые необходимо использовать следующую,
# не очевидную конструкцию
as.numeric(levels(d$cyl))[d$cyl]      # работает, но по весьма сложным причинам,
                                      # объяснение которых выходит за пределы урока
data.frame("cyl_factor" = d$cyl, 
           "cyl_numeric" = as.numeric(levels(d$cyl))[d$cyl])

# ЗАДАНИЯ
  # 1. Создайте факторную переменную, имеющую 
  #    три уровня: "car", "tank", "boat". Включите в нее
  #    пр два объекта, соответствующих каждому уровню
{
  f <- as.factor(c("car", "tank", "boat", "tank", "boat", "car"))
}
  # 2. Добавьте к созданной в предыдущем пункте переменной
  #    еще один уровень - "helicopter". Добавьте в переменную
  #    еще один объект соответствующий данному уровню
{
  levels(f) <- c(levels(f), "helicopter")
  f[7] <- "helicopter"
}
  # 3. Пусть имеется вектор v_1 <- c(-1, 2, -3, 4, -5, 4, -3, 2, -1)
  #    Преобразуйте его в факторную переменную, а затем обратно в
  #    численный вектор таким образом, чтобы получить исходный вектор
{
  v_1 <- c(-1, 2, -3, 4, -5, 4, -3, 2, -1)
  v_1 <- as.factor(v_1)
  v_1 <- as.numeric(levels(v_1))[v_1]
}