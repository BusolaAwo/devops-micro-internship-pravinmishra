# Assignment 6 — Build an AI-Assisted Linux Health Check (AI-Assisted Linux Incident Triage)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will build a read-only Bash triage script that checks the health of your Ubuntu server and Nginx application, connect it to Claude Code as a reusable `/linux-triage` skill, simulate a controlled Nginx incident, use the skill to gather and analyze evidence, recover the service manually, and verify recovery. The workflow follows the Agentic Loop: Gather → Analyze → Human Act → Verify.

---

# Task 1 — Confirm the Healthy Baseline and Create the Workspace

## Goal

Confirm that Nginx and the React application are healthy before building the automation.

### Evidence

#### Screenshot 1 — Output of `systemctl is-active nginx`, `ss -ltn | grep ':80'`, and `curl -I http://localhost`

![alt text](<screenshots/assignment 06-task1-screenshot 1.JPG>)

![alt text](<screenshots/assignment 06-task1-screenshot 1a.JPG>)


![alt text](<screenshots/assignment 06-task1-screenshot 1b.JPG>)
---

#### Screenshot 2 — Output of `pwd` and `find . -maxdepth 4 -type d | sort` showing the workspace folder structure

![alt text](<screenshots/assignment 06-task1-screenshot 2.JPG>)

![alt text](<screenshots/assignment 06-task1-screenshot 2a.JPG>)

---

### Notes

Answer the following in your own words:

**1. What proves that Nginx is running?**

 To verify that Nginx is active, I run sudo systemctl status nginx in my terminal or sudo systemctl status nginx --no-pager and look for the bright green "active (running)" indicator. Additionally, I can check my system's active process list using ps aux | grep nginx to confirm that the Nginx master and worker processes are actively running in the background of my server.

---

**2. What proves that the server is listening for HTTP traffic?**

 I prove my server is listening for HTTP traffic by running sudo ss -lptn to check active network sockets and confirming that a process named nginx is bound to port 80. I then run curl -I http://localhost from the command line to verify that the server successfully returns a healthy HTTP 200 OK response.

---

**3. Why must you capture a healthy baseline before simulating an incident?**

 Capturing a healthy baseline first is critical because it gives me a clear reference point of how my system behaves when everything is working perfectly. Without this normal state recorded, I wouldn't be able to confidently distinguish between a new issue I deliberately caused during my simulation and an existing, pre-existing configuration problem on the server.

---

# Task 2 — Create Project Context and Safety Rules in CLAUDE.md

## Goal

Tell Claude exactly what this project does and what it is not allowed to do.

### Evidence

#### Screenshot 3 — CLAUDE.md open in VS Code showing all four sections (Project Overview, Incident Workflow, Safety Rules, Output Rules)

![alt text](<screenshots/assignment 06-task2-screenshot 3.JPG>)

---

### Notes

Answer the following in your own words:

**1. Why should Claude receive project-specific operational rules?**

 I provide Claude with project-specific operational rules to guarantee that its guidance directly aligns with my actual environment, folder structures, and technology stack. Without these explicit rules, an AI might offer generic, textbook advice that doesn't fit my exact setup, whereas tailored constraints ensure it gives accurate, safe, and highly relevant troubleshooting steps for my specific deployment pipelines.

---

**2. Why is the human required to execute the recovery command?**

 I require a human to manually execute recovery commands because automated destructive actions pose a massive risk to system stability. Keeping a human engineer in the loop ensures that someone with contextual awareness can double check the command syntax, verify terminal warnings, and take ultimate responsibility before applying changes that could permanently alter or disrupt my live cloud infrastructure.

---

**3. Which rule prevents Claude from making an unsupported diagnosis?**

 The rule that prevents Claude from making an unsupported diagnosis is the requirement to base all troubleshooting strictly on verified, real-time terminal logs or command output. By forcing the AI to rely exclusively on concrete evidence rather than making assumptions, this rule protects me from chasing down false leads or applying irrelevant fixes that don't match the actual root cause.

---

# Task 3 — Use Agentic AI to Plan Before Writing the Script

## Goal

Use Claude Code to inspect the environment and produce a read-only plan before creating any Bash code.

### Evidence

#### Screenshot 4 — Claude Code showing the five-check plan and read-only inspection results


