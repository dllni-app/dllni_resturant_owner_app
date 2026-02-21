# API Contract – Restaurant Seller Homepage

**Audience:** Frontend / Flutter developer  
**Domain:** `dllni.mustafafares.com`  
**Scope:** Endpoints required for the restaurant seller homepage dashboard. For full Restaurant CRUD, Auth, or other modules, see the respective API contract docs.

---

## 1. Base URL and authentication

- **Base URL:** `https://dllni.mustafafares.com`
- **API prefix:** `https://dllni.mustafafares.com/api/v1/`
- **Auth:** Laravel Sanctum. Send token on every request:
  - Header: `Authorization: Bearer {token}`
- **Content-Type:** `application/json` for request bodies; responses are JSON.

---

## 2. Homepage data flow

The seller homepage displays:

1. **Today's overview** – total sales, order counts, low stock alerts, order activity chart
2. **New orders** – pending orders (accept/reject)
3. **Orders in preparation** – orders being prepared
4. **Quick actions** – Reports, Add Product, Offers, New Order

All data is scoped by `restaurantId`. The seller must know which restaurant they are managing (e.g. from user profile, role, or app state).

---

## 3. Endpoints

### 3.1 Dashboard overview (single request for KPIs)

| Method | Path                                    | Description                                                                 |
| ------ | --------------------------------------- | --------------------------------------------------------------------------- |
| GET    | `/api/v1/restaurant/dashboard/overview` | KPIs for today: sales, order counts, low stock, order activity by hour      |

**Query params:**

| Param         | Type   | Required | Description                    |
| ------------- | ------ | -------- | ------------------------------ |
| restaurantId  | integer| Yes      | Restaurant ID (exists:restaurants,id) |

**Example request:**

```
GET https://dllni.mustafafares.com/api/v1/restaurant/dashboard/overview?restaurantId=1
```

**Response (200):**

```json
{
  "kpis": {
    "todayTotalSales": 12450,
    "yesterdayTotalSales": 10826,
    "salesChangePercent": 15,
    "todayOrders": 188,
    "ordersByStatus": {
      "pending": 24,
      "accepted": 0,
      "preparing": 8,
      "completed": 156,
      "cancelled": 0,
      "readyForPickup": 0,
      "pickedUp": 0
    },
    "activeRestaurants": 1,
    "openDisputes": 2,
    "ordersPendingPickup": 4,
    "ordersReadyForPickup": 4,
    "lowStockAlertsCount": 1,
    "orderActivityByHour": [
      { "hour": 10, "count": 12 },
      { "hour": 11, "count": 18 },
      { "hour": 12, "count": 25 }
    ],
    "lowStockProducts": [
      {
        "id": 1,
        "name": "Product name",
        "stockQuantity": 5,
        "lowStockThreshold": 5
      }
    ]
  }
}
```

| Field                 | Type   | Description                                                                 |
| --------------------- | ------ | --------------------------------------------------------------------------- |
| todayTotalSales       | number | Sum of completed orders today (currency units)                             |
| yesterdayTotalSales   | number | Sum of completed orders yesterday                                           |
| salesChangePercent    | number | Percent change vs yesterday (e.g. 15 = +15%)                               |
| todayOrders           | number | Total orders created today                                                  |
| ordersByStatus        | object | Count per status: pending, accepted, preparing, completed, cancelled, etc.  |
| lowStockAlertsCount   | number | Number of products at or below low stock threshold                         |
| orderActivityByHour   | array  | `{ hour, count }` – orders per hour (0–23) for today                       |
| lowStockProducts      | array  | Top 10 low-stock products (id, name, stockQuantity, lowStockThreshold)      |

---

### 3.2 New orders (pending)

| Method | Path             | Description                          |
| ------ | ---------------- | ------------------------------------ |
| GET    | `/api/v1/orders` | List orders (paginated)              |

**Query params:**

| Param                    | Type    | Description                                      |
| ------------------------ | ------- | ------------------------------------------------ |
| filter[restaurantId]     | integer | Required. Scope to seller's restaurant           |
| filter[status]           | string  | `pending` for new orders                         |
| filter[createdToday]     | boolean | `true` to limit to orders created today          |
| perPage                  | integer | 1–100, default 20                                |
| page                     | integer | Page number, default 1                           |

**Example request:**

