# PRODUCT.md — Inventory Manager

> **IMPORTANT:** This is the ONLY file humans ever edit.
> Agents own all other files. See CLAUDE.md for full spec-driven platform rules.

---

## App Name
Inventory Manager

## Purpose
A comprehensive inventory management system for tracking products, stock levels, suppliers, and orders.

## Target Users
- Warehouse managers
- Inventory clerks
- Business owners

---

## Core Entities

### Product
- id: string (CUID)
- name: string
- sku: string (unique)
- description: string (optional)
- category: string
- unitPrice: number
- quantityInStock: number
- reorderLevel: number
- supplierId: string (FK)
- createdAt: DateTime
- updatedAt: DateTime

### Supplier
- id: string (CUID)
- name: string
- contactPerson: string
- email: string
- phone: string
- address: string
- isActive: boolean
- createdAt: DateTime
- updatedAt: DateTime

### StockMovement
- id: string (CUID)
- productId: string (FK)
- type: enum (IN | OUT | ADJUSTMENT)
- quantity: number
- reference: string (optional)
- notes: string (optional)
- createdAt: DateTime

### Category
- id: string (CUID)
- name: string
- description: string (optional)
- createdAt: DateTime
- updatedAt: DateTime

---

## User Roles
- **Admin**: Full access to all features
- **Manager**: Can manage products and view reports
- **Clerk**: Can view inventory and record stock movements

---

## Main Workflows

### 1. Product Management
- Create, read, update, delete products
- Set reorder levels
- Track stock quantities

### 2. Stock Movement Recording
- Record stock in (purchases)
- Record stock out (sales, damages)
- Adjustments with notes

### 3. Supplier Management
- Add and manage suppliers
- Track supplier contact information

### 4. Category Management
- Organize products into categories

### 5. Inventory Reports
- Low stock alerts
- Stock valuation
- Movement history

---

## Data Sensitivity
- Standard business data
- No PII requirements
- Basic authentication needed

---

## Tenancy Model
- **Mode**: Single tenant
- No multi-tenant features required
- All entities scaffolded with tenantId (nullable) for future upgrade

---

## Environments Needed
- Development
- Production

---

## Tech Stack Preferences
*(To be filled during Phase 2 interview)*

---

## Design Identity (Section K)
*(Optional — fill for automated design system generation)*
- Brand feel: [professional/enterprise | friendly/consumer | premium/luxury | technical/developer]
- Target aesthetic: [plain English description]
- Industry category: [e.g. SaaS, Healthcare, Fintech, E-commerce]
- Dark mode required: [yes / no / optional toggle]
- Key constraint: [e.g. WCAG AA / internal tool]

---

## Connected Apps
- Web app (primary)

---

## Infrastructure Requirements
- PostgreSQL database
- Valkey cache (optional)
- File storage (optional)

---

## Background Jobs
- Low stock alert notifications (optional)

---

## Security Requirements
- Session-based authentication
- Role-based access control (RBAC)
- Audit logging on mutations

