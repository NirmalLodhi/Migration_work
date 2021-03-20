create database Pizzabox



USE [Pizzabox]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 3/13/2021 3:50:16 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
DROP TABLE [dbo].[Customer]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 3/13/2021 3:50:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
select * from [Customer]

CREATE TABLE [dbo].[Customer](
CustomerID INT IDENTITY(1,1) NOT NULL,
    LoginName NVARCHAR(40) NOT NULL,
    PasswordHash BINARY(64) NOT NULL,
    FirstName NVARCHAR(40) NULL,
    LastName NVARCHAR(40) NULL,
	Phone BIGINT NULL,
	Email NVARCHAR(100) NULL,
	CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED  (CustomerID ASC)
)

-- DROP TABLE [PizzaStore]

CREATE TABLE [dbo].[PizzaStore](
StoreID INT IDENTITY(1,1) NOT NULL,
    StoreName NVARCHAR(40) NOT NULL,
    Address1 NVARCHAR(40) NOT NULL,
	Address2 NVARCHAR(40) NOT NULL,
    City NVARCHAR(40)  NOT NULL,
	State CHAR(8) NOT NULL,
    Zip INT NOT NULL,
	Phone BIGINT NOT NULL,
	Email NVARCHAR(100) NOT NULL,
	CONSTRAINT [PK_Store_StoreID] PRIMARY KEY CLUSTERED  (StoreID ASC)
)

INSERT INTO [PizzaStore] VALUES('','123 tom dr nw','','Concord','NC',28027,1234567890,'abc@pizzastore.com')
INSERT INTO [PizzaStore] VALUES('','165 chrch st','','Concord','NC',28027,324567890,'cs@pizzastore.com')

select * from [PizzaStore] 


--DROP TABLE PizzaSize
CREATE TABLE PizzaSize(
PizzaSizeID Int IDENTITY(1,1) NOT NULL,
PizzaSize NVARCHAR(40) NOT NULL,
Dimenssions NVARCHAR(40) NOT NULL ,
CONSTRAINT [PK_PizzaSize_PizzaSizeID] PRIMARY KEY CLUSTERED  (PizzaSizeID ASC)
)


INSERT INTO PizzaSize VALUES('Small','10 inches with 6 slices' )
INSERT INTO PizzaSize VALUES('Medium','12 inches with 8 slices')
INSERT INTO PizzaSize VALUES('Large','14 inch with 10 slices')
INSERT INTO PizzaSize VALUES('Extra Large','18 inch with 12 slices')
SELECT * from PizzaSize

