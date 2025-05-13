-- Inventory Tracking Database Schema

-- Table: Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(150) NOT NULL UNIQUE,
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- Table: Items
CREATE TABLE Items (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(150) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0),
    QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),
    UNIQUE(ItemName, SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Table: Warehouses
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY AUTO_INCREMENT,
    WarehouseName VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(255)
);

-- Table: InventoryMovements
CREATE TABLE InventoryMovements (
    MovementID INT PRIMARY KEY AUTO_INCREMENT,
    ItemID INT NOT NULL,
    WarehouseID INT NOT NULL,
    MovementDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    QuantityChange INT NOT NULL,
    Notes VARCHAR(255),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Table: OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    UNIQUE(OrderID, ItemID)
);


CREATE TABLE WarehouseItems (
    WarehouseID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    PRIMARY KEY (WarehouseID, ItemID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);