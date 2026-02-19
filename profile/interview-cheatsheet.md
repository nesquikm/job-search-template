# Interview Cheatsheet — Key Concepts in Brief

## CQRS (Command Query Responsibility Segregation)
Split your domain model into two: one for writes (commands), one for reads (queries). Write side has rich business logic; read side is flat, denormalized, fast. Apply per Bounded Context, not system-wide.

## Anemic Domain Model (anti-pattern)
Domain objects are just data bags (getters/setters), all logic lives in service classes. It's procedural code in OO disguise. Fix: put business rules in domain objects, keep services thin.

## Ubiquitous Language
Everyone — devs, product, domain experts — uses the same terms, and those terms appear in the code. If the business says "cancel an order," the code has `order.cancel()`. Mismatched vocabulary = bugs hiding in translation gaps.

## Bounded Context
A boundary where a specific domain model is consistent. "Account" means different things to billing, auth, and CRM — don't force one class. Each context gets its own model, with explicit mappings at boundaries.

## DDD Aggregate
A cluster of domain objects treated as one unit. One object is the Aggregate Root — the only entry point from outside. Rules: (1) external code only talks to the root, (2) one transaction per aggregate, (3) load/save the whole aggregate. Cross-aggregate consistency via events, not shared transactions. Size sweet spot: group objects that *must* be consistent together, nothing more.

## Feature Toggles
Four types: Release (ship dormant code, short-lived), Experiment (A/B testing, per-request), Ops (kill switches, runtime), Permissioning (premium access, long-lived). Keep toggles in source control when possible. Treat them as inventory with carrying cost — remove aggressively. OFF = old behavior, ON = new.

## EagerReadDerivation
Pre-compute read-side data at write time. When an order is placed, immediately update a denormalized summary table. Queries just fetch — no joins, no aggregation.

## EventPoster
Architecture for read-heavy display apps. Receives events from write side, applies them to an in-memory model optimized for display. No DB on the read path = very fast.

## MemoryImage
Keep all app state in RAM. Durability via event sourcing + snapshots. On crash: load snapshot, replay events. LMAX did 6M tx/sec this way.

## ReportingDatabase
Separate read-only DB with a schema designed for reports/analytics. Synced from operational DB via batch ETL or messaging. Low-tech version of CQRS.

## Fowler's GenAI Patterns (key ones)
- **RAG**: chunk docs → embed → vector DB → retrieve similar chunks → inject into prompt
- **Evals**: systematic scoring of LLM outputs (relevance, factuality). Non-negotiable for production
- **Guardrails**: LLM-based (detect injection), embedding-based (reject off-topic), rule-based (PII filtering)
- **Hybrid Retriever**: vector search + keyword search together beat either alone
- **Reranker**: cross-encoder scores candidates after retrieval, filters junk before LLM sees it
- **Fine-tuning**: last resort. Try prompting → RAG → only then fine-tune

## API Types
- **REST**: resource-based URLs, HTTP verbs, stateless. The default choice
- **GraphQL**: client specifies exact fields needed. One endpoint, no over/under-fetching
- **gRPC**: binary Protocol Buffers, HTTP/2, streaming. Fast for service-to-service
- **WebSocket**: persistent bidirectional connection. Chat, live data, real-time
- **Webhook**: server pushes events to your URL. "Don't call us, we'll call you"
- **SOAP**: XML-based, strict contracts (WSDL). Legacy enterprise, still in banking/healthcare
- **SSE (Server-Sent Events)**: one-way server→client stream over HTTP. Simpler than WebSocket when you don't need bidirectional
- **EDI**: structured B2B data exchange. Supply chain, logistics
- **EDA (Event-Driven)**: publish/subscribe via message brokers (Kafka, RabbitMQ). Decoupled, async

## Circuit Breaker + Exponential Backoff
**Circuit breaker:** three states — Closed (normal) → Open (fail fast, don't call) → Half-Open (one trial to test recovery). Prevents cascading failures when a downstream service is down. Breaker state changes are a key monitoring signal.
**Exponential backoff:** retry with increasing delays (1s, 2s, 4s, 8s...). Handles transient blips without overwhelming the server.
**Together:** backoff retries transient failures; circuit breaker stops trying during prolonged outages. Stack them: circuit breaker wraps retry logic.

## Microservices (9 characteristics)
Suite of small, independently deployable services, each with its own process and database. Key traits: organized around business capabilities (not tech layers), smart endpoints/dumb pipes, decentralized data, design for failure, infrastructure automation. Start with a well-modularized monolith, extract services when complexity justifies it.

## Dependency Injection
Don't let components create their own dependencies — provide them from outside. Prefer constructor injection (object valid at creation, immutable). Alternative: Service Locator (component asks a registry), but hides dependencies and hurts testability. The principle matters more than the mechanism: separate configuration from use.

## Bulkhead Pattern
Isolate resources so one failure doesn't sink everything (from shipbuilding — watertight compartments). E.g., separate thread pools per downstream service: if Service B hangs, only its pool is stuck, A and C keep working. Complements circuit breaker: bulkhead limits blast radius, breaker stops the bleeding.

## Evolutionary Database Design
Treat schema changes like code: numbered migration scripts in version control, applied automatically by tools (Flyway, Liquibase). Each dev gets own DB. CI runs migrations. For breaking changes, use parallel change with transition period (e.g., rename table + create view with old name, let consumers migrate, drop view later). Simple views are fully updatable (INSERT/UPDATE/DELETE); views with JOINs/aggregations are read-only.

## Database Normalization
"The key, the whole key, and nothing but the key, so help me Codd."
- **1NF**: atomic values, no repeating groups (no comma-separated lists in cells)
- **2NF**: no partial dependencies — every column depends on the *whole* composite key
- **3NF**: no transitive dependencies — non-key columns depend on the key *directly*, not through other columns
- **4NF**: no independent multi-valued facts in one table (split employee_skills and employee_languages)
- **5NF**: no join dependencies (extremely rare in practice)
Normalize to 3NF for writes, intentionally denormalize for reads.

## SQL Basics
- **DDL** (structure): CREATE, ALTER, DROP, TRUNCATE
- **DML** (data): SELECT, INSERT, UPDATE, DELETE
- **DCL** (permissions): GRANT, REVOKE
- **TCL** (transactions): COMMIT, ROLLBACK, SAVEPOINT

## Serverless
Two flavors: **BaaS** (replace backend with third-party services — Firebase, Auth0) and **FaaS** (event-triggered functions — Lambda, Cloud Functions). Pay per 100ms of execution, idle = free, scales automatically. Main trade-offs: cold starts (slow first invocation), no local state (use Redis/DynamoDB), vendor lock-in, execution time limits. Great for event-driven/spiky workloads. Bad for low-latency or long-running processes.

## Redis vs DynamoDB
**Redis:** in-memory, sub-millisecond, single-threaded. Use for cache, sessions, rate limiting, pub/sub. Data must fit in RAM; optional persistence.
**DynamoDB:** managed NoSQL on SSD, single-digit ms, unlimited scale, 3-AZ durable. Partition key + sort key model. Design access patterns upfront — no flexible queries, no JOINs, denormalize everything.
Redis = fast ephemeral layer. DynamoDB = durable NoSQL DB. Often used together.

## Message Broker Durability
Brokers persist to disk, not just memory. Kafka uses append-only logs with retention (time/size); consumers track offsets and resume where they left off. If a consumer is down longer than retention — data is gone, need a replay/rebuild strategy. Defenses: retention policies, backpressure, dead letter queues, consumer groups, compacted topics (Kafka keeps latest value per key).
