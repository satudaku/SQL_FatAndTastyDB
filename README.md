# SQL_FatAndTastyDB
Database creation named 'Fat and Tatsy' using sql from given scenarios with detailed documentation.
This Assignment was given from System and Database Design unit.

## Goal
### 1. Use Data Analysis to design a Database.
  State **assumptions/note** made regarding the given scenarios. Identify the entities, attributes, and relationships by creating a **logical ER diagram** and a **physical ER diagram** depict the database. Lastly, create a **Table Instance Chart (TIC)** for each entity in our data model. 
### 2. Implement a Database design using a Database Management system (DBMS), and to construct complex queries upon it.
  Implementation of database creation script, database Population script, and various view queries. 

## Documentation
  ### Assignment - Task 1.docx
  Includes: General Assignment Information, Scenario Details, and Guidelines.
  ### Assignment - Task 2.docx
  Includes: Implementation and Testing: Database creation Script, Database Population Script, and various view queries.
  ### CSG12070D_Daiki_AT2.docx
  Includes: Assumptions, Notes, Logical ERD, Physical ERD, Table Instance Charts (TIC), Database CREATE Script, INSERT Scripts, VIEW Scripts, Various Queries, Queries' Result, Database Schema, and List of Constraints.
  
  
## Scenario Details
Fast And Tasty (FAT) is a small chain of fast food stores. You have been hired to design a database system for FAT. The database must store details about staff, their shifts at stores, staff pay and suppliers of FAT and FAT products. You have been given the following information about the way FAT operates. Note that the information required below is the minimum.
- FAT staff may have shifts at multiple stores, and each store has multiple staff members.  
- The database must contain staff names, contact details, gender, date of birth and information regarding what days/times the staff are available to work.  
- To make it easier for new staff members, a more experienced staff member is assigned to be their mentor. This must be represented in the database.  
- The database must contain details of FAT stores, including a short name/location, a full address and details of opening hours.
- Each store has a manager, who is one of the staff members. A staff member only ever manages one store.
- A shift involves a staff member working at a store. The only shift details that need to be stored are the date of the shift, the starting time, and the ending time.
- Each staff member is paid according to their pay level, named from A to E. Each pay level specifies a different hourly salary and the percentage of superannuation received. The pay levels are detailed in the table below:

| Pay Level   |   Pay Level Name   | Hourly Salary  | % Superannuation  |
|:-----------:|:------------------:|:--------------:|:-----------------:|
|      A      |      Trainee       |      $12       |         2         |
|      B      |       Junior       |      $15       |         3         |
|      C      |       Senior       |      $18       |         4         |
|      D      | Assistant Manager  |      $30       |         8         |
|      E      |      Manager       |      $40       |        12         |

- Suppliers are businesses that supply products to FAT stores. The database must contain details of suppliers, including their business name, ABN, information regarding what products they supply, the contact person’s name and their contact details.
- Each supplier may supply multiple FAT stores, and each FAT store may be supplied by multiple suppliers. Details of supply deliveries do not need to be stored, simply the relationships between stores and suppliers. 
- FAT products are divided into two categories. These categories are “Healthy” and “Vegetarian”. All products have details about the name of the product, the price, the serving size, and a description. Additionally, “Healthy” products include information about the amount of fat and protein, the amount of calories per serve and sugar content, while “Vegetarian” products include information about the fibre content, the amount of sodium, carbohydrate content and the amount of calories per serve. 
- Not all FAT stores serve the same set of products. Some of the smaller FAT stores serve a reduced menu because of local demand.

## Assumptions/Notes
From scenarios details above, we can derive assumptions and notes as below:
### Assumptions
1. FAT’s Healthy and Vegetarian products use same method to measure amount of calories per serve in kilo joule (kj). 
2. All contact details means phone numbers.
3. Product size of drinks use volume (in mL), and product size for foods use weight (in gram).
### Notes
1. Introduce Primary-key to STAFF, STORE, SHIFT, PRODUCT, and SUPPLIER entities. 
2. Introduce non-key attribute to STOREPRODUCT and SUPPLIERPRODUCT.
3. Separate ‘day/time staff are available to work today’ attribute to start time, end time and day.
4. Change and Introduce ‘store opening hours’ to StoreOpenTime and StoreCloseTime.

