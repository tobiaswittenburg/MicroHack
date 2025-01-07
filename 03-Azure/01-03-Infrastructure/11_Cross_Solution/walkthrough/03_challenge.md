# Challenge 3 - Simulate Failures/Load Testing with Azure Chaos Studio

<img src="../img/azure_chaos_studio.png" alt="Azure Chaos Studio" width="600">

Azure Chaos Studio is a tool that allows you to simulate various failure scenarios in your Azure environment. This helps you to identify potential weaknesses and improve the resilience of your applications. In this section, participants will learn how to use Azure Chaos Studio to create and run experiments that simulate different types of failures. Additionally, you will set up notifications to monitor and respond to these failures effectively.

### References
- [What is Azure Chaos Studio?](https://learn.microsoft.com/en-us/azure/chaos-studio/chaos-studio-overview)
- [📄 Azure Chaos Studio - Documentation](https://learn.microsoft.com/en-us/azure/chaos-studio/)

Use Azure Chaos Studio to simulate failures and perform load testing on your N-tier application.

### Agenda:
- **Challenge 0: Getting Started**: Introduction to Azure Chaos Studio and initial setup.
- **Challenge 1: Set Up Notifications**: Configure notifications to alert you when failures occur.
- **Challenge 2: Simulate VM Failure**: Learn how to simulate a virtual machine failure and observe the impact.
- **Challenge 3: Simulate Network Latency**: Understand how to introduce network latency and measure its effects on your applications.
- **Challenge 4: Simulate Resource Pressure**: Simulate resource constraints to test the robustness of your applications under pressure.
- **Challenge 5: Analyze and Improve**: Analyze the results of your experiments and identify areas for improvement.

### Ask the Microsoft Copilot in Azure the following command
```
Can you help me create a chaos experiment in Azure Chaos Studio?
```

<details close>
<summary>💡 Hint 1: Create a chaos experiment in Azure Chaos Studio </summary>
<br>
To create a chaos experiment in Azure Chaos Studio, follow these steps:

1. Open the Azure portal and search for Chaos Studio.
2. Select the Experiments tab and click on Create > New experiment.
3. Fill in the Subscription, Resource Group, and Location where you want to deploy the chaos experiment. Give your experiment a name and select Next: Experiment designer.
4. In the Chaos Studio experiment designer, add steps and branches. Give friendly names to your Step and Branch, and select Add action > Add fault.
5. Choose the type of fault you want to apply (e.g., CPU Pressure or VM Shutdown) and fill in the required parameters such as Duration and pressureLevel.
6. Select your target resources and verify that your experiment looks correct.
7. Finally, select Review + create > Create to initiate the experiment.
</details>

<details close>
<summary>💡 Hint 2: Create a chaos experiment in Azure Chaos Studio using CLI</summary>
<br>

```bash
# Example command to create a chaos experiment
az chaos experiment create --name myChaosExperiment --resource-group myResourceGroup
```

</details>

---

**[> Next Challenge 4 - Develop BCDR and Monitoring Strategy](./04_challenge.md)** |

**[< Previous Challenge 2](./02_challenge.md)** 