
# pg_fastbcp
A PostgreSQL extension to run the FastBCP tool from an SQL function, enabling fast data transfer between databases.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Method 1: Automated Installation](#method-1-automated-installation)
  - [Method 2: Manual Installation](#method-2-manual-installation)
- [SQL Setup](#sql-setup)
- [Function: xp_RunFastBcp_secure Usage](#function-xp_runfastbcp_secure-usage)
- [Function Return Structure](#function-return-structure)
- [Notes](#notes)

---

## Prerequisites
- Administrator privileges on Windows to copy files to the PostgreSQL installation directory.  
- Your **FastBCP tool binaries**. This extension requires the tool to be installed separately.

---

## Installation
This section covers the two ways to install the **pg_fastbcp** extension on Windows.

### Method 1: Automated Installation
The easiest way to install the extension is by using the `install-win.bat` script included in the archive.

1. Extract the contents of the ZIP file into a folder. This folder should contain the following files:  
   - `pg_fastbcp.dll`  
   - `pg_fastbcp.control`  
   - `pg_fastbcp--1.0.sql`  
   - `install-win.bat`  

2. Right-click on the `install-win.bat` file and select **"Run as administrator"**.  
3. The script will automatically detect your PostgreSQL installation and copy the files to the correct locations.

### Method 2: Manual Installation
If the automated script fails or you prefer to install the files manually, follow these steps:

1. Stop your PostgreSQL service. (**Critical step** to ensure files are not in use).  
2. Locate your PostgreSQL installation folder, typically found at:  
```

C:\Program Files\PostgreSQL\<version>

````
3. Copy the `pg_fastbcp.dll` file into the `lib` folder of your PostgreSQL installation.  
4. Copy the `pg_fastbcp.control` and `pg_fastbcp--1.0.sql` files into the `share\extension` folder.  
5. Restart your PostgreSQL service.  

---

## SQL Setup
After the files are in place, you need to set up the extension in your database.

### Drop existing extension (if any)
If you are updating the extension, drop the existing one first:

```sql
DROP EXTENSION IF EXISTS pg_fastbcp CASCADE;
````

### Create the extension

```sql
CREATE EXTENSION pg_fastbcp;
```

---

## Function: xp\_RunFastBcp\_secure Usage

This is the main function to execute the FastBCP tool. It takes various parameters to configure the data transfer operation.

### Windows example

This example demonstrates a transfer from an MSSQL source to a PostgreSQL target:

```sql
SELECT * FROM xp_RunFastBcp_secure(
  sourceconnectiontype := 'mssql',
  sourceserver := 'localhost',
  sourcepassword := 'MyWindowsPassword',
  sourceuser := 'FastLogin',
  sourcedatabase := 'tpch10',
  sourceschema := 'dbo',
  sourcetable := 'orders',
  targetconnectiontype := 'pgcopy',
  targetserver := 'localhost:15433',
  targetuser := 'postgres',
  targetpassword := 'MyPostgresPassword',
  targetdatabase := 'postgres',
  targetschema := 'public',
  targettable := 'orders',
  method := 'Ntile',
  degree := 12,
  distributekeycolumn := 'o_orderkey',
  fileoutput := 'D:\temp\orders.parquet'
);
```

---

## Function Return Structure

The function returns a table with the following columns, providing details about the execution:

| Column          | Type    | Description                                |
| --------------- | ------- | ------------------------------------------ |
| exit\_code      | integer | The exit code of the FastBCP process.      |
| output          | text    | The full log output from the FastBCP tool. |
| total\_rows     | bigint  | The total number of rows transferred.      |
| total\_columns  | integer | The total number of columns transferred.   |
| total\_time\_ms | bigint  | The total execution time in milliseconds.  |

---

## Notes

* The extension uses `pg_config` to locate PostgreSQL paths, so ensure it is available in your **PATH** if you are running the script.
* You must have sufficient permissions to copy files into the PostgreSQL installation directories.

