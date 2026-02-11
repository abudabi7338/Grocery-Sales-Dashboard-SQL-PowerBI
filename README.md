# Grocery Sales Dashboard

## Status: 🚧 W trakcie budowy

## Opis
Analiza danych sprzedażowych sklepu spożywczego.
Dataset: 521 MB, 7 tabel, ~1M+ transakcji.

## Narzędzia
- MySQL (VS Code)
- Power BI
- Git

## Postęp
- [x] Eksploracja danych
- [x] Identyfikacja problemów jakościowych
- [x] Znalezione błędy: TotalPrice = 0, formaty SalesDate, niespójności IsAllergic
- [x] Import do MySQL (1.2M wierszy)
- [ ] Czyszczenie danych (W trakcie 🚧)
  - [x] Oczyszczenie tabel słownikowych (categories, cities)
  - [ ] Standaryzacja tabeli products (IsAllergic, obsługa NULL)
  - [ ] Naprawa tabeli faktów sales (wyliczenie poprawnego Revenue)
- [ ] Zapytania analityczne i KPI
- [ ] Dashboard Power BI

## 🛠️ Wyzwania techniczne: Import danych
- Plik `sales.csv` (521 MB) był zbyt duży dla standardowych narzędzi importu (Table Data Import Wizard).
- Zastosowałem metodę `LOAD DATA LOCAL INFILE`, co pozwoliło na import 1.2M rekordów w kilkanaście sekund.
- Skonfigurowałem uprawnienia serwera i klienta (`local_infile`), aby umożliwić bezpieczne ładowanie plików lokalnych.

## Źródło danych
Kaggle: https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset