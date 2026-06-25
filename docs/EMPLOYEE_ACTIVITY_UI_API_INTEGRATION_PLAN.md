# Employee Activity Screen UI/API Integration Plan

## 1. Goal

Implement the `سجل نشاط الموظفين` screen as a real API-powered activity log feature instead of static cards.

The current screen shows three static categories:

- `قبول الطلبات`
- `تحديث المخزون`
- `العروض والكوبونات`

The required result is:

1. Keep the current Arabic visual direction and card style.
2. Add API integration for store-owner activity logs.
3. Let the owner open each category and view paginated activity records.
4. Keep the existing `إدارة الموظفين` button and navigation to employee management.
5. Follow the existing app architecture: `data/source` -> `data/repository` -> `domain/repository` -> `domain/usecases` -> `view/manager/bloc` -> `view/screens/widgets`.

---

## 2. Backend API Contract

### Endpoint

```http
GET /api/v1/store-owner/activity-logs
Authorization: Bearer {token}
Accept: application/json
```

### Query Parameters

| Parameter | Type | Required | Notes |
|---|---:|---:|---|
| `logName` | string | No | One of `products`, `offers`, `orders`, `inventory`, `system`. |
| `perPage` | integer | No | Backend accepts `1..100`; use `15` or `20` in the app. |
| `page` | integer | No | Laravel paginator page number. |

### UI Category Mapping

| UI Card | Arabic title | API `logName` | Description |
|---|---|---|---|
| Orders activity | `قبول الطلبات` | `orders` | Order accept/reject/handover/status actions. |
| Inventory activity | `تحديث المخزون` | `inventory` | Stock quantity, expiration, audit, return activity. |
| Promotions activity | `العروض والكوبونات` | `offers` by default | Offer/coupon changes. If coupon logs use a separate backend `logName`, align with backend before release. |

Recommended extra filter chips inside the detail screen:

- `الكل` -> no `logName`
- `الطلبات` -> `orders`
- `المخزون` -> `inventory`
- `المنتجات` -> `products`
- `العروض` -> `offers`
- `النظام` -> `system`

---

## 3. Current Flutter Gap

The current `EmployeeActivityScreen` is a `StatelessWidget` and builds a local `items` list directly inside `build()`. There is no API model, use case, repository method, Bloc event/state, pagination, loading state, empty state, or activity details screen.

Required change: replace the static-only behavior with an API-backed flow while preserving the landing cards.

---

## 4. Target User Flow

### Flow A: Landing Screen

1. Owner opens `سجل نشاط الموظفين`.
2. Screen shows the three category cards.
3. Each card shows title, short description, icon, and optional latest activity count/date if available later.
4. Owner taps a card.
5. App navigates to the activity list screen with the selected `logName`.

### Flow B: Activity List Screen

1. Activity list screen dispatches `FetchActivityLogsEvent` with:
   - `logName`: selected category or null.
   - `page`: 1.
   - `perPage`: 15.
2. UI shows skeleton/loading indicator.
3. Success: show activity cards.
4. Empty: show Arabic empty state explaining no logs exist for this category.
5. Failure: show retry action and backend error message.
6. Scroll to bottom: fetch next page if `meta.current_page < meta.last_page`.
7. Pull-to-refresh: reload page 1.
8. Filter chip change: reload page 1 with selected `logName`.

---

## 5. Files to Add

### Data Models

Add:

```text
lib/features/profile/data/models/fetch_activity_logs_model.dart
```

Model shape:

```dart
class FetchActivityLogsModel {
  final List<ActivityLogItem> data;
  final PaginationLinks? links;
  final PaginationMeta? meta;
}

class ActivityLogItem {
  final int id;
  final String? description;
  final String? event;
  final String? logName;
  final ActivityLogCauser? causer;
  final String? subjectType;
  final dynamic subjectId;
  final Map<String, dynamic>? properties;
  final String? createdAt;
}

class ActivityLogCauser {
  final int id;
  final String? name;
  final String? avatarUrl;
}
```

Parsing requirements:

- Support nullable fields.
- Do not crash when `properties` contains dynamic keys.
- Preserve unknown properties as `Map<String, dynamic>`.
- Parse paginator `meta` fields needed for pagination: `current_page`, `last_page`, `per_page`, `total`, `from`, `to`.
- Convert JSON snake_case to Dart camelCase only inside model fields.

### Use Case

Add:

```text
lib/features/profile/domain/usecases/fetch_activity_logs_use_case.dart
```

Params:

```dart
class FetchActivityLogsParams with Params {
  final String? logName;
  final int page;
  final int perPage;

  @override
  Map<String, dynamic> getParams() => {
    if (logName != null && logName!.isNotEmpty) 'logName': logName,
    'page': page,
    'perPage': perPage,
  };
}
```

### Widgets

Add:

