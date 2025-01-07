## Challenge 1 - Calculate Composite SLAs with Azure Copilot

We will cover how to calculate composite SLAs, enhance monitoring with alerts, logging, and Kusto queries.

## References
- [📄 Azure Copilot Documentation](https://docs.microsoft.com/en-us/azure/copilot/)


## Use Azure Copilot to calculate the composite SLAs for your application.

### Example Prompts

```
What are the SLAs for my Azure resources?
```

```
Can you show me the SLAs for Azure App Service?
```

<details close>
<summary>💡 Hint: Use the SLAs</summary>
<br>

Find the latest SLA provided by Microsoft in [Service Level Agreements (SLA) for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1&year=2024).

</details>

### Example Prompts

```
How do I calculate the composite SLA for my application?

Can you provide an example of composite SLA calculation?
```

<details close>
<summary>💡 Hint: Composite SLA Calculation</summary>
<br>

1. Identify the Azure services (components) that are connected.
2. Determine the chains of components within the application.
3. Use the latest SLA provided by Microsoft in [Service Level Agreements (SLA) for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1&year=2024) to find the SLA for each component in the chain.
4. Multiply the SLA values of each individual component (link) in the chain to get the composite SLA for that chain.
5. Identify the weakest link – the component/composites with the lowest SLA.

</details>

---

**[> Next Challenge 2 - Enhance Monitoring with Azure Copilot](./02_challenge.md)** |

**[< Previous Challenge 0 - 🚀 Deploying a Ready-to-Go N-tier App with Awesome Azure Developer CLI](./00_challenge.md)** 