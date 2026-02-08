# 📦 Campaign Status Batch Optimizer

**Automated Life-Cycle Management for Marketing Campaigns**

This project provides a robust Apex Batch framework designed to automate the expiration process of Campaign records. It is built with scalability and error-handling best practices in mind, specifically for orgs with high data volumes.

---

## 🔧 Technical Highlights

- **Dynamic Querying:** Processes only relevant records using `EndDate <= YESTERDAY`, minimizing governor limits impact.
- **Configurable Architecture:** Utilizes **Custom Metadata Types (`AppConfig__mdt`)** for email recipients, allowing Admins to change settings without touching the code (Separation of Concerns).
- **Bulletproof Error Handling:** Implements Try-Catch blocks in both `execute` and `finish` methods to ensure partial successes don't crash the entire job.
- **Bulkified Logic:** Designed to handle thousands of records efficiently within Salesforce's multi-tenant architecture.

---

## 💡 Business Impact (The "Why?")

In large-scale Salesforce environments (Nonprofit, Marketing, or Finance), manual status updates are prone to human error and data decay. This solution:
- **Ensures Data Accuracy:** Reports and Dashboards always reflect the true state of active campaigns.
- **Operational Efficiency:** Saves Admin/Marketing teams hours of manual auditing every week.
- **Proactive Notification:** Sends an automated summary email upon completion, ensuring IT/Admins have visibility into system health.

---

## 🛠️ Performance & Scalability

This batch class is ready for Large Data Volumes (LDV). By using `Database.Batchable`, it bypasses heap size limits and can process up to 50 million records.