```text
lib/features/profile/view/widgets/activity_category_card.dart
lib/features/profile/view/widgets/activity_log_card.dart
lib/features/profile/view/widgets/activity_log_filter_chips.dart
lib/features/profile/view/widgets/activity_empty_state.dart
lib/features/profile/view/widgets/activity_error_state.dart
```

### Screens

Add:

```text
lib/features/profile/view/screens/activity_logs_screen.dart
```

Keep existing:

```text
lib/features/profile/view/screens/employee_activity_screen.dart
```

but refactor it to use `ActivityCategoryCard` and navigate to `ActivityLogsScreen`.

---

## 6. Files to Update

### Remote Data Source

Update:

```text
lib/features/profile/data/source/profile_remote_data_source.dart
```

Add method:

```dart
Future<FetchActivityLogsModel> fetchActivityLogs(FetchActivityLogsParams params) {
  return wrapHandlingApi(
    tryCall: () => dioNetwork.getData(
      endPoint: '/api/v1/store-owner/activity-logs',
      params: params.getParams(),
      data: params.getBody().isEmpty ? null : params.getBody(),
    ),
    jsonConvert: fetchActivityLogsModelFromJson,
  );
}
```

Important: this endpoint is under `store-owner`, not `restaurant-owner`. Do not accidentally call `/api/v1/restaurant-owner/activity-logs` unless backend adds that alias.

### Domain Repository

Update:

```text
lib/features/profile/domain/repository/profile_repo.dart
```

Add:

```dart
DataResponse<FetchActivityLogsModel> fetchActivityLogs(FetchActivityLogsParams params);
```

### Repository Implementation

Update:

```text
lib/features/profile/data/repository/profile_repo_impl.dart
```

Add:

```dart
@override
DataResponse<FetchActivityLogsModel> fetchActivityLogs(FetchActivityLogsParams params) {
  return wrapHandlingException(
    tryCall: () => profileRemoteDataSource.fetchActivityLogs(params),
  );
}
```

### Profile Bloc

Update:

```text
lib/features/profile/view/manager/bloc/profile_bloc.dart
lib/features/profile/view/manager/bloc/profile_event.dart
lib/features/profile/view/manager/bloc/profile_state.dart
```

Add injected use case:

```dart
final FetchActivityLogsUseCase fetchActivityLogsUseCase;
```

Register event:

```dart
on<FetchActivityLogsEvent>(_fetchActivityLogs, transformer: droppableProMax());
```

State fields:

```dart
PaginationStateModel<ActivityLogItem>? activityLogs;
String? selectedActivityLogName;
```

Event:

```dart
class FetchActivityLogsEvent extends ProfileEvent with EventWithReload {
  final FetchActivityLogsParams params;
  @override
  final bool isReload;

  FetchActivityLogsEvent({required this.params, this.isReload = false});
}
```

Handler behavior:

- If reload: reset list and page to 1.
- If current pagination has ended: do not request again.
- On loading: set pagination loading state.
- On success: append or replace using existing `PaginationStateModel` pattern.
- On failure: set failed state and `errorMessage`.

### Route Registration

Update route annotations only, then run codegen.

New screen:

```dart
@AutoRoutePage(path: '/employees/activity/logs')
class ActivityLogsScreen extends StatefulWidget { ... }
```

Navigation from static cards:

```dart
context.pushRoute(
  '/employees/activity/logs',
  arguments: ActivityLogsScreenParams(
    title: 'قبول الطلبات',
    logName: 'orders',
  ),
);
```

Do not manually edit generated route files. Run build runner.

---

## 7. UI Requirements

### Landing Screen: `EmployeeActivityScreen`

Keep the visual layout close to current screenshot:

- Header with title `سجل نشاط الموظفين`.
- Back button.
- White rounded cards.
- Light gray page background.
- History icon on each card.
- Bottom primary button `إدارة الموظفين`.

Enhance each card:

- Make the full card tappable.
- Add a small arrow icon or label `عرض السجل` to make navigation clear.
- Keep Arabic descriptions:
  - `تابع الموظف المسؤول عن قبول وتجهيز الطلبات.`
  - `راقب تعديلات الكميات والمواد المرتبطة بالمنتجات.`
  - `راجع نشاط إنشاء وتعديل العروض الترويجية.`

### Activity List Screen

Header:

- Title = selected category title.
- Subtitle optional: `آخر الأنشطة المسجلة لهذا القسم`.

Filter chips:

- Horizontal scroll chips.
- Selected chip should use primary color.
- Changing filter reloads data.

Activity card fields:

- Main title: use `description` first.
- Actor: `causer.name` or `غير معروف`.
- Type/status: readable Arabic label based on `event`.
- Category badge: translate `logName`.
- Date: format `createdAt` to readable Arabic date/time.
- Optional details: show key fields from `properties` like `order_id`, `product_id`, `old_status`, `new_status`, `old_quantity`, `new_quantity` when present.

