# RuralEdu Track - Sprint #2 Project Plan

## 1. Problem Statement & Solution Overview
**Problem:** Rural coaching centers often rely on manual paper-based logs to track student attendance and academic progress. This leads to data loss, difficulty in searching records, and an inability to provide parents with timely updates on student performance.

**Solution:** **RuralEdu Track** is a mobile-first solution built with Flutter and Firebase. It provides a simple, reliable interface for teachers to manage student data. By utilizing Firebase's offline persistence, the app remains functional in low-connectivity areas, syncing data to the cloud whenever a connection is restored.

**Checklist:**
* **Users:** Teachers and Administrators of rural coaching centers.
* **Relevance:** Digital literacy is rising, but infrastructure remains inconsistent; a mobile app bridges this gap.
* **Impact:** Simplifies record-keeping from hours to minutes and provides data-driven insights into student growth.

## 2. Scope & Boundaries
* ✅ **In Scope:** Firebase Authentication (Teacher login), Firestore Database (Student profiles, daily attendance, exam marks), Responsive UI for mobile/tablets, Offline data persistence.

## 3. Roles & Responsibilities
| Role | Responsibility |
| :--- | :--- |
| **UI & Mobile Interface Lead** | Designs wireframes, builds Flutter UI screens, implements responsive layouts and themes |
| **Firebase & Backend Lead** | Sets up Firebase project, implements Auth, Firestore CRUD, security rules |
| **Integration & Deployment Lead** | Connects UI with Firebase, manages state, handles testing, builds release APK |

## 4. Sprint Timeline (4 Weeks)
| Week | Focus Area | Milestones / Deliverables |
| :--- | :--- | :--- |
| **Week 1** | **Setup & Design** | Flutter SDK & Firebase setup, UI wireframes, and basic folder structure. |
| **Week 2** | **Core Auth & UI** | Email/Password login, Home Dashboard, and "Add Student" forms. |
| **Week 3** | **Data Integration** | Firestore integration for Attendance and Marks tracking; implementing real-time listeners. |
| **Week 4** | **MVP & Deployment** | Error handling, offline persistence testing, UI polish, and APK generation. |

## 5. MVP (Minimum Viable Product)
* **Authentication:** Secure Sign In/Out for teachers.
* **Student Management:** Create and edit student profiles.
* **Attendance:** A daily checklist to mark student presence.
* **Academic Tracker:** Simple form to input marks for specific subjects.
* **Performance View:** A basic dashboard showing attendance percentages.

## 6. Functional Requirements
* Teachers must be able to register and log in securely via Firebase Auth.
* Student records must be stored and retrieved from Cloud Firestore.
* The app must allow marking attendance for any selected date.
* The system must calculate and display average marks per student.

## 7. Non-Functional Requirements
* **Offline Capability:** Must allow data entry without internet, syncing later via Firestore's local cache.
* **Simplicity:** Minimalist UI to ensure ease of use for non-tech-savvy users.
* **Responsiveness:** Layouts must adapt to both small smartphones and larger tablets.
* **Security:** Use Firestore Security Rules to ensure teachers only access their own center's data.

## 8. Success Metrics
* 100% functional CRUD operations for students and attendance.
* Successful data sync verified after switching from airplane mode to online.
* Zero crashes during the final UAT (User Acceptance Testing) on a physical Android device.
* Project successfully built into a release-ready APK.
