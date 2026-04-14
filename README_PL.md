# Analiza Sprzedaży Sklepów Spożywczych | SQL & Power BI

**🔗 [Zobacz Dashboard](#)** | **📄 [Analiza SQL](./sql_queries/)** | 📊 [Pliki Power BI](./powerbi/)
🔗Kaggle: https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset
### Strona Główna
![Dashboard Page 1](/powerbi/images/Projet1_Page1.png) 
### Podsumowanie i KPI
![Dashboard Page 2](/powerbi/images/Projet1_Page2.png) 
### Analiza Produktów
![Dashboard Page 3](/powerbi/images/Projet1_Page3.png) 
### Trendy Sprzedaży Miesięcznej
![Dashboard Page 4](/powerbi/images/Projet1_Page4.png)
### Segment Klientów
![Dashboard Page 5](/powerbi/images/Projet1_Page5.png) 
### Wnioski i trendy
![Dashboard Page 6](/powerbi/images/Projet1_Page6.png) 

### Analiza danych
![Dashboard Page 7](/powerbi/images/Projet1_Page7.png)



> **Analiza 6,7 mln transakcji (przychód $4,29 mld) wykazała, że 88% dochodu pochodzi ze sprzedaży bez rabatów**

---

## 🎯 Problem Biznesowy

Sieć sklepów spożywczych w USA potrzebowała zrozumieć źródła przychodów w ciągu 5 miesięcy działalności (styczeń-maj 2018). Kluczowe pytania:
- Które produkty i kategorie napędzają zyski?
- **Czy rabaty faktycznie zwiększają przychody?** (Kluczowe dla optymalizacji marży)
- Kim są najbardziej wartościowi klienci i jakie są ich wzorce zakupowe?
- Jak wydajność sprzedaży zmienia się w czasie i przestrzeni?

---

## 💡 Kluczowe Wnioski i Wartość Biznesowa

| Wniosek | Wartość Biznesowa | Dowód |
|---------|------------------|-------|
| **88% przychodu ze sprzedaży bez rabatów** | Obecna strategia rabatowa (10%, 20%) jest nieskuteczna; możliwość natychmiastowej poprawy marży | $3,7 mld (bez rabatu) vs $400 mln (z rabatem) |
| **Środek tygodnia to szczyt** | Optymalizacja obsady i zapasów na środek tygodnia | $632 mln (środa) vs $599 mln średnia dzienna |
| **Segmentacja klientów VIP** | Identyfikacja szansy na program retencji kluczowych klientów | Leley Perry: $260K przychodu, $1,202 średnia transakcja (2x powyżej średniej) |
| **Przewaga kategorii** | Skupienie inwestycji zapasowych na wysokowydajnych kategoriach | Słodycze ($551 mln) > Mięso ($487 mln) > Drób ($435 mln) |
| **Kryzys jakości danych** | Odkrycie krytycznego błędu ETL wymagającego natychmiastowej naprawy | Kolumna TotalPrice = 0 w 100% rekordów źródłowych |

---

## 🛠️ Implementacja Techniczna

### Architektura i Inżynieria Danych
- **Skala:** 521 MB danych surowych, 7 tabel, 6,7 mln rekordów transakcyjnych
- **Rozwiązane Problemy Jakościowe:**
  - Obliczenie prawdziwego przychodu od zera: `Ilość × Cena × (1-Rabat)` (kolumna źródłowa TotalPrice była NULL/0)
  - Wykluczenie 67,526 rekordów z nieprawidłowymi datami (`'0000-00-00'`)
  - Standaryzacja niekonsekwentnych flag boolean (IsAllergic: "True"/"False"/"Unknown")
- **Optymalizacja Wydajności:** Ominięcie ograniczeń standardowego kreatora importu przy użyciu `LOAD DATA LOCAL INFILE` dla 1,2 mln wierszy

### Warstwa Analityczna SQL
**Złożone zapytania analityczne obejmujące:**
- **Funkcje Okienkowe:** `DENSE_RANK()`, `RANK()`, `LAG()` do analizy MoM i top-N
- **CTE:** Wielopoziomowe wyrażenia wspólne tabel dla segmentacji klientów i rankingu pracowników
- **Zaawansowane JOINy:** Relacje 3+ tabel (sprzedaż → klienci → miasta → kraje)
- **Analiza Czasowa:** Analiza szeregów czasowych z prawidłową obsługą dat

**8 Odpowiedzianych Pytań Biznesowych:**
1. Top 10 produktów wg przychodu
2. Najlepszy produkt w każdej kategorii (funkcje okienkowe)
3. Trendy przychodów miesięcznych
4. Wzorce sprzedaży wg dnia tygodnia
5. Analiza wydajności kategorii
6. **Walidacja wpływu rabatów** (testowanie hipotezy)
7. Identyfikacja wartościowych klientów (analiza RFM-style)
8. Wskaźniki wzrostu Month-over-Month

### Wizualizacja Power BI
- **Model Danych:** Schemat gwiazdy z `sales_clean` jako tabela faktów, 6 tabel wymiarów
- **Miary DAX:** 
  - Inteligencja Czasowa (MoM%, YoY)
  - Metryki klientów (Distinct count, Średnia wartość transakcji)
  - Obliczenia przychodów z dynamicznym filtrowaniem
- **Strony Dashboardu:** 5 powiązanych widoków (Overview, Products, Trends, People, Insights)
- **Rozwiązywanie Problemów:** Naprawa błędów "ambiguous path" w relacjach między pracownikami a sprzedażą

---

## 🚀 Kluczowe Wyzwania Przezwyciężone

**1. Odkrycie "Zerowego Przychodu"**
- *Problem:* Podczas eksploracji odkryto `TotalPrice = 0` w 100% z 6,7 mln wierszy — krytyczny błąd ETL w danych źródłowych
- *Rozwiązanie:* Zaprojektowano kolumnę obliczaną używając logiki biznesowej: `Ilość × Cena.Produktu × (1-Rabat)`
- *Wpływ:* Uratowanie wykonalności projektu; umożliwienie dokładnej analizy finansowej

**2. Niepełne Dane Szeregów Czasowych**
- *Problem:* Dane z maja 2018 tylko do 9. dnia (9 dni vs 31), powodujące wprowadzający w błąd spadek o -33% w analizie trendów
- *Rozwiązanie:* Wdrożenie filtra jakości danych wykluczającego niepełne miesiące z obliczeń trendów
- *Wynik:* Dokładne metryki wzrostu MoM pokazujące prawdziwą wydajność biznesową



---

## 🛠️ Technologie

**Inżynieria Danych:** `MySQL` • `SQL` • `Czyszczenie Danych` • `ETL`

**Analityka:** `Power BI` • `DAX` • `Modelowanie Danych` • `Time Intelligence`

**Rozwój:** `Git` • `GitHub` • `VS Code`

---

## 📊 Podgląd Dashboardu

*Zrzuty ekranu do dodania w folderze `/images/`*

---

## 🎓 Czego się Nauczyłem

- **Najpierw Walidacja Danych:** Zawsze profiluj dane przed modelowaniem — wczesne znalezienie NULL w TotalPrice zapobiegło nieprawidłowym wnioskom biznesowym
- **Kontekst Biznesowy Ma Znaczenie:** "Anomalia" techniczna (niski przychód w maju) była w rzeczywistości ograniczeniem danych, nie spadkiem biznesowym
- **Psychologia Rabatów:** Kontr-intuicyjne odkrycie, że rabaty nie napędzały wolumenu, wzmacniając potrzebę strategii cen opartej na danych
- **Relacje w Power BI:** Rozwiązywanie błędów cyklicznych referencji między sprzedażą-pracownikami-miastami przy użyciu właściwego schematu gwiazdy

---

**Status:** ✅ Ukończony   


---

*Projekt rozwinięty w ramach przebranżowienia zawodowego z kierowcy (kat. C+E) na Junior Data Analyst. Demonstruje kompetencje end-to-end: od pozyskiwania surowych danych po prezentację insightów biznesowych.*