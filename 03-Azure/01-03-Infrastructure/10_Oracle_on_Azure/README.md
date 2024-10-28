# Microhack - Intro To Oracle DB Migration to Azure

## Important Notice

This project is currently under development and is subject to change until the first official release, which is expected by the end of 2024. Please note that all content, including instructions and resources, may be updated or modified as the project progresses.


## Introduction

This intro level microhack (hackathon) will help you get hands-on experience migrating Oracle databases from on-premises to different Azure Services.

## Learning Objectives
In this microhack you will solve a common challenge for companies migrating to the cloud: migrating Oracle databases to Azure. The application using the database is a sample e-commerce [application](https://github.com/pzinsta/pizzeria) written in JavaScript. It will be configured to use Oracle Database Express Edition [Oracle XE]. 

The participants will learn how to:

1. Perform a pre-migration assessment of the databases looking at size, database engine type, database version, etc.
2. Use offline tools to copy the databases to Azure OSS databases
3. Use the Azure Database Migration Service to perform an online migration (if applicable)
4. Do cutover and validation to ensure the application is working properly with the new configuration
5. Use a private endpoint for Azure OSS databases instead of a public IP address for the database
6. Configure a read replica for the Azure OSS databases

## Challenges
- Challenge 0: **[Pre-requisites - Setup Environment and Prerequisites!](Student/00-prereqs.md)**
   - Prepare your environment to run the sample application
- Challenge 1: **[Discovery and assessment](Student/01-discovery.md)**
   - Discover and assess the application's PostgreSQL/MySQL/Oracle databases
- Challenge 2: Oracle to IaaS migration
- Challenge 3: Oracle to PaaS migration
- Challenge 4: Oracle to Azure OCI migration
- Challenge 5: Oracle to Oracle Database on Azure migration

## Prerequisites

- Access to an Azure subscription with Owner access
   - If you don't have one, [Sign Up for Azure HERE](https://azure.microsoft.com/en-us/free/)
   - Familiarity with Azure Cloud Shell
- [**Visual Studio Code**](https://code.visualstudio.com/) (optional)

## Repository Contents
- `../Coach`
  - [Lecture presentation](Coach/OSS-DB-What-the-Hack-Lecture.pptx?raw=true) with short presentations to introduce each challenge
  - Example solutions and coach tips to the challenges (If you're a student, don't cheat yourself out of an education!)
- `../Student/Resources`
   - Pizzeria application environment setup

## Licensing Oracle Database and software on Azure
Microsoft Azure is an authorized cloud environment for running Oracle Database. The Oracle Core Factor table isn't applicable when licensing Oracle databases in the cloud. Instead, when using VMs with Hyper-Threading Technology enabled for Enterprise Edition databases, count two vCPUs as equivalent to one Oracle Processor license if hyperthreading is enabled, as stated in the policy document. The policy details can be found at Licensing Oracle Software in the Cloud Computing Environment.

Oracle databases generally require higher memory and I/O. For this reason, we recommend Memory Optimized VMs for these workloads. To optimize your workloads further, we recommend Constrained Core vCPUs for Oracle Database workloads that require high memory, storage, and I/O bandwidth, but not a high core count.

When you migrate Oracle software and workloads from on-premises to Microsoft Azure, Oracle provides license mobility as stated in Oracle and Microsoft Strategic Partnership FAQ.

[Offical Azure Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-vm-solutions#licensing-oracle-database-and-software-on-azure)

## Contributors

