SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";




-- Create database if it doesn't exist

-- CREATE DATABASE IF NOT EXISTS BB;


-- USE BB;

-- Table for storing users
CREATE TABLE IF NOT EXISTS Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,

    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB date NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
) ENGINE=InnoDB;

-- Table for storing donor information
CREATE TABLE IF NOT EXISTS Donors (
    DonorID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    BloodGroup ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL,
    MedicalHistory TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
) ENGINE=InnoDB;

-- Table for storing blood donation campaigns
CREATE TABLE IF NOT EXISTS Campaigns (
    CampaignID INT PRIMARY KEY AUTO_INCREMENT,
    CampaignName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Date DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL
  
) ENGINE=InnoDB;

-- Table for storing blood donations
CREATE TABLE IF NOT EXISTS Donations (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    DonorID INT,
    CampaignID INT,
    DonationDate DATE NOT NULL,
    FOREIGN KEY (DonorID) REFERENCES Donors(DonorID),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID)
) ENGINE=InnoDB;

-- Table for managing blood inventory
CREATE TABLE IF NOT EXISTS Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    BloodGroup ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    UnitsAvailable INT NOT NULL,
    ExpiryDate DATE,
    SourceCampaignID INT,
    FOREIGN KEY (SourceCampaignID) REFERENCES Campaigns(CampaignID)
) ENGINE=InnoDB;

-- Table for storing blood requisitions
CREATE TABLE IF NOT EXISTS Requisitions (
    RequisitionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    BloodGroup ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    Quantity INT NOT NULL,
    Status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    RequestDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ApprovalDate TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
) ENGINE=InnoDB;


