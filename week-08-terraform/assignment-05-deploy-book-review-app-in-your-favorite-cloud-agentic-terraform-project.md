# Capstone Assignment — Deploy the Book Review App Using Terraform and Claude Code Agentic AI

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Student Details

**Full Name:** Add your full name here  
**Cloud Platform:** AWS or Azure  
**GitHub Repository URL:** Add your repository URL here  
**Public Application URL / Load-Balancer DNS:** Add the public URL or DNS here

---

## Purpose

Deploy the Book Review App using Terraform on AWS or Azure in a secure, highly available, production-style three-tier architecture. Use Claude Code, specialized subagents, Terraform MCP, and validation hooks to support the engineering workflow while keeping all infrastructure-changing operations under human control.

---

# Task 0 — Prepare the Project and Agentic AI Environment

## Goal

Prepare the Book Review App project and configure the provided Claude Code Agentic AI starter kit with project context, specialized subagents, Terraform MCP, validation hooks, and safety guardrails.

## Evidence

### Screenshot 1 — Project `CLAUDE.md`

Add a screenshot of the project `CLAUDE.md` showing the three-tier architecture, security boundaries, Terraform requirements, and human-approval rules.

![alt text](<screenshots/week 08-assignment 5-task0-screenshot1.JPG>)

---

### Screenshot 2 — Terraform Engineer Subagent

Add a screenshot showing the Terraform Engineer subagent configuration.

![alt text](<screenshots/week 08-assignment 5-task0-screenshot2.JPG>)

---

### Screenshot 3 — Architecture and Security Reviewer Subagent

Add a screenshot showing the Architecture and Security Reviewer subagent configuration.

![alt text](<screenshots/week 08-assignment 5-task0-screenshot3.JPG>)

---

### Screenshot 4 — Terraform MCP Connection

Add a screenshot showing Terraform MCP connected and available.

![alt text](<screenshots/week 08-assignment 5-task0-screenshot4.JPG>)

---

### Screenshot 5 — Validation Hooks

Add a screenshot showing the configured Claude Code validation hooks.

![alt text](<screenshots/week 08-assignment 5-task0-screenshot5.JPG>)

---

# Task 1 — Design the Three-Tier Architecture

## Goal

Design the required secure, highly available three-tier architecture and create an architecture diagram before building the infrastructure.

The diagram must show:

- VPC or VNet
- Availability Zones or equivalent availability locations
- Six subnets
- Internet connectivity
- NAT or outbound design
- Public load balancer
- Web Tier
- Internal load balancer
- Application Tier
- Managed MySQL
- Read replica
- Main traffic flow

## Architecture Diagram

![alt text](<screenshots/week 08-assignment 5-task1-screenshot.JPG>)
---

# Task 2 — Build the Terraform Networking and Security Layers

## Goal

Create the modular Terraform project and implement the network and security layers across the required public and private subnets.

## Evidence

### Screenshot 6 — Modular Terraform Project Structure

Add a screenshot showing the modular Terraform project structure.

![alt text](<screenshots/week 08-assignment 5-task2-screenshot6.JPG>)

---

### Screenshot 7 — Six-Subnet Architecture

Add a screenshot showing the six-subnet architecture across two availability locations.

![alt text](<screenshots/week 08-assignment 5-task2-screenshot7.JPG>)

---

### Screenshot 8 — Public and Private Tier Separation

Add a screenshot showing the public and private tier separation, including routing and security boundaries.

![alt text](<screenshots/week 08-assignment 5-task2-screenshot8.JPG>)

---

# Task 3 — Build the Load-Balancing and Compute Layers

## Goal

Deploy the public and internal load balancers and the Web and Application compute resources required by the Book Review App.

## Evidence

### Screenshot 9 — Web and Application Compute

Add a screenshot showing the Web and Application compute resources in their required subnets.

![alt text](<screenshots/week 08-assignment 5-task3-screenshot9.JPG>)

![alt text](<screenshots/week 08-assignment 5-task3-screenshot9a.JPG>)


---

### Screenshot 10 — Public Load Balancer

Add a screenshot showing the internet-facing public load balancer.

![alt text](<screenshots/week 08-assignment 5-task3-screenshot10.JPG>)

---

