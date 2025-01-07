# Challenge 2 - Enhance Monitoring with Azure Copilot

## Explore and Set Alerts with Copilot

### Example Prompts

```
Show me Azure Monitor active alerts.
```

```
How do I create an alert in Azure Monitor?
```

## 3. Create Kusto Queries for Monitoring

Create Kusto queries to monitor the performance and health of your application.

```kusto
// Example Kusto query
AppRequests
| where Timestamp > ago(1h)
| summarize count() by bin(Timestamp, 5m)
```

---

---

**[> Next Challenge 3 - Simulate Failures/Load Testing with Azure Chaos Studio](./03_challenge.md)** |

**[< Previous Challenge 1 - Calculate Composite SLAs with Azure Copilot](./01_challenge.md)** 