---
title: Torlink Mobile
description: Native iOS client for a terminal torrent tool — pairs with the desktop server by scanning a QR code instead of typing a bearer token.
date: 2026-08-19 09:00
period: 2026
stack: Swift · SwiftUI · Clean Architecture
---
A native iOS client for the `torlink serve` desktop tool: search sources, queue magnets
or hashes, and manage active downloads and seeds from a phone.

Rather than making the user type a bearer token on a phone keyboard, the app pairs with
the desktop server by scanning a QR code. Built with SwiftUI and Clean Architecture,
using iOS 26 Liquid Glass for the navigation chrome.

The project is driven from a written design handoff — a token system, an interactive
HTML prototype and the API contract — kept in the repository alongside the architectural
rules the code is held to.
