# CS425 Project

## Overview
An ecommerce database system with user interface.
App Static Link: [https://ppttzhu.github.io/cs425project/](https://ppttzhu.github.io/cs425project/)

## Workflow
1. Generate Database in AWS RDS (See [SQL](https://github.com/ppttzhu/cs425project/tree/master/SQL))
2. Write Java code to fetch data from AWS RDS (See [JDBC](https://github.com/ppttzhu/cs425project/tree/master/JDBC))
3. Upload Java code to AWS Lambda
4. Add Lambda in AWS API Gateway as a resourse
5. Use Vue.axios to write GET/PUT method in API (See [UI](https://github.com/ppttzhu/cs425project/tree/master/UI))
7. Sync docs/ folder to github and host this webpage by github

![Image of DatabaseProcess](https://github.com/ppttzhu/cs425project/blob/master/process.jpg)

## Prerequisites
- Terminal
- Postgresql: Connect to AWS RDS
- Java
- Eclipse: Java editor (Optional)
- npm
- Vue
- Visual Studio Code: Vue editor (Optional)

## ER-diagram
![ER-diagram](https://github.com/ppttzhu/cs425project/blob/master/ER-Diagram.jpg?raw=true)

## Website Screenshots
Product List
![AccountInformation](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/ProductList.png?raw=true)
Login
![Login](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/Login.png?raw=true)
Register
![Register](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/Register.png?raw=true)
Shopping Cart
![ShoppingCart](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/ShoppingCart.png?raw=true)
Account Information
![AccountInformation](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/AccountInformation.png?raw=true)
My Order
![MyOrder](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/MyOrder.png?raw=true)
Management - Statistics
![Statistics](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/Statistics.png?raw=true)
Management - Replenish Warehouse
![Warehouse](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/Warehouse.png?raw=true)
Management - Replenish Store
![Store](https://github.com/ppttzhu/cs425project/blob/master/UI/screenshots/Store.png?raw=true)

## Contributions
- **Yixin**: Developed database schema, functions, API and website.
- **Chen**: Developed database view, prepared datasets.
- **Sihan**: Tested database and website.

