# Flutter 3.27.4 compatibility

Branch: `compat/flutter-3.27.4`. Upstream baseline: `a46c9cb73a8cd9625af9b570e8cae619b29d045a` from davidmigloz/ai_clients_dart, the openai_dart 1.3.0 tag commit. The earlier 1.1/1.2 baseline lacked Dartantic-required OpenAI Responses types. FVM pins Flutter 3.27.4 / Dart 3.6.2.

Workspace: anthropic_sdk_dart 1.2.1, mistralai_dart 1.2.1, ollama_dart 1.3.0 and openai_dart 1.3.0. Other packages remain unmodified and unverified. All four clients, including providers unused by simple_chat, retain their upstream interfaces and behavior.

Patches lower SDK/development-tool bounds to actual compatible versions, convert null-aware collection elements to Dart 3.6 patterns with single evaluation, and use the old formatter. HttpDate.parse on Dart 3.6 leaks RangeError for invalid dates; each IO wrapper converts only that error to HttpException, retaining the invalid-date Exception contract tested upstream.

2026-10-02: all upstream unit suites passed on Dart 3.6.2: 2529 passed, 11 original conditional skips. No live API integration tests ran. Format: 701 source/test files pass. Analysis: no errors or warnings; 52 upstream infos remain reported, without disabling rules. The GenUI compatibility evidence directory contains logs.

Reproduce from this root: `fvm dart test --reporter expanded packages/anthropic_sdk_dart/test/unit packages/mistralai_dart/test/unit packages/ollama_dart/test/unit packages/openai_dart/test/unit`. The GenUI checkout also provides a matching verify_dependency.ps1 profile.

The compatibility branch is maintained in `mytangyh/ai_clients_dart`. This root has no temporary override or locked path dependency; Dart 3.6.2 pub get --enforce-lockfile succeeds. GenUI's delivery manifest pins the exact compatibility commit. One fork carries all four package paths; original licenses are retained. OpenAI-compatible streaming and tool calls additionally passed in real Android simple_chat with gpt-5.6-luna; this does not replace the separate upstream live API suites.

An exported Git baseline with the current uncommitted patches also passes the full profile in a temporary directory and fresh Pub cache. The root lockfile's hosted URLs were subsequently normalized to pub.dev without changing versions or archive hashes, and strict resolution at pub.dev passes. Verification scripts select pub.dev for their process and restore the previous setting. This evidence does not represent a final remote fork clone.
