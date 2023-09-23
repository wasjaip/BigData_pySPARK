
# Исследование методик машинного обучения для обработки больших данных с применением PySpark  (BigData_pySPARK)

## Введение

В современном мире анализ больших данных играет ключевую роль в прогнозировании и принятии решений. Этот проект направлен на исследование различных методов машинного обучения при работе с объемными данными с использованием PySpark.

## Сопоставление производительности унифицированной распределенной модели с несколькими параллельными моделями

В рамках проекта проводится анализ на примере задачи прогнозирования количества заказов такси в Чикаго на ближайший час.

### Источник данных:
Данные были получены с [официального сайта данных города Чикаго](https://data.cityofchicago.org/Transportation/Taxi-Trips/wrvz-psew) и включают в себя информацию о поездках на такси за 2022 год и часть 2023 года.

### Цель исследования:

Цель данного проекта заключается в сравнении двух подходов обработки данных:
1. Использование унифицированной распределенной модели.
2. Применение нескольких параллельных моделей.

### Технические детали:

- **Spark Конфигурация**: Spark запущен на локальном кластере, который состоит из четырех воркеров. Каждый воркер оснащен двумя ядрами. 
- **MLFlow**: Для трекинга и документации результатов моделей используется отдельный контейнер с MLFlow.
- **Настройка Кластера**: Для запуска кластера требуется подготовка специализированных образов для pyspark и mlflow.
- **Библиотеки**: Дополнительные библиотеки для воркеров устанавливаются из файла `requirements.txt`.

### Ноутбук с анализом:
Для интерактивного изучения процесса анализа и результатов предоставлен [ноутбук на GitHub](https://github.com//wasjaip/BigData_pySPARK/taxi.ipynb).

## Заключение

Этот проект предоставляет возможность глубже изучить преимущества и недостатки различных методов машинного обучения при работе с большими данными, а также дает понимание, как PySpark может быть использован в этом контексте.