```
GET https://dllni.mustafafares.com/api/v1/orders?filter[restaurantId]=1&filter[status]=pending&filter[createdToday]=true&perPage=10
```

**Response (200):** Standard paginated collection. Each order includes `user`, `restaurant`, `orderItems` (with `product.id`, `product.name`), `totalAmount`, `status`, `createdAt`, etc.

---

### 3.3 Orders in preparation

| Method | Path             | Description                          |
| ------ | ---------------- | ------------------------------------ |
| GET    | `/api/v1/orders` | List orders (paginated)              |

**Query params:**

| Param                    | Type    | Description                                      |
| ------------------------ | ------- | ------------------------------------------------ |
| filter[restaurantId]     | integer | Required. Scope to seller's restaurant           |
| filter[status]           | string  | `preparing` for orders in preparation             |
| perPage                  | integer | 1–100, default 20                                |

**Example request:**

```
GET https://dllni.mustafafares.com/api/v1/orders?filter[restaurantId]=1&filter[status]=preparing
```

---

### 3.4 Low stock products (full list)

| Method | Path               | Description                          |
| ------ | ------------------ | ------------------------------------ |
| GET    | `/api/v1/products`| List products (paginated)           |

**Query params:**

| Param                    | Type    | Description                                      |
| ------------------------ | ------- | ------------------------------------------------ |
| filter[restaurantId]     | integer | Required. Scope to seller's restaurant           |
| filter[lowStock]         | boolean | `true` for products at or below threshold         |
| perPage                  | integer | 1–100, default 20                                |

**Example request:**

```
GET https://dllni.mustafafares.com/api/v1/products?filter[restaurantId]=1&filter[lowStock]=true
```

---

### 3.5 Accept order

| Method | Path                         | Description                    |
| ------ | ---------------------------- | ------------------------------ |
| POST   | `/api/v1/orders/{id}/accept` | Accept a pending order         |

**Path params:** `id` – order ID

**Request body:** None

**Response (200):**

```json
{
  "data": {
    "id": 123,
    "status": "accepted",
    "acceptedAt": "2025-02-21T14:30:00.000000Z",
    "user": { "id": 1, "name": "...", "email": "..." },
    "orderItems": [
      {
        "id": 1,
        "quantity": 2,
        "product": { "id": 5, "name": "Product name" }
      }
    ],
    ...
  },
  "message": "Order accepted successfully."
}
```

---

### 3.6 Reject order

| Method | Path                         | Description                    |
| ------ | ---------------------------- | ------------------------------ |
| POST   | `/api/v1/orders/{id}/reject` | Reject a pending order         |

**Path params:** `id` – order ID

**Request body:** None

**Response (200):**

```json
{
  "data": {
    "id": 123,
    "status": "cancelled",
    "cancelledAt": "2025-02-21T14:30:00.000000Z",
    "cancellationReason": "Rejected by seller",
    ...
  },
  "message": "Order rejected successfully."
}
```

---

### 3.7 Quick actions (reference)

| Action        | Endpoint                          | Method |
| ------------- | --------------------------------- | ------ |
| Reports       | `/api/v1/restaurant/analytics/daily-stats`   | GET    |
| Reports       | `/api/v1/restaurant/analytics/monthly-stats`| GET    |
| Add Product   | `/api/v1/products`                | POST   |
| Offers        | `/api/v1/offers`                  | POST   |
| New Order     | `/api/v1/orders`                  | POST   |

See [API_CONTRACT_RESTAURANTS.md](API_CONTRACT_RESTAURANTS.md) for request/response schemas.

---

## 4. Order status values

Use these when filtering or displaying status:

| Value           | Description        |
| --------------- | ------------------ |
| `pending`       | New, awaiting accept/reject |
| `accepted`       | Accepted by seller |
| `preparing`     | In preparation     |
| `ready_for_pickup` | Ready for pickup |
| `picked_up`     | Picked up          |
| `completed`     | Completed          |
| `cancelled`     | Cancelled/rejected |

---

## 5. Error responses

- **401 Unauthorized:** Missing or invalid token. Redirect to login.
- **422 Unprocessable Entity:** Validation errors (e.g. invalid `restaurantId`). Body includes `errors` object.
- **404 Not Found:** Order or resource not found.
- **403 Forbidden:** User not allowed to access the resource.