### Screenshot 11 — Internal Load Balancer

Add a screenshot showing the private internal load balancer.

![alt text](<screenshots/week 08-assignment 5-task3-screenshot11.JPG>)

---

### Screenshot 12 — Healthy Targets

Add a screenshot showing healthy target groups or backend pools.

![alt text](<screenshots/week 08-assignment 5-task3-screenshot12.JPG>)

---

# Task 4 — Build the Managed MySQL Database Layer

## Goal

Deploy a private, highly available managed MySQL database with a read replica and restrict database connectivity to the Application Tier.

## Evidence

### Screenshot 13 — Managed MySQL Database

Add a screenshot showing the managed MySQL database deployment.

![alt text](<screenshots/week 08-assignment 5-task4-screenshot13.JPG>)

---

### Screenshot 14 — High Availability

Add a screenshot showing the Multi-AZ or high-availability configuration.

![alt text](<screenshots/week 08-assignment 5-task4-screenshot14.JPG>)

---

### Screenshot 15 — Read Replica

Add a screenshot showing the read replica configuration.

![alt text](<screenshots/week 08-assignment 5-task4-screenshot15.JPG>)

---

### Screenshot 16 — Private Database Access

Add a screenshot showing that the database is private and accepts MySQL traffic only from the Application Tier.

![alt text](<screenshots/week 08-assignment 5-task4-screenshot16.JPG>)

---

# Task 5 — Validate, Review, and Apply the Terraform Configuration

## Goal

Validate the Terraform configuration, review the execution plan using both Agentic AI and human judgment, and apply the infrastructure changes only after all required checks pass.

## Evidence

### Screenshot 17 — Terraform Validation

Add a screenshot showing successful `terraform validate` output.

![alt text](<screenshots/week 08-assignment 5-task5-screenshot17.JPG>)

---

### Screenshot 18 — Terraform Plan

Add a screenshot showing the Terraform plan output.

![alt text](<screenshots/week 08-assignment 5-task5-screenshot18.JPG>)

![alt text](<screenshots/week 08-assignment 5-task5-screenshot18a.JPG>)

---

### Screenshot 19 — Terraform Apply

Add a screenshot showing successful `terraform apply` completion.

![alt text](<screenshots/week 08-assignment 5-task5-screenshot19.JPG>)

---

# Task 6 — Deploy and Configure the Book Review Application

## Goal

Deploy and configure the Book Review App across the Web, Application, and Database tiers and verify the complete application functionality.

## Evidence

### Screenshot 20 — Homepage

Add a screenshot showing the Book Review App homepage through the public endpoint.

![alt text](<screenshots/week 08-assignment 5-task6-screenshot20.JPG>)

---

### Screenshot 21 — Login or Authentication

Add a screenshot showing successful login or authentication.



---

### Screenshot 22 — Book Data

Add a screenshot showing the book listing or book details.



---

### Screenshot 23 — Review Functionality

Add a screenshot showing the review functionality working successfully.



---

### Screenshot 24 — Backend or API Evidence

Add a screenshot showing that the backend or API is working successfully.



---

### Screenshot 25 — Database Reads and Writes

Add a screenshot showing successful database reads and writes.



## Public Application URL

**Public Application URL / DNS:** Add the working public application URL or load-balancer DNS here

---

# Task 7 — Demonstrate the Agentic AI Workflow

## Goal

Demonstrate how Claude Code assisted with Terraform generation, architecture and security review, and evidence-based troubleshooting while infrastructure-changing decisions remained under human control.

You do not need to submit your complete Claude Code conversation history. Include only focused evidence.

## Evidence

### Screenshot 26 — AI-Assisted Terraform Generation

Add a screenshot showing one useful example of AI-assisted Terraform generation or improvement.

![alt text](<screenshots/week 08-assignment 5-task7-screenshot26.JPG>)
---

### Screenshot 27 — Architecture or Security Review

Add a screenshot showing one structured architecture or security review result.

![alt text](<screenshots/week 08-assignment 5-task7-screenshot27.JPG>)

![alt text](<screenshots/week 08-assignment 5-task7-screenshot27a.JPG>)

---

### Screenshot 28 — AI-Assisted Troubleshooting

Add a screenshot showing one AI-assisted troubleshooting interaction based on collected evidence.

