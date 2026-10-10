# webspark_task

A Flutter client for the WebSpark "shortest path" challenge. The app fetches
square-field tasks from a user-provided API base URL, computes the shortest path
for each field on-device, and sends the results back to the server.

- **State management:** BLoC (`flutter_bloc`) with `freezed` states/events
- **DI:** `get_it` + `injectable`
- **Navigation:** `go_router`
- **Networking:** `http`
- **Error handling:** `dartz` `Either` + a typed `SomeFailure` enum
- **Responsiveness:** `flutter_screenutil` (design size `375×812`)
- **Serialization:** `freezed` + `json_serializable` / `json_annotation`
- **Persistence:** `shared_preferences` (remembers the last API base URL)

---

## Features

- **Home** — enter an API base URL; live validation, an inline error for a bad
  URL, and a warning when a plain `http://` URL is used (results travel in
  cleartext). The URL is persisted and reused on next launch.
- **Process** — fetches all tasks, solves every field in background isolates
  with a live progress indicator, then submits the results to the server.
- **Result list** — shows each solved path as a compact `(x,y)->(x,y)` label.
- **Preview** — renders the solved field as a colored grid (start / end / path /
  blocked / free) with pan & zoom for large boards.
- **Error handling** — server, network, timeout, 401/403, 404, 429 and format
  failures each map to a localized message with a **Try Again** action.

## User flow

```
Home  ──(valid URL, "Start counting process")──▶  Process  ──(results ready)──▶  Result list
 │                                                      │                              │
 │  persists URL, prefetches tasks                       │  submit ─▶ server           │  tap row
 ▼                                                      ▼                              ▼
invalid / offline ─▶ inline error + Try Again        progress % + submit        Preview (grid + pan/zoom)
```

Routes (see `lib/shared/navigation/app_router.dart`):

| Route     | Path       | Screen          |
| --------- | ---------- | --------------- |
| `home`    | `/`        | Home            |
| `process` | `/process` | Process         |
| `results` | `/results` | Result list     |
| `preview` | `/preview` | Preview         |
| —         | (fallback) | Not found (404) |

---

## Project structure

```
lib/
├── main.dart                     # entry point: DI init + runApp
├── app.dart                      # App root: ScreenUtilInit + MaterialApp.router
├── core/                         # pure Dart logic (no Flutter/UI)
│   ├── algorithms/
│   │   └── shortest_path_finder.dart   # BFS solver + sliding movement
│   └── validators/
│       └── url_validator.dart          # URL format + SSRF hardening
├── components/                   # one folder per screen
│   ├── home_page/                # view + widget/body + bloc + bloc_provider
│   ├── process_page/
│   ├── result_list/
│   ├── preview/                  # view + body + bloc + grid_cell + path_grid
│   └── not_found/
├── shared/                       # cross-cutting concerns
│   ├── constants/                # theme, colors, sizes
│   ├── models/                   # freezed models (Task, Solved, Point, Submit, Failure)
│   ├── navigation/               # go_router setup
│   ├── widgets/                  # app bar, main button, loader, try-again
│   ├── repositories/             # interfaces + http / prefs implementations
│   └── di/                       # get_it + injectable modules
└── l10n/                         # ARB sources + generated localizations (en)
```

Each screen follows the same layering: a `bloc/` (state, events, logic),
a `view/` (Scaffold, app bar, navigation) and `widget/body/` (content), with a
`widget/bloc_provider/` wiring the bloc into the tree.

---

## The algorithm

`lib/core/algorithms/shortest_path_finder.dart` solves each field with
**Breadth-First Search (BFS)** — the right choice for an unweighted grid, where
the shortest path is measured in the fewest moves.

- A field is a square `n×n` grid (`2 ≤ n ≤ 99`) of `'.'` (free) and `'X'`
  (blocked) rows.
- From a cell you may move in **8 directions and slide until an obstacle or the
  edge** (`SlidingMovement`) — each slide counts as a single move.
- BFS from `start` guarantees the minimum number of moves to `end`; the path is
  reconstructed and returned as a `SolvedModel`.

Solving runs off the UI thread: tasks are processed in **chunks of 16** via
`compute()` (one isolate spawn per chunk, not per task) so hundreds of small
fields don't flood the main isolate, and progress emits are throttled to avoid
needless rebuilds.


---

## API contract

Implemented in `lib/shared/repositories/path_repository.dart`.

**Fetch tasks** — `GET {baseUrl}`

```json
{
  "error": false,
  "data": [
    { "id": "1", "field": ["...", ".X.", "..."], "start": { "x": 0, "y": 0 }, "end": { "x": 2, "y": 2 } }
  ]
}
```

- `field` is square (`row.length == field.length`, `2..99`), only `.`/`X`.
- `start` / `end` are `{ "x": int, "y": int }`.

**Submit results** — `POST {baseUrl}`

```json
[
  { "id": "1", "result": { "steps": [{ "x": 0, "y": 0 }, { "x": 2, "y": 2 }], "path": "(0,0)->(2,2)" } }
]
```

Response: `{ "error": false, "data": [{ "id": "1", "correct": true }] }`.

---

## Security & performance notes

- **SSRF guard** — `UrlValidator.isSafeForRequest` blocks non-public targets
  (localhost, loopback, link-local, `192.168/16`, `10/8`, `172.16/12`, cloud
  metadata hosts, `.local`/`.internal`/`.lan`, embedded credentials) before any
  request is made.
- **No redirects** — requests are sent with `followRedirects = false`; a 3xx is
  treated as a failure so a hostile server can't bounce results elsewhere.
- **Payload caps** — response body (5 MB), task count (500), field size (99) and
  id length (128) are all bounded to protect the device.
- **Efficient preview grid** — small boards (≤ 20) are built cell-by-cell so
  `(x,y)` captions stay accessible; larger boards are drawn by a single
  `CustomPainter` with culling and wrapped in an `InteractiveViewer` for pan/zoom.
- **Cheap labels & lookups** — path labels are memoized/truncated and cell
  lookups use a precomputed `Set<int>` keyed by `y * 256 + x`.

---

## Getting started

**Prerequisites:** Flutter (Dart SDK `^3.11.4`).

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate code (freezed, json_serializable, injectable, l10n)
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Run
flutter run

# 4. Analyze
flutter analyze

# 5. Test
flutter test
```

> The generated files (`*.freezed.dart`, `*.g.dart`, `injection.config.dart`,
> `l10n/gen/`) are committed, so step 2 is only needed after editing models,
> DI annotations or ARB files.

---

## Testing

Widget/unit tests live in `test/`:

| Test                              | Covers                                   |
| --------------------------------- | ---------------------------------------- |
| `shortest_path_finder_test.dart`  | BFS solver & movement                    |
| `home_bloc_test.dart`             | URL validation, save, prefetch, failures |
| `process_bloc_test.dart`          | solve/submit flow, progress, failures    |
| `preview_bloc_test.dart`          | preview state, labels, cell roles        |
| `preview_view_test.dart`          | grid rendering, painter, pan/zoom        |
| `path_repository_test.dart`       | HTTP fetch/submit, guards, error mapping |
| `url_validator_test.dart`         | URL format + SSRF hardening              |
| `try_again_widget_test.dart`      | retry UI                                 |

Run a single suite, e.g.:

```bash
flutter test test/shortest_path_finder_test.dart
```

---

## Localization

Strings live in `lib/l10n/app_en.arb` and are generated into `lib/l10n/gen/`
(via `flutter gen-l10n`). Access them in the UI with the `context.l10n`
extension (`lib/l10n/l10n.dart`).