![alt text](<screenshots/assignment 06-task3-screenshot 4.JPG>)
---

### Notes

Answer the following in your own words:

**1. Which part of this task represents the Gather phase?**

 In this task, the Gather phase is represented by the step where I ran diagnostic discovery commands like sudo ss -lptn, checked system logs, and inspected my configuration files. Instead of jumping to conclusions or changing code right away, this phase is where I collected raw, unfiltered data straight from my server's terminal to understand exactly what was happening.

---

**2. Did Claude follow the instruction not to create files? How did you verify this?**

 Yes, Claude strictly followed the instruction not to create any files on my system during our session. I verified this personally by reviewing the generated responses to ensure no file-creation commands like touch, echo >, or tee were recommended, and I manually ran git status and checked my target directories to confirm no unexpected new files appeared.

---

**3. Why is planning before coding useful in DevOps automation?**

 Planning before coding is incredibly useful in my DevOps automation workflows because it prevents me from deploying broken scripts that could accidentally disrupt live infrastructure. By mapping out my variables, loops, and logic blocks ahead of time, I can identify potential edge cases, avoid syntax conflicts, and ensure my automation steps execute in the exact order required.

---

# Task 4 — Build the Linux Triage Bash Script

## Goal

Create one Bash script that gathers consistent Linux and Nginx health evidence.

### Evidence

#### Screenshot 5 — Top section of `linux-triage.sh` showing variables, thresholds, and the checks array

![alt text](<screenshots/assignment 06-task4-screenshot 5.JPG>)

---

#### Screenshot 6 — Middle section showing check functions and conditionals


![alt text](<screenshots/assignment 06-task4-screenshot 6.JPG>)
---

#### Screenshot 7 — Bottom section showing the loop, summary function, and exit behavior

![alt text](<screenshots/assignment 06-task4-screenshot 7.JPG>)

---

#### Screenshot 8 — Output of `bash -n scripts/linux-triage.sh` (no syntax errors) and `ls -l scripts/linux-triage.sh` showing executable permission

![alt text](<screenshots/assignment 06-task4-screenshot 8.JPG>)

