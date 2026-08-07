# Prism Backend

Enterprise FMCG Distribution ERP Backend built with **Node.js**, **Express.js**, **TypeScript**, **Prisma ORM**, and **PostgreSQL**.

Prism is a scalable backend system designed to manage the complete FMCG distribution workflow, including geographical hierarchy, user management, distribution points, authentication, audit logging, and operational reporting.

---

## Tech Stack

- Node.js
- Express.js
- TypeScript
- PostgreSQL
- Prisma ORM
- Better Auth
- Docker
- Zod Validation
- JWT & Session Authentication
- Nodemailer
- ESLint & Prettier

---

# Core Features

## Authentication & Authorization

- Email & Password Authentication
- Google OAuth Login
- Session Management
- OTP Verification
- Forgot Password
- Reset Password
- Secure Cookie Authentication
- Role Based Access Control (RBAC)
- Permission Middleware

---

## User Management

- Create Users
- Update Users
- Delete Users
- User Status Management
- User Profile Management
- Assign Roles
- Point Incharge Account Creation
- User Activity Tracking

---

## Organization Hierarchy

Manage complete geographical hierarchy.

```
Region
   ↓
Area
   ↓
Distribution House
   ↓
Territory
   ↓
Distribution Point
```

Supports

- Region Management
- Area Management
- Distribution House Management
- Territory Management
- Distribution Point Management

---

## Distribution Management

- Distribution Point Registration
- Territory Assignment
- Distribution House Mapping
- Permanent Assignment
- Active / Inactive Distribution Points

---

## Role Management

Supported Roles

- Super Admin
- Admin
- Managing Director
- Regional Manager
- Area Manager
- Territory Officer
- Business Manager
- Point Incharge
- Sales Representative

---

## Audit System

Complete Audit Logging System.

Tracks

- Create
- Update
- Delete
- Login
- Logout
- Password Change
- User Activity
- Resource Changes

Audit logs store

- User
- Action
- Resource
- Previous Data
- New Data
- Timestamp
- IP Address (Optional)

---

## Reporting

- User Reports
- Distribution Reports
- Hierarchy Reports
- Point Reports
- Activity Reports
- Audit Reports

---

## Validation

- Zod Schema Validation
- Request Validation Middleware
- Global Error Handling
- Custom Error Responses

---

## Security

- Password Hashing
- Secure Authentication
- Protected Routes
- Role Based Authorization
- Input Validation
- Environment Variable Protection
- HTTP Security Best Practices

---

## API Features

- RESTful API
- Pagination
- Filtering
- Searching
- Sorting
- Global Response Handler
- Centralized Error Handler
- Async Error Wrapper

---

## Database

Powered by PostgreSQL using Prisma ORM.

Features

- Relational Database Design
- One-to-One Relations
- One-to-Many Relations
- Foreign Key Constraints
- Soft Delete Ready
- Migration Support
- Seed Support

---

## Project Structure

```
src
├── app
│   ├── modules
│   ├── middlewares
│   ├── routes
│   ├── utils
│   ├── services
│   ├── errors
│   └── helpers
│
├── config
├── prisma
├── types
└── server.ts
```

---

# API Modules

- Authentication
- Users
- Regions
- Areas
- Distribution Houses
- Territories
- Distribution Points
- Audit Logs
- Reports

---

# Installation

```bash
git clone <repository-url>

cd prism-backend

bun install
```

or

```bash
npm install
```

---

# Environment Variables

Create a `.env` file.

```env
DATABASE_URL=

BETTER_AUTH_SECRET=
BETTER_AUTH_URL=

GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

SMTP_HOST=
SMTP_PORT=
SMTP_USER=
SMTP_PASS=

FRONTEND_URL=

NODE_ENV=
PORT=
```

---

# Database

Generate Prisma Client

```bash
bunx prisma generate
```

Run Migration

```bash
bunx prisma migrate dev
```

Seed Database

```bash
bun run seed
```

---

# Run Project

Development

```bash
bun run dev
```

Production

```bash
bun run start
```

---

# Design Principles

- Clean Architecture
- Modular Structure
- Scalable Folder Organization
- Separation of Concerns
- Enterprise Ready Design
- Maintainable Codebase

---

# Future Roadmap

- Sales Management
- Route Management
- Outlet Management
- Product Management
- Inventory Management
- Stock Ledger
- STT Management
- Memo Generation
- Order Management
- Delivery Tracking
- Dashboard Analytics
- Notification System
- File Upload Service
- Export PDF / Excel
- Real-time Activity Monitoring

---

# Status

🚧 Under Active Development

Prism is currently being developed as a complete Enterprise FMCG Distribution ERP solution with a focus on scalability, maintainability, and long-term business operations.

---

# License

Private Project

Copyright © Rafsun
