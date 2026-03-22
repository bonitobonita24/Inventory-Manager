# Product Definition
# ⚠️ THIS IS THE ONLY FILE YOU EDIT AS A HUMAN.
# Agents own everything else. To change anything — edit this file, then run Phase 7.
# V11: Wrap sensitive content in <private>...</private> to prevent agent propagation.

## App Name
Inventory Manager

## Connected Apps (if more than one)
none — single web app only

## Purpose
Inventory Manager is a simple internal web app for tracking product inventory for a single company. It helps staff manage products, supplier pricing, purchase orders, stock received, stock released, and current stock on hand without relying on spreadsheets. The app keeps inventory records accurate, supports optional serial number tracking, and makes it easier to monitor low-stock items and stock movement history. It is designed to stay simple, mobile-first, and practical for daily warehouse and purchasing operations.

## Target Users
- **Admin** — oversees the full inventory system, manages users, products, pricing, suppliers, purchase orders, adjustments, reports, and audit visibility.
- **Warehouse Staff** — handles day-to-day stock receiving and stock release, checks available inventory, and manages serial-tracked items during stock-in and stock-out.
- **Purchasing Staff** — manages suppliers, creates and updates purchase orders, monitors low-stock items, and records stock-in when deliveries are received.

## Core Entities
- **User** (id, name, email, password/auth identity, role, isActive, createdAt, updatedAt, lastLoginAt)
- **Product** (id, sku, name, category, unit, supplierCost, markupPercent, sellingPrice, currentQuantity, lowStockThreshold, serialTrackingEnabled, isActive, createdAt, updatedAt)
- **Supplier** (id, name, contactPerson, phone, email, address, notes, isActive, createdAt, updatedAt)
- **PurchaseOrder** (id, poNumber, supplierId, orderDate, expectedDate, status, notes, attachmentUrl, createdByUserId, createdAt, updatedAt)
- **PurchaseOrderItem** (id, purchaseOrderId, productId, orderedQty, receivedQty, supplierCostSnapshot)
- **StockIn** (id, referenceNumber, purchaseOrderId nullable, receivedDate, receivedByUserId, notes, attachmentUrl, createdAt)
- **StockInItem** (id, stockInId, productId, quantity, supplierCostSnapshot)
- **StockOut** (id, referenceNumber, releasedDate, releasedByUserId, requestedByName, usedFor, notes, printableSlipNumber nullable, createdAt)
- **StockOutItem** (id, stockOutId, productId, quantity, sellingPriceSnapshot nullable)
- **SerialNumber** (id, productId, serialValue, status: in_stock/issued/returned/adjusted, stockInItemId nullable, stockOutItemId nullable, createdAt, updatedAt)
- **StockAdjustment** (id, adjustmentDate, reason, notes, approvedByUserId, createdByUserId, createdAt)
- **StockAdjustmentItem** (id, stockAdjustmentId, productId, quantityDelta, serialNumberId nullable)
- **StockMovementLog** (id, productId, movementType: stock_in/stock_out/adjustment/return/manual_correction, referenceType, referenceId, quantityBefore, quantityDelta, quantityAfter, serialNumberId nullable, performedByUserId, performedAt, requestedByName nullable, usedFor nullable, notes, sourceModule)
- **AuditLog** (id, actorUserId, actionType, entityType, entityId, entityLabel, fieldChangesJson, beforeStateJson nullable, afterStateJson nullable, metadataJson nullable, ipAddress nullable, userAgent nullable, createdAt)
- **LowStockNotificationLog** (id, productId, notifiedToUserId, notificationType, sentAt, status)

## User Roles
- **admin**: full access to all modules and records. Can manage users, products, pricing, suppliers, purchase orders, stock in, stock out, stock adjustments, reports, exports, and system settings. Can see all company data, including supplier cost, markup, and selling price.
- **warehouse_staff**: can view products, categories, current stock, stock movement history, stock in, stock out, and serial-tracked inventory. Can record stock in and stock out. Can scan barcode/QR codes for serial-tracked items during stock in/out. Cannot manage users. Cannot create stock adjustments. Can see selling price if needed operationally, but cannot see supplier cost or markup percentage. Can see all company inventory records relevant to warehouse operations, not just their own.
- **purchasing_staff**: can manage suppliers and purchase orders, view products and current stock, record stock in, and monitor low-stock items for replenishment. Can see supplier cost, markup, and selling price. Cannot record stock out. Cannot create stock adjustments. Can see all company inventory records relevant to purchasing and replenishment, not just their own.

