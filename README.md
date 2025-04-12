# 📦 Campaign Status Batch – Salesforce Apex Project

This Apex batch class automatically marks `Campaign` records as `"Expired"` if their `EndDate` has passed.

---

## 🔧 Functionality

- Queries all Campaigns where `EndDate <= YESTERDAY` and `Status != 'Expired'`
- Updates their Status to `"Expired"`
- Sends a completion email using a Custom Metadata Type (`AppConfig__mdt`)
- Error handling in both `execute` and `finish` methods

---

## 💡 Use Case

This batch job is useful in scenarios where campaign timelines need to be managed automatically. For example:
- In nonprofit organizations tracking fundraising drives
- In educational platforms managing term-based programs
- In marketing teams managing time-bound promotions

Even if there are no campaigns ending on a given day, running the batch daily ensures no records are missed.

---

## 🧪 Test Coverage

The included test class:
- Uses `@testSetup` to create reusable test data
- Ensures that eligible records are marked as `"Expired"`
- Confirms batch execution logic runs without errors

---

## 📁 Project Structure

| File | Description |
|------|-------------|
| `CampaignUpdateBatch.cls` | Main batch class |
| `CampaignUpdateBatchTest.cls` | Unit test class |
| `CampaignUpdateScheduler.cls` | Scheduler to run the batch |
| `AppConfig__mdt` | Custom Metadata for notification email |

---

## ⚙️ Prerequisites

Before running this batch, make sure:
- A Custom Metadata record named `Default` exists in `AppConfig__mdt`
- A valid email address is set in `Notification_Email__c`

---

## 👤 Author

**Aysun Bilgiç**  
Salesforce Developer / Admin  
[LinkedIn](https://www.linkedin.com/in/aysunbilgic) *(optional)*