![alt text](<screenshots/week 08-assignment 5-task7-screenshot28.JPG>)

![alt text](<screenshots/week 08-assignment 5-task7-screenshot28a.JPG>)

---

# Task 8 — Complete the Final Architecture Review

## Goal

Review the completed infrastructure against the original capstone requirements and resolve significant architecture, security, reliability, and cost issues.

Confirm that the final review covers:

- Tier separation
- Availability
- Public exposure
- Routing
- Security rules
- Load balancing
- Database privacy
- Secrets
- Terraform quality
- Module structure
- Reliability
- Obvious cost risks

Use Screenshot 27 as the focused evidence for the structured architecture or security review.

---

# Task 9 — Answer the Reflection Questions

## Goal

Reflect on the architecture, Terraform implementation, and Agentic AI workflow. Answer each question briefly in your own words.

## Architecture

### 1. Why did you separate the Web, Application, and Database tiers?

I separated our architecture into distinct tiers to isolate public traffic from business logic and sensitive data. The web tier handles incoming traffic via the Application Load Balancer, the application tier processes core requests on EC2 instances, and the database tier houses our private RDS MySQL instance safely away from public exposure.


### 2. Why is the Application Tier private?

I placed our application tier in private subnets so that the backend servers are never directly accessible from the public internet. This drastically reduces our attack surface while still allowing secure communication from the public load balancer.

### 3. Why is MySQL private?

I kept the MySQL database in a private subnet with no public IP addresses to protect our core data store. This ensures that database access is strictly restricted to authorized internal application instances.

### 4. Why are multiple Availability Zones used?

I deployed our resources across multiple Availability Zones to ensure high availability and fault tolerance. If one data center experiences an outage, workloads in the other zone continue running smoothly.

### 5. What is the difference between Multi-AZ/high availability and a read replica?

I used Multi-AZ deployment to provide automatic failover and redundancy for high availability, whereas a read replica is used to offload read-heavy query traffic and improve scaling performance.

## Terraform

### 6. How did you divide your Terraform into modules?

I organized my Terraform codebase into logical, reusable modules covering networking (VPC, subnets, route tables), compute (ASG, ALB, launch templates), and our RDS database backend.

### 7. How do the modules communicate through variables and outputs?

I kept our modules decoupled by passing configuration inputs through variables and exposing resource attributes such as VPC IDs, subnet lists, and security group IDs through module outputs.

### 8. What did you specifically check in `terraform plan`?

I carefully reviewed my terraform plan outputs to verify resource counts, ensure no unexpected infrastructure destructions or replacements were queued, and confirm that security group rules adhered to least-privilege principles.

## Agentic AI

### 9. What was the purpose of `CLAUDE.md`?

I set up CLAUDE.md as a project-specific instruction file to guide Claude Code on our directory structures, coding standards, and safety guidelines throughout the development process.

### 10. What work did the Terraform Engineer subagent perform?

The Terraform Engineer subagent helped me draft, structure, and refine modular HCL code for setting up our virtual network infrastructure and EC2 compute instances.

### 11. What did the Architecture and Security Reviewer identify?

The Architecture and Security Reviewer evaluated our setup to verify proper subnet isolation between public and private tiers and ensure least-privilege network rules.

### 12. Why did you use Terraform MCP instead of relying only on Claude's existing Terraform knowledge?

I integrated the Terraform Model Context Protocol (MCP) server so Claude could interact with live state data and execute syntax validations dynamically rather than depending solely on static training memory


### 13. What was the purpose of your validation hooks?

I implemented pre-commit validation hooks to automatically inspect our code for hardcoded secrets, syntax bugs, or debug statements before any code commits were made.

### 14. Describe one real issue Claude helped you troubleshoot.

Claude helped me diagnose and resolve the frontend ERR_CONNECTION_REFUSED bug by identifying that Next.js client-side bundles needed the NEXT_PUBLIC_API_URL environment variable injected at build time inside our web_user_data.sh script instead of using hardcoded localhost defaults

### 15. Describe one recommendation you reviewed, modified, or rejected instead of accepting blindly.

When an automated security scan suggested opening broader port ranges for internal service communication, I rejected it to maintain strict least-privilege network boundaries, choosing targeted security group rules instead