## Main Workflows (step-by-step)

### Workflow: Create product
1. Admin creates a new product and enters SKU, name, category, unit, supplier cost, markup %, low-stock threshold, and whether serial tracking is enabled.
2. System auto-calculates selling price from supplier cost and markup %.
3. Product is saved as active and becomes available for PO, stock-in, and stock-out transactions.
4. System writes an audit log for product creation, including actor, timestamp, and saved field values.
5. If required fields are missing or SKU already exists, system blocks save and shows a clear validation error.
6. If user cancels before saving, no product is created and no stock changes occur.

### Workflow: Edit product
1. Admin opens an existing product and changes allowed fields such as name, category, unit, pricing, low-stock threshold, active status, or serial-tracking setting.
2. System validates the update before saving.
3. System writes a full audit log entry showing who made the change, when it happened, which fields changed, and the before/after values.
4. If the update would break data integrity, system blocks save and shows the issue.
5. If user cancels before saving, no changes are applied.

### Workflow: Create purchase order
1. Admin or Purchasing Staff creates a PO and selects a supplier.
2. User adds one or more products and quantities, optional notes, and optional PO attachment.
3. PO starts in **Draft** status and can be updated before submission.
4. User moves PO to **Ordered** when sent to supplier.
5. When stock is received, linked receiving updates item received quantities and PO status moves to **Partially Received** or **Received** automatically.
6. User can mark PO as **Cancelled** if supplier order is voided before completion.
7. System logs PO creation, edits, status changes, attachment changes, and item-level quantity changes in the audit log.
8. If attachment upload fails, PO can still be saved without attachment and user is informed.
9. If user cancels before saving, no PO is created.

### Workflow: Record stock in
1. Admin, Warehouse Staff, or Purchasing Staff opens stock-in form.
2. User may link the stock-in to an existing PO or record it as a manual stock-in with a reference note.
3. User enters received date, received by, items, and quantities.
4. For serial-tracked products, user enters serial numbers manually or scans barcode/QR codes to capture exact serial entries faster and with fewer errors.
5. User may upload an optional delivery receipt or supporting file.
6. On save, system increases product quantities, creates serial records for serial-tracked items, and writes stock movement logs.
7. Each affected product gets its own movement log entry with quantity before, quantity added, quantity after, actor, timestamp, and reference source.
8. System also writes an audit log for the stock-in record itself and all associated items.
9. If linked to a PO, system updates received quantities and PO status automatically and logs those changes too.
10. If duplicate serial numbers are entered/scanned, system blocks save for those entries and tells the user which serials are invalid.
11. If file upload fails, stock-in can still continue without file if user chooses.
12. If transaction fails midway, no partial stock quantities should remain committed; operation must roll back cleanly.

### Workflow: Record stock out
1. Admin or Warehouse Staff opens stock-out form.
2. User enters released date, requested by, used for/purpose, optional notes, and selected products with quantities.
3. For serial-tracked products, user must select the exact serial numbers being released; manual selection and barcode/QR scan lookup are both allowed.
4. System checks available quantity before saving.
5. If quantity is insufficient, system blocks the transaction and shows the available stock.
6. On save, system decreases product quantities, marks selected serials as issued, creates stock movement logs, and stores requested-by and usage details for accountability.
7. Each affected product gets its own movement log entry with quantity before, quantity deducted, quantity after, actor, timestamp, requestor, purpose, and reference source.
8. System also writes an audit log for the stock-out record itself and all associated items.
9. User can print a simple stock-out slip after save.
10. If invalid or unavailable serial numbers are scanned/selected, system blocks save and shows which serials cannot be issued.
11. If user cancels before saving, no stock is deducted.