Event label mapping:

| Backend event | Arabic label |
|---|---|
| `created` | `إنشاء` |
| `updated` | `تعديل` |
| `deleted` | `حذف` |
| null/unknown | `نشاط` |

Log name label mapping:

| Backend logName | Arabic label |
|---|---|
| `orders` | `الطلبات` |
| `inventory` | `المخزون` |
| `offers` | `العروض والكوبونات` |
| `products` | `المنتجات` |
| `system` | `النظام` |

---

## 8. Loading, Empty, Error, and Pagination States

### Loading

- First load: centered adaptive loader or skeleton cards.
- Pagination load: small loader at the bottom of the list.

### Empty

Use category-aware Arabic message:

```text
لا توجد أنشطة مسجلة حالياً
ستظهر هنا العمليات التي ينفذها الموظفون ضمن هذا القسم.
```

### Error

Show:

- Error message from `state.errorMessage`.
- Retry button: `إعادة المحاولة`.

### Pagination

- Use `ScrollController` or existing pagination helper pattern.
- Fetch next page when user reaches near bottom.
- Do not duplicate items when reloading.
- Stop when last page is reached.

---

## 9. API Compatibility Notes

The existing Flutter profile API methods currently use several `/api/v1/restaurant-owner/...` endpoints. This activity feature must use the supermarket/store-owner backend endpoint:

```text
/api/v1/store-owner/activity-logs
```

Before release, verify the owner token has access to this route and that `InjectStoreIdFromOwnerContext` resolves the authenticated owner store correctly.

If the app is still using restaurant-owner auth only, backend must either:

1. expose a compatible restaurant-owner alias, or
2. migrate the app profile endpoints to `store-owner` consistently.

Do not silently mix incorrect endpoints without testing authentication and store scoping.

---

## 10. Implementation Steps for Cursor

1. Read existing profile feature architecture and follow the current layer style.
2. Create `FetchActivityLogsModel` with robust nullable JSON parsing.
3. Create `FetchActivityLogsUseCase` and params.
4. Add `fetchActivityLogs` to `ProfileRepo`.
5. Implement repository method in `ProfileRepoImpl`.
6. Add remote data source method using `/api/v1/store-owner/activity-logs`.
7. Inject the new use case into `ProfileBloc`.
8. Add Bloc event/state/handler for paginated activity logs.
9. Refactor `EmployeeActivityScreen` from static-only display into tappable category cards.
10. Add `ActivityLogsScreen` with filter chips, list, pagination, pull-to-refresh, loading, empty, and error states.
11. Keep `إدارة الموظفين` button behavior unchanged.
12. Run build runner:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

13. Run analyzer/tests:

```bash
flutter analyze
flutter test
```

14. Manual QA with a real owner token.

---

## 11. Manual QA Checklist

- [ ] `سجل نشاط الموظفين` page opens with the current design preserved.
- [ ] Tapping `قبول الطلبات` opens logs filtered by `orders`.
- [ ] Tapping `تحديث المخزون` opens logs filtered by `inventory`.
- [ ] Tapping `العروض والكوبونات` opens logs filtered by `offers`.
- [ ] Filter chips reload data correctly.
- [ ] Pull-to-refresh reloads page 1.
- [ ] Infinite scroll loads next page.
- [ ] Empty state appears when no logs exist.
- [ ] Error state appears for 401/500/network failures.
- [ ] Retry button works.
- [ ] Date/time is readable.
- [ ] Unknown causer displays `غير معروف`.
- [ ] Dynamic `properties` do not crash the UI.
- [ ] Bottom `إدارة الموظفين` button still navigates to `/employeesmanagement`.
- [ ] No duplicate records after pagination/reload.
- [ ] `flutter analyze` passes.
- [ ] Generated DI/routes are updated by build runner, not manually edited.

---

## 12. Acceptance Criteria

The feature is accepted when:

1. Employee activity categories are still visible as in the current UI.
2. Each category opens a real activity feed from the backend.
3. The app calls `GET /api/v1/store-owner/activity-logs` with correct query params.
4. Activity records are rendered from API response fields, not static dummy data.
5. Loading, empty, error, refresh, and pagination states are implemented.
6. Architecture follows the existing app convention and uses Bloc/usecase/repository/data source layers.
7. No unrelated profile, employee, offer, coupon, or inventory behavior is broken.

---

## 13. Estimated Work

| Task | Estimate |
|---|---:|
| Model/usecase/repository/data source | 2 - 3 hours |
| Bloc event/state/pagination | 2 - 3 hours |
| Landing screen refactor | 1 hour |
| Activity list UI and widgets | 3 - 4 hours |
| QA, analyzer, fixes | 2 hours |
| Total | 10 - 13 hours |