---

# Task 10 — Publish the Mandatory LinkedIn Post

## Goal

Publish a LinkedIn post describing the capstone, the technical work completed, the Agentic AI workflow, and the lessons learned.

Write the post in your own words, include at least one project image or other proof, and ensure that it can be viewed by the submission reviewer.

## LinkedIn Post URL

**LinkedIn Post URL:** 

---

# Submission Instructions

- Complete Tasks 0–10 in sequence.
- Include all Screenshots 1–28 exactly as specified.
- Ensure that your full name is visible in the required screenshots.
- Include the selected cloud platform.
- Include the completed architecture diagram.
- Include the modular Terraform project structure.
- Include the working public application URL or public load-balancer DNS.
- Include all required Agentic AI workflow evidence.
- Answer all 15 reflection questions briefly in your own words.
- Include the published LinkedIn post URL.
- Do not expose cloud credentials, database passwords, SSH private keys, JWT secrets, access tokens, account IDs, Terraform state containing sensitive values, or other confidential information.
- Review all screenshots and project files carefully before submitting through GitHub.

---

# Completion Checklist

- [ ] Selected AWS or Azure
- [ ] Added and reviewed the Agentic AI starter files
- [ ] Configured `CLAUDE.md`
- [ ] Configured the Terraform Engineer subagent
- [ ] Configured the Architecture and Security Reviewer subagent
- [ ] Connected Terraform MCP
- [ ] Configured validation hooks and safety guardrails
- [ ] Created the architecture diagram
- [ ] Created the six-subnet design
- [ ] Configured public Web Tier routing
- [ ] Kept the Application Tier private
- [ ] Kept the Database Tier private
- [ ] Configured tier-specific Security Groups or NSGs
- [ ] Restricted backend port `3001`
- [ ] Restricted MySQL port `3306` to the Application Tier
- [ ] Created the public load balancer
- [ ] Created the internal load balancer
- [ ] Configured listeners and health checks
- [ ] Deployed the Web Tier compute resources
- [ ] Deployed the private Application Tier compute resources
- [ ] Provisioned private managed MySQL
- [ ] Configured Multi-AZ or high availability
- [ ] Configured a read replica
- [ ] Created the modular Terraform project
- [ ] Used variables, outputs, and module dependencies
- [ ] Used current Terraform documentation through MCP
- [ ] Used hooks for deterministic validation
- [ ] Completed `terraform fmt`
- [ ] Completed `terraform validate`
- [ ] Reviewed `terraform plan`
- [ ] Completed the Terraform Engineer review
- [ ] Completed the Architecture and Security review
- [ ] Applied the infrastructure only after human approval
- [ ] Deployed and configured the backend
- [ ] Deployed and configured the frontend
- [ ] Configured Nginx where required
- [ ] Configured the internal backend endpoint
- [ ] Configured the public frontend endpoint
- [ ] Verified the homepage
- [ ] Verified login or authentication
- [ ] Verified book data
- [ ] Verified review functionality
- [ ] Verified the backend API
- [ ] Verified database reads and writes
- [ ] Verified healthy load-balancer targets
- [ ] Included AI-assisted Terraform generation evidence
- [ ] Included one architecture or security review
- [ ] Included one AI-assisted troubleshooting example
- [ ] Completed the final architecture review
- [ ] Answered all 15 reflection questions
- [ ] Published the mandatory LinkedIn post
- [ ] Added the LinkedIn post URL
- [ ] Captured all 28 required screenshots
- [ ] Confirmed that my full name is visible in the required screenshots
- [ ] Checked that no secrets or sensitive information are exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory), focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations through hands-on experience.

---

## Resources

- Book Review App Repository: [https://github.com/pravinmishraaws/book-review-app](https://github.com/pravinmishraaws/book-review-app)
- DMI Official Website: [https://dmi.pravinmishra.com](https://dmi.pravinmishra.com)
- University: [https://university.pravinmishra.com](https://university.pravinmishra.com)
- Discord Community: [https://discord.pravinmishra.com](https://discord.pravinmishra.com)
- Blog: [https://dmi.pravinmishra.com/blog](https://dmi.pravinmishra.com/blog)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra on LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory on LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