--DROP TABLE PizzaCrust
CREATE TABLE PizzaCrust(
PizzaCrustID Int IDENTITY(1,1) NOT NULL,
PizzaCrustDescription NVARCHAR(40) NOT NULL,
PizzaSizeID INT NOT NULL,
CrustPrice float,
CONSTRAINT [PK_PizzaCrust_PizzaCrustID] PRIMARY KEY CLUSTERED  (PizzaCrustID ASC),
CONSTRAINT FK_PizzaCrust_PizzaSize_PizzaSizeID FOREIGN KEY (PizzaSizeID)
        REFERENCES PizzaSize (PizzaSizeID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
INSERT INTO PizzaCrust VALUES('Thin crust',1,5.0)
INSERT INTO PizzaCrust VALUES('Thin crust',2,6.0)
INSERT INTO PizzaCrust VALUES('Thin crust',3,7.0)
INSERT INTO PizzaCrust VALUES('Thin crust',4,8.0)

INSERT INTO PizzaCrust VALUES('Thick crust',1,5.5)
INSERT INTO PizzaCrust VALUES('Thick crust',2,6.5)
INSERT INTO PizzaCrust VALUES('Thick crust',3,7.5)
INSERT INTO PizzaCrust VALUES('Thick crust',4,8.5)

INSERT INTO PizzaCrust VALUES('Stuffed crust',1,6)
INSERT INTO PizzaCrust VALUES('Stuffed crust',2,7)
INSERT INTO PizzaCrust VALUES('Stuffed crust',3,8)
INSERT INTO PizzaCrust VALUES('Stuffed crust',4,9)

SELECT * FROM PizzaCrust 


--DROP TABLE PizzaTopping
CREATE TABLE PizzaTopping(
PizzaToppingID INT IDENTITY(1,1) NOT NULL,
PizzaToppingDescription NVARCHAR(40) NOT NULL,
PizzaSizeID INT NOT NULL,
ToppingPrice float,
CONSTRAINT [PK_PizzaTopping_PizzaToppingID] PRIMARY KEY CLUSTERED  (PizzaToppingID ASC),
CONSTRAINT FK_PizzaSize_PizzaSizeID FOREIGN KEY (PizzaSizeID)
        REFERENCES PizzaSize (PizzaSizeID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

INSERT INTO PizzaTopping VALUES('Mushrooms',1,0.5)
INSERT INTO PizzaTopping VALUES('Mushrooms',2,1)
INSERT INTO PizzaTopping VALUES('Mushrooms',3,1.5)
INSERT INTO PizzaTopping VALUES('Mushrooms',4,2)


INSERT INTO PizzaTopping VALUES('Pineapple',1,0.5)
INSERT INTO PizzaTopping VALUES('Pineapple',2,1)
INSERT INTO PizzaTopping VALUES('Pineapple',3,1.5)
INSERT INTO PizzaTopping VALUES('Pineapple',4,2)

INSERT INTO PizzaTopping VALUES('Olives',1,0.5)
INSERT INTO PizzaTopping VALUES('Olives',2,1)
INSERT INTO PizzaTopping VALUES('Olives',3,1.5)
INSERT INTO PizzaTopping VALUES('Olives',4,2)

INSERT INTO PizzaTopping VALUES('Sausage',1,1)
INSERT INTO PizzaTopping VALUES('Sausage',2,1.5)
INSERT INTO PizzaTopping VALUES('Sausage',3,2)
INSERT INTO PizzaTopping VALUES('Sausage',4,2.5)

INSERT INTO PizzaTopping VALUES('Bacon',1,1)
INSERT INTO PizzaTopping VALUES('Bacon',2,1.5)
INSERT INTO PizzaTopping VALUES('Bacon',3,2)
INSERT INTO PizzaTopping VALUES('Bacon',4,2.5)

SELECT * FROM PizzaTopping 




CREATE TABLE PizzaType(
PizzaTypeID Int IDENTITY(1,1) NOT NULL,
PizzaTypeDescription NVARCHAR(40) NOT NULL,
CONSTRAINT [PK_PizzaType_PizzaTypeID] PRIMARY KEY CLUSTERED  (PizzaTypeID ASC)
)



ALTER FUNCTION dbo.GetCrustPrice(@size INT)
RETURNS FLOAT
AS 
BEGIN
	DECLARE @CrustPrice float;
   SELECT @CrustPrice=ISNULL(CrustPrice ,0)
   FROM PizzaCrust
   WHERE PizzaCrustID = @size
   RETURN @CrustPrice
END

ALTER FUNCTION dbo.GetToppingPrice(@size INT)
RETURNS FLOAT
AS 
BEGIN
	DECLARE @ToppingPrice float;
   SELECT @ToppingPrice=ISNULL(ToppingPrice ,0)
   FROM PizzaTopping
   WHERE PizzaToppingID = @size
   RETURN @ToppingPrice
END


-- DROP TABLE PIZZA
CREATE TABLE Pizza(
PizzaId INT IDENTITY(1,1) NOT NULL,
PizzaName NVARCHAR(40) NOT NULL,
PizzaSizeID INT NOT NULL,
PizzaCrustID INT NOT NULL,
PizzaTopping1 INT NOT NULL,
PizzaTopping2 INT NOT NULL,
PizzaTopping3 INT ,
PizzaTopping4 INT ,
PizzaTopping5 INT ,
CONSTRAINT [PK_Pizza_PizzaID] PRIMARY KEY CLUSTERED  (PizzaID ASC),
CONSTRAINT FK_Pizza_PizzaCrust_PizzaCrustID FOREIGN KEY (PizzaCrustID)
        REFERENCES PizzaCrust (PizzaCrustID),
CONSTRAINT FK_Pizza_PizzaSize_PizzaCrustID FOREIGN KEY (PizzaSizeID)
        REFERENCES PizzaSize (PizzaSizeID),
CONSTRAINT FK_Pizza_ToppingID1 FOREIGN KEY (PizzaTopping1)
        REFERENCES PizzaTopping (PizzaToppingID),
CONSTRAINT FK_Pizza_ToppingID2 FOREIGN KEY (PizzaTopping2)
        REFERENCES PizzaTopping (PizzaToppingID),
CONSTRAINT FK_Pizza_ToppingID3 FOREIGN KEY (PizzaTopping3)
        REFERENCES PizzaTopping (PizzaToppingID),
CONSTRAINT FK_Pizza_ToppingID4 FOREIGN KEY (PizzaTopping4)
        REFERENCES PizzaTopping (PizzaToppingID),
CONSTRAINT FK_Pizza_ToppingID5 FOREIGN KEY (PizzaTopping5)
        REFERENCES PizzaTopping (PizzaToppingID)
)
ALTER TABLE Pizza
ADD Price as (ISNULL(dbo.GetCrustPrice(PizzaCrustID),0)+ISNULL(dbo.GetToppingPrice(PizzaTopping1),0)+ISNULL(dbo.GetToppingPrice(PizzaTopping2),0)+ISNULL(dbo.GetToppingPrice(PizzaTopping3),0)
+ISNULL(dbo.GetToppingPrice(PizzaTopping4),0)+ISNULL(dbo.GetToppingPrice(PizzaTopping5),0))


INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Pizza',1,1,1,5,9)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Pizza',1,5,1,5,9)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Pizza',1,9,1,5,9)

INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',2,2,2,6,10)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',2,6,2,6,10)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',2,10,2,6,10)

INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',3,3,3,6,10)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',3,7,3,6,10)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',3,11,3,6,10)

INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',4,4,4,8,12)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',4,8,4,8,12)
INSERT INTO Pizza(PizzaName ,PizzaSizeID , PizzaCrustID, PizzaTopping1,PizzaTopping2,PizzaTopping3) VALUES('3 Toppings Vaggie Large',4,12,4,8,12)