![alt text](<screenshots/assignment 06-task4-screenshot 8a.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is stored in the checks array?**

 In my script, the checks array stores a collection of specific system targets or service names that I need to audit, such as nginx, mysql, or specific directory paths. By grouping these text strings into a single array structure, I can manage all my health check targets collectively in one place at the top of my script.

---

**2. How does the `for` loop use that array?**

 The for loop uses that array to automatically iterate through my list of health check targets one by one. On each pass of the loop, Bash assigns the current element from the array to a temporary iterator variable, allowing my script to evaluate conditions and run diagnostic checks against every single listed service without duplicating code.


---

**3. Why are the health checks separated into functions?**

 I separate my health checks into distinct functions to keep my code modular, highly readable, and easy to troubleshoot. By isolating specific logic like checking port bindings or verifying file existence into dedicated functions, I can easily modify a single test without breaking the rest of my script, making the entire automation codebase much cleaner.


---

**4. What is the purpose of `$(...)` in this script?**

 I use the $(...) syntax in my script to perform command substitution, which allows me to execute a Linux command and capture its text output directly into a variable. For example, capturing the output of a systemctl or pgrep command this way lets my script evaluate the results dynamically using my conditional logic blocks.

---

**5. Why does the script use different exit codes for HEALTHY, WARN, and FAIL?**

 I use unique exit codes like 0, 1, and 2 so that external monitoring tools, CI/CD pipelines, or other orchestration scripts can instantly understand the system status without parsing text. This structured numeric feedback allows my automated operations to immediately detect a failure, trigger alerts, or initiate self-healing protocols based on the specific severity level.

---

# Task 5 — Run and Understand the Healthy-State Report

## Goal

Run the Bash script against the healthy server and verify that it creates a report.

### Evidence

#### Screenshot 9 — Output of `./scripts/linux-triage.sh` showing your Full Name and all five check results

![alt text](<screenshots/assignment 06-task5-screenshot 9.JPG>)

---

#### Screenshot 10 — Output showing the captured exit code and final summary

![alt text](<screenshots/assignment 06-task5-screenshot 10.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the overall status of your healthy baseline?**

 The overall status of my healthy baseline is completely functional, stable, and returning an optimal green status across all checked components. Every essential system target defined in my script passes its criteria smoothly, meaning my Nginx server is actively running, ports are bound correctly, and system resources are well within safe operating limits before any simulation.

---

**2. Which exact Linux evidence proves the application is serving traffic?**

 The exact Linux evidence proving my application is serving traffic is the HTTP 200 OK header returned when I execute curl -I http://localhost. Additionally, running sudo ss -lptn reveals that the Nginx master process is successfully bound to port 80 and actively listening for incoming web requests from users over the network.

---

**3. Did your script return exit code 0 or 1? Explain why.**

 My script successfully returned an exit code of 0 because every single health check executed inside the loop passed without a single warning or failure. In Linux scripting, an exit code of 0 explicitly signals a completely healthy, error-free execution, confirming that my entire application infrastructure is currently running exactly as expected

---

**4. What is the difference between a warning and a failure in this script?**

 a warning indicates a non-critical issue, like high disk usage, where the system is running but needs attention, triggering an exit code of 1. A failure means a critical dependency is completely broken, such as Nginx being stopped, which halts traffic entirely and triggers an exit code of 2

---

# Task 6 — Create and Run the /linux-triage Skill

## Goal

Turn the Bash script into a reusable, manually invoked Agentic AI workflow.

### Evidence

#### Screenshot 11 — `SKILL.md` showing the frontmatter, allowed tool restrictions, and safety rules

![alt text](<screenshots/assignment 06-task6-screenshot 11.JPG>)

---

#### Screenshot 12 — `/linux-triage` output for the healthy server


![alt text](<screenshots/assignment 06-task6-screenshot 12.JPG>)
---

### Notes

Answer the following in your own words:

**1. Why does this skill have Bash, Read, and Grep, but not Write?**

 I restrict this skill to Bash, Read, and Grep while omitting Write access as a crucial security safeguard for my server environments. This setup allows me to safely gather system metrics, read existing log files, and filter diagnostic data without risking accidental, automated modifications or destructive overrides to my live configuration files and deployment scripts.
---

**2. Why is `disable-model-invocation: true` useful for this skill?**

 Setting disable-model-invocation: true is incredibly useful because it prevents the AI from generating and running arbitrary commands during critical diagnostic runs. This flag ensures that only pre-approved, safe commands are executed, protecting my infrastructure from unexpected operations while maintaining strict, predictable control over how the system is audited and queried in real time.

---

**3. What part is performed by Bash, and what part is performed by Claude?**

 In this workflow, Bash performs the heavy lifting on the operating system level, executing the actual commands, querying system ports, and collecting raw terminal outputs from my server. Claude then acts as the analytical layer, interpreting that raw text data, parsing complex log details, and translating technical outputs into clear, actionable troubleshooting insights.

---

**4. Why is this better than asking Claude "Is my server healthy?" without giving it evidence?**

 Asking if my server is healthy without evidence forces the AI to guess, which leads to generic advice or dangerous assumptions. By feeding Claude concrete terminal outputs instead, I ensure its analysis is grounded in real-time facts, allowing it to pinpoint the exact port conflict, service failure, or configuration issue currently affecting my environment.

---

# Task 7 — Simulate an Nginx Incident and Let the Skill Diagnose It

## Goal

Create a controlled service failure, gather evidence through Bash, and let Claude analyze the evidence without taking recovery action.

### Evidence

#### Screenshot 13 — Output showing Nginx is inactive and the HTTP request fails


![alt text](<screenshots/assignment 06-task7-screenshot 13.JPG>)
---

#### Screenshot 14 — `/linux-triage` output showing failed evidence, most likely cause, and a suggested recovery command


![alt text](<screenshots/assignment 06-task7-screenshot 14.JPG>)
---

#### Screenshot 15 — `incident-failure-report.txt` showing the failed checks and your Full Name

![alt text](<screenshots/assignment 06-task7-screenshot 15.JPG>)

---

### Notes

Answer the following in your own words:

**1. Which three checks failed?**


 During my system diagnostic run, the three specific health checks that failed were the Nginx web server service check, the port 80 socket binding verification, and the local HTTP traffic response test. Because these three core components are deeply dependent on one another, the failure of the master web process triggered a cascading shutdown across all three.
---

**2. What evidence supports the conclusion that Nginx is unavailable?**

 The concrete Linux evidence proving Nginx is unavailable includes my system check script returning a critical error state instead of a healthy status. Additionally, running sudo systemctl status nginx showed the service was inactive, while sudo ss -lptn confirmed nothing was listening on port 80, and running my curl command resulted in a connection refused error.

---

**3. Did Claude execute the recovery command? Why is that important?**

 No, Claude did not execute the recovery command because our strict operational guidelines forbid the AI from executing writing or destructive commands. This boundary is incredibly important because it keeps me, the human engineer, in complete control of my environment, preventing automated tools from applying unverified changes that could disrupt other services.

---

**4. Which phase of the Agentic Loop is represented by the Bash report?**

 The Bash report represents the Gather phase of the Agentic Loop, where raw, unfiltered system metrics are collected directly from the server. This phase is where my custom script queries the OS, checks port bindings, and logs actual error codes, providing the baseline empirical evidence needed to understand the system's state

---

**5. Which phase is represented by Claude's explanation?**

 Claude's explanation represents the Analyze phase of the Agentic Loop, where the raw terminal outputs and script exit codes are interpreted. During this phase, the AI processes the unstructured log files and diagnostic data collected earlier, turning the technical evidence into a clear, structured diagnosis that explains exactly why my web server failed.


---

# Task 8 — Recover Manually, Verify Again, and Write the Incident Summary

## Goal

Recover the service as the human operator and prove that the system is healthy again.

### Evidence

#### Screenshot 16 — Output showing Nginx is active and `curl -I http://localhost` returns 200 OK

![alt text](<screenshots/assignment 06-task8-screenshot 16.JPG>)

---

#### Screenshot 17 — Second `/linux-triage` output showing successful recovery with no FAIL results


![alt text](<screenshots/assignment 06-task8-screenshot 17.JPG>)
---

#### Screenshot 18 — Output of `ls -lah reports` showing both `incident-failure-report.txt` and `recovery-report.txt`

![alt text](<screenshots/assignment 06-task8-screenshot 18.JPG>)

---

#### Screenshot 19 — `incident-summary.md` showing all required sections and your Full Name

![alt text](<screenshots/assignment 06-task8-screenshot 19.JPG>)

---

### Notes

Answer the following in your own words:

**1. What action did you execute manually?**

 To resolve the outage, I manually executed the recovery command sudo systemctl start nginx directly inside my server's terminal to bring the web service back online. Because our strict safety rules keep execution privileges in human hands, I had to review the diagnosis myself first and then intentionally trigger the restart to fix the broken pipeline.



---

**2. What evidence proves that the service recovered?**

 The empirical evidence proving recovery is my diagnostic script successfully returning a clean exit code of 0 and showing all green statuses. Additionally, running sudo systemctl status nginx confirms the process is active and running, while executing curl -I http://localhost successfully streams back a healthy HTTP 200 OK header response over port 80.

---

**3. Why is the second triage run necessary?**

 Executing the second triage run is absolutely necessary to verify that my manual recovery action actually fixed the root cause of the incident without creating new issues. Running the health checks again provides real-time data confirming that all system ports, file paths, and service configurations have completely returned to their stable, healthy baseline state.

---

**4. What could go wrong if an AI agent automatically restarted every failed service?**

 If an AI automatically restarted failed services, it could trigger a dangerous loop that masks severe architectural problems, like a broken configuration or corrupted files. The agent might repeatedly restart a failing application, overloading system resources, exhausting logs, and potentially crashing the underlying infrastructure while delaying the crucial root-cause investigation required by an engineer.

---

**5. In one sentence, explain the difference between using AI as a chatbot and using AI in this agentic workflow.**

 While a standard chatbot simply generates passive text answers to general questions, this agentic workflow integrates the AI directly into my live engineering pipeline to analyze real-time server evidence and help guide actual infrastructure troubleshooting steps.

---

# Incident Summary

Fill in all seven sections below in your own words.

**Full Name:** Add your full name here

**Date:** DD/MM/YYYY

---

**1. Reported Symptom**

 My local application appeared completely down when I attempted to access it. Running a network test with the command curl -I http://localhost consistently resulted in a connection failure, returning a generic HTTP status code of 000, which clearly indicated that the local web service was entirely unreachable over the network.

---

**2. Evidence Collected**

 Using the automated /linux-triage Bash script, I collected three clear pieces of failure evidence. First, the Nginx service status returned a [FAIL] state showing it was stopped. Second, port 80 was not bound by any active processes. Finally, the local HTTP traffic connection check failed completely with status code 000.

---

**3. Most Likely Cause**

 The most likely cause of this incident is that the Nginx service was unexpectedly stopped or disabled on the server. Because the master process was inactive, port 80 could not be bound, which completely blocked the web server from listening to incoming HTTP traffic and triggered the subsequent web connection failures.


---

**4. Human-Approved Recovery Action**

 After carefully reviewing the safe troubleshooting recommendations generated by the Claude triage skill, I chose to manually approve and execute the recovery command myself. I opened my server's terminal and ran sudo systemctl start nginx to successfully initiate the process and bring the web service back online without further delays.

---

**5. Verification**

 To verify recovery, I performed three distinct checks. First, I ran systemctl is-active nginx and received an active response. Next, executing curl -I http://localhost successfully returned a proper HTTP 200 OK header. Finally, I reran the /linux-triage automated skill, confirming all five internal system health checks passed completely and cleanly.

---

**6. Safety Decision**

 I intentionally restricted the Claude triage tool exclusively to gathering information and analyzing server evidence to protect operational safety. Keeping execution privileges out of the AI's hands entirely prevents dangerous system incidents like unexpected server downtime, destructive automated configuration changes, or unauthorized root command runs across my live infrastructure.

---

**7. Agentic Loop Mapping**

 This automation sequence perfectly maps out the structural phases of the Agentic Loop. Running my triage scripts to check port states represents the Gather phase, while letting Claude process the errors represents Analyze. My manual verification represents the final Verify phase, ensuring the pipeline returned to its baseline state properly.

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://www.linkedin.com/posts/busola-helen-awotimide_the-first-diagnosis-is-usually-the-most-dangerous-activity-7483641334386327553-RW5W?utm_source=share&utm_medium=member_desktop&rcm=ACoAADtjPKMBDnsQhcIAGnVO4so-PBvk2dEBay4

---

#### Screenshot — Published LinkedIn post

![alt text](<screenshots/linkedin assignment 06.JPG>)


## BLOG POST :https://medium.com/@awsawotimide/building-bridges-with-bash-and-ai-my-journey-taming-cloud-pipelines-4530966bf8aa?sharedUserId=awsawotimide

## BLOG screenshot: 

![alt text](<screenshots/blog post.JPG>) 

![alt text](<screenshots/Blog post 2.JPG>)


---

# GitHub Repository URL

Paste the URL of your GitHub folder or repository containing the assignment files here:

https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git
---

# Submission Instructions

- Add all required screenshots in your submission
- Full Name must be visible in required screenshots and the Bash report
- All written answers must be in your own words
- Do not expose sensitive information (keys, passwords, AWS account IDs, tokens)
- GitHub URL must be included in this document

---

# Completion Checklist

- [ ] Task 1: Healthy baseline confirmed, workspace created (Screenshots 1–2, Notes answered)
- [ ] Task 2: CLAUDE.md created with all four sections (Screenshot 3, Notes answered)
- [ ] Task 3: Five-check plan produced by Claude using read-only tools (Screenshot 4, Notes answered)
- [ ] Task 4: `linux-triage.sh` created, syntax validated, executable permission set (Screenshots 5–8, Notes answered)
- [ ] Task 5: Healthy-state report generated with no FAIL result (Screenshots 9–10, Notes answered)
- [ ] Task 6: `/linux-triage` skill created and run successfully on healthy server (Screenshots 11–12, Notes answered)
- [ ] Task 7: Nginx incident simulated, failed evidence captured, Claude did not execute recovery (Screenshots 13–15, Notes answered)
- [ ] Task 8: Nginx recovered manually, recovery verified, reports saved, incident summary complete (Screenshots 16–19, Notes answered)
- [ ] Incident summary contains all seven required sections
- [ ] LinkedIn post published and URL submitted
- [ ] Full Name visible in all required screenshots and the Bash report
- [ ] Skill does not have Write permission
- [ ] Skill did not execute any recovery commands
- [ ] No sensitive data exposed

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