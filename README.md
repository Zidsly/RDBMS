# Autonomous Vehicle Administration System (AVERSOT)

## Overview
The **Autonomous Vehicle Administration System** (AVERSOT) is a backend system designed for managing autonomous vehicles in the online transportation sector. The system utilizes an SQL-based relational database to handle various tasks, including vehicle registration, transaction processing, destination management, and vehicle health checks. The autonomous vehicles in this system operate without drivers and rely on sensors, Artificial Intelligence (AI), and Machine Learning (ML) for navigation and operation.

## Project Summary
In this project, we present a comprehensive database structure and backend system for the **Autonomous Vehicle Administration System (AVERSOT)**. The database system is designed to support the autonomous transportation network by managing:

- Vehicle and user data
- Destination management
- Vehicle maintenance and health checks
- Transaction history and pricing

The key components of the system include:

- **ERD** (Entity-Relationship Diagram)
- **Database Design**
- **Schematic Diagrams**
- **Table Design**
- **Validation Procedures**

## Database Design

### Database Name: `AVRS`
The **AVRS** database is composed of **6 tables** and **12 stored procedures** designed to efficiently manage the autonomous vehicle data and its related functionalities.

### Tables

1. **XUSER** - Stores user details and authentication information.
2. **Vehicle** - Contains vehicle information and specifications.
3. **Destination** - Holds information regarding various destinations for autonomous vehicles.
4. **Vcheckup** - Manages vehicle maintenance and health check records.
5. **Vprice** - Stores pricing details for vehicle trips.
6. **Vtransaction** - Tracks transaction details for rides and other operations.

### Stored Procedures

1. **Input** - General input procedure for managing data entry.
2. **AddNewUser** - Adds a new user to the system.
3. **AddNewVehicle** - Registers a new autonomous vehicle.
4. **AddNewDestination** - Adds a new destination for the vehicles to reach.
5. **AddNewVcheckup** - Logs a new vehicle health check.
6. **AddVtransaction** - Records a new transaction (e.g., a trip).
7. **Display_Xuser** - Displays all user records.
8. **Display_NewVehicle** - Displays newly added vehicles.
9. **Display_Destination** - Shows all available destinations.
10. **Display_Vcheckup** - Displays the vehicle health check logs.
11. **Display_Vprice** - Displays pricing information for trips.
12. **Display_Vtransaction** - Displays all transaction records.

## Tools & Tech Stack

- **Microsoft SQL Server** - Database management system.
- **Figma** - Used for creating schematic diagrams and UI/UX designs.
- **Microsoft Excel** - Used for data analysis and documentation.

## Features

- **Autonomous Vehicle Management**: Register and manage vehicles within the system.
- **User Management**: Add and manage users of the system, enabling authentication and data access.
- **Vehicle Health Monitoring**: Keep track of regular vehicle maintenance and health checkups.
- **Destination Management**: Add and display various destinations for autonomous vehicles.
- **Transaction Tracking**: Record and display transactions such as ride bookings and payments.
- **Pricing Management**: Manage and display dynamic pricing for vehicle rides.


