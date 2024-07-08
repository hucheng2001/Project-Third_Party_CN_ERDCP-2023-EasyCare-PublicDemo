# [EasyCare] Project-WorkforThirdParty-CN_ERDCP-2023-EasyCare-PublicDemo
A mobile application designed and developed using the `Flutter` framework combined with `GetX` technology and `sqflite` technology.
Fully leveraging modern state management and local database storage technologies, EasyCare is committed to providing a secure, convenient, and personalized user experience. Through innovative feature design and technical solutions, EasyCare combines relationship records and data privacy protection to provide users with a trustworthy and user-friendly electronic journal application.

## Permissions and Privacy
This repository is my personal development version of an earlier version of the project. Since the project has been transformed into a semi-commercial product, subsequent progress will not be made public, and the public version will be for learning purposes only, and will no longer be available for commercialization. (The repository has been edited and modified somewhat from the original project, and is being made public after review by the owner of the commercial project).


## I. Project Introduction
In the field of mobile application development, with increasing user concerns about data privacy and security, localized data storage and management are becoming more and more important.

When information between oneself and partners, relatives, or related client data is recorded on various platforms, it is necessary to consider whether such record storage solutions are safe and reliable.

If access to the address book is granted, contact information on the phone can be greatly misused. If a platform is compromised, data leaked, or even user data maliciously bought/sold/used, then these data will have no confidentiality at all.

Therefore, based on security needs, and taking into account the increasingly stringent privacy and security regulations in various countries and regions, we designed and developed this application.


## II. Technical Introduction
In addition to some commonly used component introductions, EasyCare mainly uses `GetX` technology and `sqflite` technology.
### GetX
`GetX` is a lightweight and high-performance Flutter state management tool that also provides features such as route management and dependency injection.
Its main features include:
- **Simple and Efficient**: GetX is simple to use with minimal code, significantly boosting development efficiency.
- **Reactive State Management**: Through widgets like Obx and GetBuilder, state updates and UI refresh can be easily achieved, avoiding cumbersome setState operations.
- **Dependency Injection**: GetX integrates dependency injection, making it easy to manage various dependencies in the application.
- **Powerful Route Management**: GetX provides a user-friendly route management system supporting named routes, parameter passing, and more.

### sqflite
`sqflite` is a lightweight SQLite plugin in Flutter used for creating and performing read/write operations on local databases. It is the core of offline storage in this project.
Its main features include:
- **Lightweight and Fast**: Based on SQLite, sqflite offers high-performance database operations suitable for mobile applications.
- **Asynchronous Operations**: sqflite supports asynchronous database operations to avoid blocking the UI thread and improve application smoothness.
- **Data Security**: Storing data in a local database enhances user privacy protection, mitigating security risks associated with sensitive data transmission over networks.

## III. Innovation & Implement
EasyCare's inspiration comes from the need for relationship records by users, combining scenarios for reminding notes between couples and maintaining customer relationships.
### Design of Account Isolation
Although it is an offline application, account registration and login are still designed to isolate data using accounts. Even if someone gains access to the phone without knowing the account password, they cannot access relevant data, and there are multiple layers of accounts for masking.

![login](https://github.com/hucheng2001/Project-Third_Party_CN_ERDCP-2023-EasyCare-PublicDemo/assets/55477525/05b5e009-c21b-42ec-be96-3f4b5e3b55ad)
![create](https://github.com/hucheng2001/Project-Third_Party_CN_ERDCP-2023-EasyCare-PublicDemo/assets/55477525/0b19456f-b086-4987-af2b-aa98f02483b3)
![call](https://github.com/hucheng2001/Project-Third_Party_CN_ERDCP-2023-EasyCare-PublicDemo/assets/55477525/2376f8c8-24c0-4875-894b-03072da5867f)



### Calculation and Prediction of Physiological Cycles
The offline physiological cycle recording and prediction feature becomes more accurate as data is recorded, incorporating a certain mathematical calculation logic (smoothing prediction method).

![period](https://github.com/hucheng2001/Project-Third_Party_CN_ERDCP-2023-EasyCare-PublicDemo/assets/55477525/1d1e4fa3-2850-40bc-8af6-fd3ea852abde)


### Design Similar to Instagram/WeChat Moments
Detailed items can be recorded here, with a periodic reminder function. As the deadline approaches, reminders will be displayed on the homepage three days in advance.

![event_1720439426](https://github.com/hucheng2001/Project-Third_Party_CN_ERDCP-2023-EasyCare-PublicDemo/assets/55477525/89a0225d-f144-47c2-8498-c231d023e3e6)
![tip_1720439436](https://github.com/hucheng2001/Project-Third_Party_CN_ERDCP-2023-EasyCare-PublicDemo/assets/55477525/ba80299e-6266-4daf-8711-18e88da0eca9)


### Memo To-Do Function
For maintaining customer relationships, orderly recording of to-do items around customers is essential.


## IV. Innovative Points of Technical Solutions
In terms of technical solutions, EasyCare has the following innovative points:
- **Optimized State Management**: GetX simplifies state management logic, enhancing project code readability and maintainability. Projects with similar structures are easier to develop, and related components are more reusable.
- **Local Database Storage**: Leveraging sqflite for local database storage ensures data security and privacy protection.

## V. Relevant Tests
A series of tests were conducted on various functionalities of the application, summarized briefly as follows:

Local Cache Testing: Given that the application utilizes the sqflite database and associated local cache storage, conventional data sets were used for testing to ensure smooth storing and retrieval of data without any anomalies.

Query Performance Testing: Queries in the application are implemented based on SQL statements. Simple tests were carried out on data queries across multiple page modules, confirming that actions like insertion, deletion, modification, and retrieval were all executed without any issues.

Menstrual Cycle Prediction Accuracy Testing: The prediction method is based on mathematical moving average forecasting. Several women were invited to participate in using the feature, which could accurately predict their menstrual cycles and provide dietary reminders.

## VI. Expansion Directions
Apart from the aforementioned functionalities, EasyCare still has room for significant improvements in the following directions:
- **Data Backup Functionality**: The current offline storage does not support backup export. Consider adding encrypted export and import, as well as WebDAV storage solutions.
- **UI Refine**: Design the UI to be more user-friendly and aesthetically pleasing.
- **Smart Reminders**: The algorithms for predicting physiological cycles and event reminders are somewhat mechanical. Consider training simple models to optimize reminder logic.
- **Customer Relationship Prediction**: Consider adding customer transaction records, training models to reach transactions based on different customer data and transaction records, and improving transaction rates through effective adjustment strategies.
