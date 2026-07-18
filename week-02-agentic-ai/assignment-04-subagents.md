# Assignment 4 — Building Your AI Team

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will build and configure a set of specialized AI subagents inside your project. You will learn how different models and tool permissions define agent behavior, and you will trigger two real agent delegations to analyze security and cost aspects of your Terraform infrastructure.

---

# Task 1 — Create the Agents Folder and Add Files

## Goal

Create the `.claude/agents/` directory and add all required agent files.

### Evidence

#### Screenshot 1 — VS Code sidebar showing `.claude/agents/` with all 3 files

![Assignment 4 Screenshot 1](<screenshots/week 02-assignment 04-screenshot1.JPG>)

---

# Task 2 — Compare the Agent Configurations

## Goal

Analyze the configuration differences between the three agents and demonstrate understanding of model and tool selection.

### Written Answers

#### 1. Why does the cost optimizer use Haiku instead of Sonnet?

1. Execution Speed and Real-Time Feedback
Cost optimization scripts often need to parse massive amounts of infrastructure data, such as resource configurations, tag states, and utilization metrics. Haiku is built for speed, processing tokens at a fraction of the time it takes Sonnet. When running automated audits or pre-deployment checks on your Terraform configurations or live AWS EC2 instances, you want instantaneous feedback. A slow model slows down the entire CI/CD pipeline or deployment script. Haiku ensures that checks run almost instantly, providing quick validation without blocking development workflows.

2. Low Operational Overhead
Running automated scanners continuously across large environments can quickly accumulate heavy API costs if you rely on premium models. Because Haiku is highly cost-efficient, the financial footprint of the optimizer itself remains negligible. There is little point in running an optimization tool that spends more on LLM tokens than it saves you on idle infrastructure. Using Haiku guarantees that the cost to find savings remains incredibly low, maximizing the net financial benefit of your optimization efforts.

3. Structured Processing over Deep Reasoning
Many infrastructure-auditing tasks are structurally simple. They involve mapping configurations against standard checklists, such as:

Checking if EC2 instances have mandatory environment tags.

Scanning a docker-compose.yml file to ensure resource limits are set.

Verifying that security groups do not expose port 22 to 0.0.0.0/0.

Matching resource IDs against a list of known idle assets.

These jobs do not require the deep reasoning, complex coding ability, or nuanced contextual understanding of Sonnet. They require speed, accurate pattern matching, and strict adherence to structured data formats like JSON or CSV. Haiku excels at this type of high-volume, low-complexity analysis. It provides the exact level of intelligence needed to flag simple infrastructure errors or missing tags without wasting the "giant brain" power of Sonnet on basic pattern-matching tasks.



---

#### 2. Why does the security auditor NOT have Write in its tools list?

Excluding Write permissions from the security auditor's tool list is a deliberate decision rooted in the principle of least privilege. An auditor’s core function is discovery, not remediation. To evaluate your setup, the tool only needs to read data. It inspects your Spring Boot pom.xml files for vulnerable dependencies, scans docker-compose.yml configurations for missing resource limits, and checks if your AWS security groups mistakenly expose port 22. Granting Write access adds zero value to these analytical tasks, but it introduces massive operational risks.

The biggest risk is mitigating the blast radius of potential compromises. If you run automated audits against code repositories, the system could encounter malicious data or indirect prompt injections. If the auditor possesses Write tools, a compromised agent could rewrite your Terraform files, alter deployment scripts, or modify active environment variables. Restricting the tool list to read-only capabilities creates a physical barrier, ensuring the agent cannot execute destructive changes even if its logic is hijacked.


---

#### 3. Why does the tf-writer use `inherit` instead of a specific model?


Using inherit allows tf-writer to dynamically adopt whatever model is currently driving your main orchestration loop rather than being locked into a specific engine. When you are writing infrastructure as code, the complexity changes drastically depending on the task—deploying a basic AWS EC2 instance requires minimal logic, while drafting intricate, multi-tier Terraform configurations with variable dependencies demands deep reasoning. By inheriting the parent model, the tool seamlessly scales its intelligence to match the difficulty of your current deployment scripts. This approach maintains strict structural consistency across your code, prevents parsing errors between sub-agents, and simplifies your environment configuration by eliminating the need to manually update hardcoded model definitions whenever you optimize your workspace stack.
---

### Evidence

#### Screenshot 2 — `security-auditor.md` frontmatter showing model and tools configuration


![Assignment 4 Screenshot 2](<screenshots/week 02-assignment 04-screenshot2.JPG>)
---

#### Screenshot 3 — `cost-optimizer.md` frontmatter showing the model and tools configuration

![Assignment 4 Screenshot 3](<screenshots/week 02-assignment 04-screenshot3.JPG>)

---

# Task 3 — Run the Security Auditor

## Goal

Trigger the security auditor agent and analyze the generated security report for your Terraform infrastructure.

### Evidence

#### Screenshot 4 — The delegation message showing Claude launched the security-auditor


![Assignment 4 Screenshot 4](<screenshots/week 02-assignment 04-screenshot4.JPG>)
---

#### Screenshot 5 — Security audit report output

![Assignment 4 Screenshot 5](<screenshots/week 02-assignment 04-screenshot5.JPG>)

![Assignment 4 Screenshot 5b](<screenshots/week 02-assignment 04-screenshot5b.JPG>)
---

# Task 4 — Run the Cost Optimizer

## Goal

Trigger the cost optimizer agent and review the generated cost optimization report.

### Evidence

#### Screenshot 6 — The full cost optimization report


![Assignment 4 Screenshot 6](<screenshots/week 02-assignment 04-screenshot6.JPG>)

![Assignment 4 Screenshot 6a](<screenshots/week 02-assignment 04-screenshot6a.JPG>)

---

# Submission Instructions

- Ensure all agent files are committed in `.claude/agents/`
- Complete all written answers in your GitHub Repo
- Push final changes to your forked GitHub repository

---

## GitHub Repository URL

 https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git




---

# Completion Checklist

- [ ] `.claude/agents/` folder contains all 3 agent files
- [ ] Screenshot 2 shows correct `security-auditor.md` configuration
- [ ] Screenshot 3 shows correct `cost-optimizer.md` configuration
- [ ] All 3 written answers completed 
- [ ] Security auditor executed successfully
- [ ] Cost optimizer executed successfully
- [ ] Security report is visible with findings
- [ ] Cost report is visible with recommendations
- [ ] All required screenshots added
- [ ] GitHub repo updated with agents

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://pravinmishra.com/dmi  
- 🎓 DevOps for Beginners (Udemy): https://www.udemy.com/course/devops-for-beginners-docker-k8s-cloud-cicd-4-projects/  
- 🎓 Agentic AI DevOps with Claude Code: https://www.udemy.com/course/ultimate-agentic-ai-devops-with-claude-code/  
- 🎓 DevOps with Claude Code: Terraform, EKS, ArgoCD & Helm: https://www.udemy.com/course/devops-with-claude-code-terraform-eks-argocd-helm/  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*