## Logical ER Diagram
![fat_logical_erd_v3](https://user-images.githubusercontent.com/87003366/133891933-14e9e2ad-3531-4cdb-bb60-bddf999f5e34.jpg)

## Physical ER Diagram
![fat_physical_erd_v4](https://user-images.githubusercontent.com/87003366/133891952-3951d954-e8dc-4141-9408-12a652a72a64.png)

## Table Creation Order
1. PAY
2. STAFF
3. AVAILABILITY
4. STORE
5. SHIFT
6. PRODUCT
7. HEALTHY
8. VEGETARIAN
9. STORE_PRODUCT
10. SUPPLIER
11. STORE_SUPPLIER

## Table Instance Chart (TIC)
### PAY
| Column Name  | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  | Domain Values  |      Default Values       | Validation  |                    Meaning/Example                    | Rules  |
|:------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:--------------:|:-------------------------:|:-----------:|:-----------------------------------------------------:|:------:|
| PayID        | PK        | NN, UK   | -         | -          | Char       |    1    | Start at A     | Next sequential alphabet  | -           | A unique alphabet character to identify a Pay Level.  |        |
| PayName      | -         | NN       | -         | -          | VarChar    |   25    | -              | -Pay                      | -           | A pay level name.                                     |        |
| PayHourly    | -         | NN       | -         | -          | Decimal    |   5,2   |                | 0                         | > 0         | Hourly salary, cannot be < 0                          |        |
| PaySuper     | -         | NN       | -         | -          | Decimal    |   4,2   | -              | 0                         | -           | % Superannuation                                      |        |

### AVAILABILITY
|   Column Name   | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  |           Domain Values            |     Default Values     | Validation  |                  Meaning/Example                   |    Rules     |
|:---------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:----------------------------------:|:----------------------:|:-----------:|:--------------------------------------------------:|:------------:|
| AvailabilityID  | PK        | NN, UK   | -         | -          | Identity   |    -    | Start at 2000, increment by 1      | Next sequential value  | -           | A unique number to identify staff’s availability.  |              |
| AvailableDay    | -         | NN       | -         | -          | Char       |    3    | Sun, Mon, Tue, Wed, Thu, Fri, Sat  | -                      | -           | Staff’s day availability                           |              |
| StartTime       | -         | NN       | -         | -          | Time       |    -    | -                                  | 00:00                  | -           | -                                                  |              |
| EndTime         | -         | NN       | -         | -          | Time       |    -    | -                                  | 00:00                  | -           | -                                                  |              |
| StaffID         | FK        | -        | STAFF     | StaffID    | INT        |    -    | -                                  | -                      | RI          | -                                                  | OD-SN  UP-C  |

### STAFF
|   Column Name   | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  |         Domain Values          |     Default Values     | Validation  |            Meaning/Example            |    Rules     |
|:---------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:------------------------------:|:----------------------:|:-----------:|:-------------------------------------:|:------------:|
| StaffID         | PK        | NN, UK   | -         | -          | Identity   |    -    | Start at 1000, increment by 1  | Next sequential value  | -           | A unique number to identify a staff.  |              |
| StaffFirstName  | -         | NN       | -         | -          | VarChar    |   20    | -                              | -                      | -           | Staff’s first name                    |              |
| StaffLastName   | -         | -        | -         | -          | VarChar    |   20    | -                              | -                      | -           | Staff’s last name                     |              |
| SatffPhone      | -         | NN       | -         | -          | Char       |   10    | -                              | -                      | -           | Staff’s phone number                  |              |
| StaffGender     | -         | NN       | -         | -          | Char       |    1    | f, m,  i                       | -                      | -           | Staff’s gender                        |              |
| StaffDOB        | -         | NN       | -         | -          | Date       |    -    | -                              | today                  | <=today     | dd/mm/yyyy format                     |              |
| Mentor          | FK        | -        | STAFF     | StaffID    | INT        |    -    | -                              | -                      | RI          | -                                     | OD-SN  UP-C  |
| PayID           | FK        | -        | PAY       | PayID      | Char       |    1    | -                              | -                      | RI          | -                                     | OD-SN  UP-C  |

### STORE
|   Column Name    | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  |         Domain Values          |     Default Values     | Validation  |          Meaning/Example           |    Rules     |
|:----------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:------------------------------:|:----------------------:|:-----------:|:----------------------------------:|:------------:|
| StoreID          | PK        | NN, UK   | -         | -          | Identity   |    -    | Start at 3000, increment by 1  | Next sequential value  | -           | A unique number to identify store  |              |
| StoreName        | -         | NN       | -         | -          | VarChar    |   15    | -                              | -                      | -           | Store’s name                       |              |
| StoreAddress     | -         | NN       | -         | -          | VarChar    |   50    | -                              | -                      | -           | Store’s full address               |              |
| StoreOpen-Time   | -         | -        | -         | -          | Time       |    -    | -                              | 00:00                  | -           | -                                  |              |
| StoreClose-Time  | -         | -        | -         | -          | Time       |    -    | -                              | 00:00                  | -           | -                                  |              |
| ManagerID        | FK        | -        | STAFF     | StaffID    | INT        |    -    | -                              | -                      | RI          | -                                  | OD-SN  OU-C  |


### SHIFT
|   Column Name    | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  |         Domain Values          |     Default Values     | Validation  |          Meaning/Example           |     Rule     |
|:----------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:------------------------------:|:----------------------:|:-----------:|:----------------------------------:|:------------:|
| ShiftID          | PK        | NN, UK   | -         | -          | Identity   |    -    | Start at 4000, increment by 1  | Next sequential value  | -           | A unique number to identify shift  |              |
| ShiftDate        | -         | NN       | -         | -          | Date       |    -    | -                              | today                  | -           | Shift’s date  dd/mm/yyyy           |              |
| ShiftStart-Time  | -         | NN       | -         | -          | Time       |    -    | -                              | 00:00                  | >=now       | -                                  |              |
| ShiftEndTime     | -         | NN       | -         | -          | Time       |    -    | -                              | 00:00                  | >=now       | -                                  |              |
| StaffID          | FK        | -        | STAFF     | StaffID    | INT        |    -    | -                              | -                      | RI          | -                                  | OD-SN  UP-C  |
| StoreID          | FK        | -        | STORE     | StoreID    | INT        |    -    | -                              | -                      | RI          | -                                  | OD-SN  UP-C  |

### PRODUCT
|     Column Name      | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  |         Domain Values          |      Default Values       | Validation  |               Meaning/Example               | Rule  |
|:--------------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:------------------------------:|:-------------------------:|:-----------:|:-------------------------------------------:|:-----:|
| ProductID            | PK        | NN, UK   | -         | -          | Identity   |    -    | Start at 5000, increment by 1  | Next to sequential value  | -           | A unique number to identify shift           |       |
| ProductName          | -         | NN       | -         | -          | VarChar    |   30    | -                              | -                         | -           | Product’s Name                              |       |
| ProductPrice         | -         | -        | -         | -          | Decimal    |   5,2   | -                              | 0                         | -           | Product’s price                             |       |
| ProductSize          | -         | -        | -         | -          | Decimal    |   6,2   | -                              | 0                         | > 0         | size of the product  (food in gram          |       |
| ProductDesc-ription  | -         | -        | -         | -          | VarChar    |   70    | -                              | -                         | -           | -                                           |       |
| ProductCalo-ries     | -         | -        | -         | -          | Decimal    |   7,2   | -                              | 0                         | -           | amount of calories in kilojoules per serve  |       |

### HEALTHY
| Column Name  | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  | Domain Values  | Default Values  | Validation  |           Meaning/Example            |    Rule     |
|:------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:--------------:|:---------------:|:-----------:|:------------------------------------:|:-----------:|
| ProductID    | PK, FK    | NN       | PRODUCT   | ProductID  | INT        |    -    | -              | -               | RI          | -                                    | OD-C  UP-C  |
| Fat          | -         | NN       | -         | -          | Decimal    |   6,2   | -              | 0               | -           | Amount of fat in gram per serve      |             |
| Protein      | -         | NN       | -         | -          | Decimal    |   6,2   | -              | 0               | -           | Amount of protein in gram per serve  |             |
| Sugar        | -         | NN       | -         | -          | Decimal    |   6,2   | -              | 0               | -           | Amount of sugar in gram per serve    |             |

### VEGETARIAN
|  Column Name  | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  | Domain Values  | Default Values  | Validation  |              Meaning/Example              |    Rule     |
|:-------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:--------------:|:---------------:|:-----------:|:-----------------------------------------:|:-----------:|
| ProductID     | PK, FK    | NN       | PRODUCT   | ProductID  | INT        |    -    | -              | -               | RI          | -                                         | OD-C  OU-C  |
| Fibre         | -         | NN       | -         | -          | Decimal    |   6,2   | -              | 0               | -           | Amount of fibre gram per serve            |             |
| Sodium        | -         | NN       | -         | -          | Decimal    |   6,2   | -              | 0               | -           | Amount of sodium in milligram per serve   |             |
| Carbohydrate  | -         | NN       | -         | -          | Decimal    |   6,2   | -              | 0               | -           | Amount of carbohydrate in gram per serve  |             |

### STORE_PRODUCT
| Column Name  | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  | Domain Values  | Default Values  | Validation  | Meaning/Example  |    Rule     |
|:------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:--------------:|:---------------:|:-----------:|:----------------:|:-----------:|
| StoreID      | PK, FK    | NN       | STORE     | StoreID    | INT        |    -    | -              | -               | RI          | -                | OD-C  OU-C  |
| ProductID    | PK, FK    | NN       | PRODUCT   | ProductID  | INT        |    -    | -              | -               | RI          | -                | OD-C  OU-C  |

### SUPPLIER
|    Column Name    | Key Type  | NN/  UK  | PK Table  | PK Column  | Data Type  | Length  |         Domain Values          |     Default Values     | Validation  |            Meaning/Example            | Rule  |
|:-----------------:|:---------:|:--------:|:---------:|:----------:|:----------:|:-------:|:------------------------------:|:----------------------:|:-----------:|:-------------------------------------:|:-----:|
| SupplierID        | PK        | NN, UK   | -         | -          | Identity   |    -    | Start at 6000, increment by 1  | Next sequential value  | -           | A unique number to identify supplier  |       |
| Supplier-Name     | -         | NN       | -         | -          | VarChar    |   25    | -                              | -                      | -           | -                                     |       |
| SupplierABN       | -         | NN       | -         | -          | Char       |   11    | -                              | -                      | -           | -                                     |       |
| SupplierCP-Name   | -         | NN       | -         | -          | VarChar    |   25    | -                              | -                      | -           | Contact person’s name                 |       |
| SupplierCP-Phone  | -         | NN       | -         | -          | Char       |   10    | -                              | -                      | -           | Contact person’s phone number         |       |

### STORE_SUPPLIER
|      Column Name      | Key Type  | NN/  UK  | PK Table  |  PK Column  | Data Type  | Length  | Domain Values  | Default Values  | Validation  |          Meaning/Example          |     Rule     |
|:---------------------:|:---------:|:--------:|:---------:|:-----------:|:----------:|:-------:|:--------------:|:---------------:|:-----------:|:---------------------------------:|:------------:|
| StoreID               | PK, FK    | NN       | STORE     | StoreID     | INT        |    -    | -              | -               | RI          | -                                 | OD-NA  OU-C  |
| SupplierID            | PK, FK    | NN       | SUPPLIER  | SupllierID  | INT        |    -    | -              | -               | RI          | -                                 | OD-NA  OU-C  |
| DateProduct-Supplied  | PK        | NN       | -         | -           | Date       |    -    | -              | today           | <=today     | Date supplier send the product    |              |
| ProductID             | PK        | NN       | -         | -           | Char       |    4    | -              | -               | -           | ProductID from product table      |              |
| OrderPrice            | -         | NN       | -         | -           | Decimal    |   5,2   | -              | -               | -           | Price of a product from supplier  |              |
| OrderQuantity         | -         | NN       | -         | -           | Numeric    |    5    | -              | -               | -           | Quantity product ordered          |              |

## Implementation
Implement designed database in a DBMS, populate the database, and manipulate the data via queries.
### Database Creation Script
Script to create the database we have designed including data types, properties and constraints specified in TIC. Cited in `create_database.sql` file.
### Database Population Script
Script consisting of INSERT statements that populates the tables of the database. Cited in `insert.sql` file.
### View
Cited in `view.sql` file and the result in `CSG12070D_Daiki_AT2.docx` file.
#### Staff Availability View
Create a view which shows all details of all staff and their availability details.  The view should include the last name and first name of the staff member, the full name of their mentor (if any), their hourly salary and the days and times they are available for work. Sort the output by staff last name, then first name.
#### Pay View
Create a view which shows all details of how much each staff member should be paid for the hours they have worked. The view should contain the following columns: 
- The full name of the staff member (in the form of “surname, first name”), the pay level name, the shift ID, and date, start time and end time of the shift, and the store name at which the shift was worked.
- A column named “Pay”, which is defined as the number of hours of the shift multiplied by the hourly salary.
- A column named “Super”, which multiplies the number of hours worked by the super rate. 
### Queries
Cited in `query.sql` file and the result in `CSG12070D_Daiki_AT2.docx` file.
#### Query 1 – Store Shifts
Produce a query to display details of shifts worked at each store.  The output should include the names of the store, the name of the store manager, the date and start and end times of the shifts and the names of the staff members working each shift. Order the results store name, then by the date of the shifts, then by start times. 
#### Query 2 – Store Suppliers
Produce a query to display the stores and the suppliers which supply products to those stores.  Show the names of the store and the managers of the store, the supplier name, contact name and phone number of the supplier.
#### Query 3 – Non-mentoring staff 
Produce a query that shows the details of all staff who do not mentor other staff.  Order the results by last name, then first name.  Give a suitable column heading. Format the output using the following example: 
`BLOGGS, Joe does not mentor other staff`
#### Query 4 – Shift Statistics
Produce a query that shows the store name, the number of shifts worked, the number of hours worked, and the number of staff employed during a given month.  Order the results by number of hours worked (highest to lowest) and be sure to give all columns appropriate names.
#### Query 5 – Store Spend 
Produce a query to display the name of three stores that spend the most money on purchasing products. Show the store name, the manager name, and the total amount of money spent on purchasing products.  Order the results by the total amount of money spent.

## Disclaimer
File `Assignment - Task 1.docx`, `Assignment - Task 2.docx`, `list_constraints.sql`, and `schema.sql` were given from the unit's tutor. **I did not make them**.
