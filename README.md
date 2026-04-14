# 🏥 Healgo – Healthcare Booking System

Healgo is a full-stack healthcare appointment booking system where patients can book services and providers (doctors) can manage their appointments.

---

## 📂 Project Structure

```
backend/   → Spring Boot Backend (Java)
healgo/    → Flutter Frontend App
```

---

## 🚀 Features

### 👤 Patient Side (Flutter - healgo)

* View available doctors
* Select service (Home Nursing / Care Taker)
* Choose date & time slot
* Book appointment
* Real-time slot availability

### 🧑‍⚕️ Provider Side

* View appointments:

  * 🆕 New
  * ✅ Confirmed
  * 📜 History
* Accept or Reject appointments

---

## 🛠️ Tech Stack

### Frontend (healgo folder)

* Flutter (Dart)
* HTTP API integration
* SharedPreferences

### Backend (backend folder)

* Spring Boot (Java)
* REST APIs
* JPA / Hibernate

### Database

* MySQL

---

## ⚙️ Setup Instructions

---

### 🔧 Backend Setup (backend folder)

1. Open `backend` folder
2. Configure database in `application.properties`

```
spring.datasource.url=jdbc:mysql://localhost:3306/healgo
spring.datasource.username=root
spring.datasource.password=yourpassword
```

3. Run backend:

```
mvn spring-boot:run
```

---

### 📱 Frontend Setup (healgo folder)

1. Open `healgo` folder
2. Install dependencies:

```
flutter pub get
```

3. Run app:

```
flutter run
```

---

## 🔗 API Endpoints

| Method | Endpoint                        | Description               |
| ------ | ------------------------------- | ------------------------- |
| GET    | /api/doctors                    | Get all doctors           |
| GET    | /api/slots                      | Get available slots       |
| POST   | /api/book                       | Book appointment          |
| GET    | /api/provider-appointments/{id} | Get provider appointments |
| PUT    | /api/update-status              | Update appointment status |

---

## 🔄 System Flow

Patient selects doctor → selects slot → books appointment
→ Backend stores provider_id
→ Provider logs in → sees only their appointments

---

## 💡 Key Learnings

* Full-stack development (Flutter + Spring Boot)
* REST API integration
* Database management (MySQL)
* Real-world debugging (ID mapping issue solved)
* UI design in Flutter

---

## 🔮 Future Improvements

* JWT Authentication
* Notifications
* Payment Integration
* Admin Dashboard

---

## 👨‍💻 Author

Piyush

---

## ⭐ Support

Give a ⭐ if you like this project!
