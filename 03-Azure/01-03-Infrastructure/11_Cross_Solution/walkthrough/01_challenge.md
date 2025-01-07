## 1. Calculate Composite SLAs with Azure Copilot

We will cover how to calculate composite SLAs, enhance monitoring with alerts, logging, and Kusto queries.

## References
- [📄 Azure Copilot Documentation](https://docs.microsoft.com/en-us/azure/copilot/)


## Use Azure Copilot to calculate the composite SLAs for your application.

### Example Prompts

```
What are the SLAs for my Azure resources?

How do I calculate the composite SLA for my application?

Can you provide an example of composite SLA calculation?

Can you show me the SLAs for Azure App Service?
```

## 2. Explore and Set Alerts with Copilot

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

**[> Next Challenge 2 - Simulate Failures/Load Testing with Azure Chaos Studio](./02_challenge)** |

**[< Previous Challenge 0 - 🚀 Deploying a Ready-to-Go N-tier App with Awesome Azure Developer CLI](./00_challenge)** 

| 