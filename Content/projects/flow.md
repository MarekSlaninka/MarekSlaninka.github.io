---
title: Flow
description: Sport-performance tracker where each entry is stored either locally in SwiftData or remotely in Firestore, merged into one live feed.
date: 2026-08-04 09:00
period: 2026
stack: Swift · SwiftUI · SwiftData · Firestore
link: https://github.com/MarekSlaninka/Etnetera-Flow
---
An iOS app for recording sport performances where every entry is stored either **locally**
in SwiftData or **remotely** in Cloud Firestore — chosen per entry, not per app.

The interesting part is the read side: the list merges both sources into a single live feed
that updates as either store changes, and can be filtered by storage type. On top of that
it supports search by name or location that ignores case and diacritics.

Source is public.