select * from Pizza
Select * from PizzaCrust
Select  * from PizzaTopping

CREATE FUNCTION dbo.GetPizzaPrice(@size INT)
RETURNS FLOAT
AS 
BEGIN
	DECLARE @PizzaPrice float;
   SELECT @PizzaPrice=ISNULL(Price ,0)
   FROM Pizza
   WHERE PizzaID = @size
   RETURN @PizzaPrice
END


--DROP TABLE PizzaOrder
CREATE TABLE PizzaOrder(
PizzaOrderId INT IDENTITY(1,1) NOT NULL,
CustomerID INT NOT NULL,
StoreID INT NOT NULL,
OrderDateTime Datetime2,
OrderStatus NVARCHAR(10) ,
OrderServedDateTime Datetime2,
CONSTRAINT [PK_PizzaOrder_PizzaOrderId] PRIMARY KEY CLUSTERED  (PizzaOrderId ASC),
CONSTRAINT FK_PizzaOrder_Customer_CustomerID FOREIGN KEY (CustomerID)
        REFERENCES Customer (CustomerID),
CONSTRAINT FK_PizzaOrder_Store_StoreID FOREIGN KEY (StoreID)
        REFERENCES PizzaStore (StoreID)
)


INSERT INTO PizzaOrder(CustomerID ,StoreID , OrderDateTime,OrderStatus,OrderServedDateTime) 
VALUES(5,1,1,10,getdate(),'Placed', null)
INSERT INTO PizzaOrder(CustomerID ,StoreID , OrderDateTime,OrderStatus,OrderServedDateTime) 
VALUES(5,1,2,10,getdate(),'Placed', null)
INSERT INTO PizzaOrder(CustomerID ,StoreID , OrderDateTime,OrderStatus,OrderServedDateTime) 
VALUES(5,1,3,10,getdate(),'Placed', null)
INSERT INTO PizzaOrder(CustomerID ,StoreID , OrderDateTime,OrderStatus,OrderServedDateTime) 
VALUES(5,1,4,10,getdate(),'Placed', null)

CREATE TABLE PizzaOrderDetails(
PizzaOrderDetailID INT IDENTITY(1,1) NOT NULL,
PizzaOrderId INT ,
PizzaID INT NOT NULL,
PizzaQuantity INT NOT NULL,
OrderDate Datetime2,
OrderStatus NVARCHAR(10) ,
CONSTRAINT [PK_PizzaOrderDetail_PizzaOrderId] PRIMARY KEY CLUSTERED  (PizzaOrderId ASC),
CONSTRAINT FK_PizzaOrder_PizzaOrderDetail_PizzaOrderDetailID FOREIGN KEY (PizzaOrderID)
        REFERENCES PizzaOrder (PizzaOrderID),
CONSTRAINT FK_PizzaOrder_Pizza_PizzaID FOREIGN KEY (PizzaID)
        REFERENCES Pizza (PizzaID),
)
ALTER TABLE PizzaOrderDetails
ADD Price as (ISNULL(dbo.GetPizzaPrice(PizzaID),0))*ISNULL(PizzaQuantity,0)


Select * from PizzaOrder


ALTER PROCEDURE uspPlaceOrder
    @CustomerID INT,
    @StoreID INT,
	@PizzaID INT,
	@PizzaQuantity INT
AS

BEGIN

SET NOCOUNT ON;

DECLARE @OrderID INT,@Date Datetime2
SELECT @Date=getdate()

INSERT INTO PizzaOrder(CustomerID ,StoreID , OrderDateTime,OrderStatus,OrderServedDateTime) 
VALUES(@CustomerID,@StoreID,@Date,'Placed', NULL)

SELECT @OrderID=PizzaOrderId FROM  PizzaOrder where CustomerID=@CustomerID and StoreID=@StoreID and OrderDateTime=@Date and OrderStatus='Placed'

INSERT INTO PizzaOrderDetails(PizzaOrderId ,PizzaID ,PizzaQuantity ,OrderDate ,OrderStatus ) 
VALUES(@OrderID,@PizzaID,@PizzaQuantity,@Date,'Placed')

END

exec uspPlaceOrder     @CustomerID=6 ,
    @StoreID=1 ,
	@PizzaID=1 ,
	@PizzaQuantity =10

	Select * from PizzaOrder
	Select * from PizzaOrderDetails