### Workflow: Create stock adjustment
1. Admin opens adjustment form when stock needs correction due to damage, loss, count mismatch, return handling, or manual correction.
2. Admin enters reason, notes, affected products, and positive or negative quantity delta.
3. For serial-tracked products, exact serial numbers must be selected if the adjustment affects specific units.
4. On save, system updates stock quantities, updates serial statuses if relevant, and writes stock movement logs.
5. Each affected product gets its own movement log entry with quantity before, quantity delta, quantity after, actor, timestamp, reason, and reference source.
6. Every adjustment records who created it and who approved it.
7. System writes a full audit log for the adjustment record and all item-level changes.
8. If the change would create invalid stock state or serial mismatch, system blocks save and shows the issue.

### Workflow: View product history and audit trail
1. User opens a product detail page.
2. System shows current product data, stock on hand, serial status if applicable, and full movement history for that product.
3. User can view every stock-in, stock-out, adjustment, return, manual correction, and quantity change affecting the product.
4. User can also view audit history for product field edits such as pricing, threshold, category, status, and serial-tracking setting.
5. User can filter history by date range, movement type, user, and reference number where applicable.
6. If user lacks permission for sensitive fields, system hides restricted pricing details while still showing allowed operational history.

### Workflow: Low stock handling
1. System continuously evaluates product current quantity against low-stock threshold.
2. Low-stock products appear in dashboard widgets and low-stock report views.
3. A daily background job checks all products below threshold.
4. System sends low-stock email summary to Admin and Purchasing Staff.
5. Notification activity is logged to avoid silent failures.
6. If email sending fails, job retries and logs the failure for review; dashboard alert remains visible even if email fails.

### Workflow: View reports and export
1. User opens dashboard or reports module.
2. System shows summary counts, low-stock items, stock movement history, and audit-related operational visibility where permitted.
3. User can filter reports by date range, product, category, supplier, movement type, or actor where applicable.
4. User can export supported reports to CSV.
5. System logs export actions for traceability.
6. If export fails, system shows an error and keeps the filtered report on screen without data loss.

## Realtime Features (if any)
none — no live realtime updates required in v1. Data refreshes on normal page reload or user action.

## Background Jobs (if any)
- **low-stock-daily-check** | trigger: daily scheduled job | checks all active products against low-stock threshold, builds low-stock summary, sends email notifications to Admin and Purchasing Staff, logs notification results | retry: 3 attempts with exponential backoff | DLQ required: no
- **failed-email-retry** | trigger: automatic when low-stock email send fails | retries notification delivery and records failure status if all retries fail | retry: 3 attempts with exponential backoff | DLQ required: no

## File Uploads (if any)
- Supported upload types:
  - PO attachment: PDF, DOCX, XLSX, JPG, PNG
  - Delivery receipt/supporting file: PDF, JPG, PNG
- Max size:
  - documents: 10 MB each
  - images: 5 MB each
- Store originals: yes
- Image variants needed: no
- Storage path pattern:
  - `purchase-orders/{poId}/{filename}`
  - `stock-in/{stockInId}/{filename}`

## Reporting & Dashboards (if any)
- Dashboard KPIs:
  - total active products
  - total current stock quantity
  - low-stock item count
  - stock-in count for selected period
  - stock-out count for selected period
  - inventory value based on supplier cost
- Reports:
  - low-stock report
  - stock movement report
  - current inventory report
  - product history report
  - audit trail report
- Chart types:
  - summary cards
  - bar chart for stock in vs stock out over time
  - table views for low stock, movement history, and audit history
- Export formats:
  - CSV only

## Mobile App (if any)
none — web only, but UI must be mobile-first responsive for phone and tablet browser use

## User-Facing URLs
Web app: https://inventory.yourdomain.com
Dev:     http://localhost:3000

Suggested route structure:
- `/login`
- `/dashboard`
- `/products`
- `/products/[id]`
- `/products/[id]/history`
- `/suppliers`
- `/purchase-orders`
- `/purchase-orders/[id]`
- `/stock-in`
- `/stock-out`
- `/adjustments`
- `/reports`
- `/audit-logs`
- `/users` (admin only)

## Access Control
Public routes (no login required):
- `/login`

Protected routes:
- all other routes require authenticated login

Role-specific restrictions:
- `/users` — admin only
- `/audit-logs` — admin only
- `/adjustments` — admin create/edit only; warehouse and purchasing may view only if permitted by UI policy
- supplier pricing fields (supplier cost, markup %) — admin and purchasing only
- stock-out creation — admin and warehouse only
- stock-in creation — admin, warehouse, and purchasing
- purchase order management — admin and purchasing only
- product history pages — admin, warehouse, and purchasing, but field visibility still follows role permissions

## Data Sensitivity
- Personal data stored:
  - employee/user names
  - email addresses
  - login credentials or auth identity records
  - names of people requesting stock-out items
  - login metadata such as last login timestamp and optional IP/user agent for audit purposes
- Business-sensitive data stored:
  - supplier pricing
  - markup percentages
  - selling prices
  - purchase history
  - stock movement history
  - audit trail history of record changes and user actions
- Retention policy:
  - core inventory, PO, stock movement, and audit records should be retained for at least 7 years unless business policy changes
  - inactive users may be disabled rather than deleted to preserve record integrity
  - uploaded documents follow the same retention period as related operational records
  - audit logs should be immutable and not editable by standard users
- Compliance requirements:
  - no special healthcare or payment compliance expected by default
  - basic privacy handling for names and emails
  - support GDPR-style deletion review only for user profile data if ever required, but operational audit records should remain preserved where legally allowed
- Audit log scope:
  - login events
  - logout events where available
  - failed login attempts where available
  - product creation and updates
  - product pricing changes
  - low-stock threshold changes
  - product active/inactive changes
  - supplier creation and updates
  - purchase order creation, edits, item changes, and status changes
  - stock-in transactions
  - stock-out transactions
  - stock adjustments
  - serial number create/update/status changes
  - user creation, disable/enable, role changes, and profile changes
  - deletions / deactivations
  - attachment upload/remove events
  - export actions for sensitive reports
  - notification send attempts and failures
  - all quantity-affecting product movement events with before/after values

## Security Requirements
- RBAC: role-based access control on every API endpoint (L3 — always active)
- AuditLog: immutable record on every data mutation and important user action (L5 — always active)
- Query guardrails: automatic data scoping on every DB query (L6 — always active)

Rate limiting:
- Public endpoints: 60 req/min per IP
- Authenticated endpoints: 300 req/min per user
- Upload endpoints: 10 uploads/min per user

Additional security expectations:
- session expiry and re-authentication required for protected routes
- file uploads must validate MIME type and size before storage
- serial number uniqueness enforced per product where serial tracking is enabled
- negative inventory is not allowed
- barcode/QR scan actions are input helpers only; scanned serials must still pass full validation before commit
- all inventory-affecting operations must write immutable stock movement entries
- all create/edit/delete/status-change operations on important entities must write immutable audit log entries with actor and timestamp
- audit logs must capture before/after values for changed fields where technically feasible
- audit logs must be searchable and filterable by date, user, entity, action, and reference number
- standard users cannot alter or delete audit history

## Tenancy Model
single

- Shared global data outside tenant boundaries: yes — all data belongs to one company and is intentionally shared within the company based on role permissions
- Roles: global (same across the company)

## Environments Needed
dev / stage / prod

## Domain / Base URL Expectations
Dev:   http://localhost:3000
Stage: https://stage.inventory.yourdomain.com
Prod:  https://inventory.yourdomain.com

## Infrastructure Notes
Default deployment is Docker Compose for app, database, queue/cache, and object storage in non-production environments. Production path may use PostgreSQL managed database, S3-compatible object storage, and Valkey-compatible cache/queue service. No multi-tenant or multi-warehouse infrastructure is required for v1. Email service is required in stage/prod for low-stock notifications. Audit and stock movement logs should be retained in the primary database with indexing for fast filtering by product, user, action type, and date.

## Tech Stack Preferences
Frontend framework:        Next.js
API style:                 tRPC
ORM / DB layer:            Prisma
Auth provider:             Auth.js (NextAuth v5)
Primary database:          PostgreSQL
Cache / queue:             Valkey + BullMQ
File storage:              MinIO (dev) / S3 (prod)
UI component library:      shadcn/ui + Tailwind CSS

## Design Identity
Brand feel:         professional/enterprise
Target aesthetic:   clean internal dashboard, simple and fast to use, mobile-first responsive layout
Industry category:  Operations / Inventory internal tool
Dark mode required: optional toggle
Key constraint:     mobile-first responsive layout