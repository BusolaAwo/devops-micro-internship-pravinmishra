# Assignment 5 — AI-Assisted Azure DevOps Dual-Pipeline Failure Triage

Part of the DevOps Micro Internship (DMI) — Agentic AI Track

---

## Student Information

**Full Name:** Busola Helen Awotimide

**GitHub Repository or Fork URL:** https://github.com/BusolaAwo/infra-epicbook.git

**Public LinkedIn Post URL:** 

---

## Purpose

In this assignment, I configured an AI-assisted, read-only failure-triage workflow for the EpicBook Infrastructure and Application Pipelines. The workflow uses Bash to gather Azure DevOps pipeline evidence and Claude Code to analyze the evidence and recommend a recovery action while keeping all changes under human control.

---

# Task 0 — Verify Tools, Authentication, and Pipeline Details

## Goal

Verify the required tools, Azure DevOps authentication, organization and project details, and numeric pipeline IDs.

No screenshot is required for this task.

---

# Task 1 — Capture the Healthy Baseline and Prepare the Supplied Files

## Goal

Confirm that both EpicBook pipelines are healthy and place the supplied assignment files in the correct repository locations.

## Evidence

### Screenshot 1 — Healthy Baseline for Both Pipelines

Terminal output showing the latest completed Infrastructure and Application Pipeline runs with successful results.

![alt text](<screenshots/week 10-assignment 5-task1-screenshot1.JPG>)

## Notes

### 1. What proves that both pipelines were healthy before the drill?

The latest completed runs for both the Infrastructure Pipeline and the Application Pipeline returned a successful status (green checkmarks) with exit code 0, confirming that all deployment and configuration stages executed without errors.

### 2. Why is a healthy baseline necessary before introducing a controlled failure?

Establishing a verified healthy baseline ensures that any subsequent failures or anomalies detected by the triage script are strictly the result of the intentional drill rather than pre-existing environmental or configuration issues.

---

# Task 2 — Configure and Review the Supplied CLAUDE.md

## Goal

Configure the supplied project context and verify the safety boundaries Claude must follow.

## Evidence

### Screenshot 2 — CLAUDE.md Context and Safety Rules

`CLAUDE.md` open in the editor with the Project Overview, Incident Workflow, Safety Rules, and Output Rules visible.

![alt text](<screenshots/week 10-assignment 5-task2-screenshot2.JPG>)

## Notes

### 1. Why does Claude need project-specific operational context?

Project-specific operational context provides Claude with necessary details about the repository architecture, pipeline IDs, toolsets, and workflow expectations, allowing it to interpret diagnostics accurately within the correct environment.

### 2. Which rules keep the human responsible for the recovery action?

Rules stating that Claude must operate in a read-only capacity, must not automatically apply fixes, and must require explicit human review and execution ensure that final recovery actions remain entirely under human control.

### 3. Which rules protect pipeline credentials and application secrets?

Safety and output rules strictly prohibit exposing Personal Access Tokens (PATs), connection strings, passwords, or raw logs containing sensitive information in reports or public outputs.
---

# Task 3 — Configure and Validate the Supplied Pipeline Triage Script

## Goal

Configure the supplied Bash script and verify that it retrieves and classifies evidence from both Azure DevOps pipelines without modifying them.

## Evidence

### Screenshot 3 — Pipeline Triage Script Configuration

Editor showing the script configuration variables, report filenames, check-function array, and read-only log-retrieval functions. Ensure that no token is visible.

![alt text](<screenshots/week 10-assignment 5-task3-screenshot3.JPG>)

---

### Screenshot 4 — Script Validation

Terminal showing successful Bash syntax validation and executable file permission.

![alt text](<screenshots/week 10-assignment 5-task3-screenshot4.JPG>)

## Notes

### 1. Why are pipeline metadata and step console logs handled separately?

Pipeline metadata provides structural status and run identifiers, whereas console logs contain the specific task output and error traces required for deep diagnostic classification.

### 2. How does the script obtain the actual console logs?

The script queries the Azure DevOps REST API and CLI tools in a read-only manner using pipeline run IDs and job log endpoints to fetch step outputs.


### 3. How does the check-function array control the classification loop?

The check-function array iterates through modular verification rules sequentially, testing each pipeline's state against defined failure categories until a match is found.

### 4. What prevents a failed but unmatched run from being reported as healthy?

The script enforces strict exit-code and status evaluation checks; any non-success status that does not match defined healthy criteria defaults to an error or unmatched failure classification rather than passing as healthy.


### 5. Why are different exit codes useful to another automation tool?

Distinct exit codes allow external CI/CD wrappers, monitoring scripts, or orchestration tools to programmatically determine whether a pipeline run succeeded (0) or encountered specific failure categories without parsing raw text output.

---

# Task 4 — Run and Understand the Healthy-State Report

## Goal

Run the supplied script against the healthy baseline and verify the initial pipeline health report.

## Evidence

### Screenshot 5 — Healthy Pipeline Report

Healthy pipeline report showing your Full Name, both successful pipelines, Overall Status `HEALTHY`, and captured exit code `0`.

![alt text](<screenshots/week 10-assignment 5-task4-screenshot5.JPG>)

## Notes

### 1. What evidence proves that both pipelines are healthy?

The health report displays an Overall Status of HEALTHY, confirms successful completion for both pipelines, and records an exit code of 0.

### 2. Why must the baseline exit code be verified before the incident drill?

Verifying the baseline exit code (0) confirms that the automation reporting mechanism functions correctly and establishes a valid reference point prior to introducing disruptions.


---

# Task 5 — Configure and Test the Supplied /pipeline-triage Skill

## Goal

Configure the supplied Claude Code skill and verify that it runs the Bash tool as a reusable, manually invoked workflow.

## Evidence

### Screenshot 6 — Pipeline-Triage Skill Definition

`SKILL.md` showing the frontmatter, manual-invocation setting, narrowly scoped tools, safety rules, and required output structure.

![alt text](<screenshots/week 10-assignment 5-task5-screenshot6.JPG>)

---

### Screenshot 7 — Healthy Skill Result

Healthy `/pipeline-triage` result showing that both pipelines are healthy and no fix is required.

![alt text](<screenshots/week 10-assignment 5-task5-screenshot7.JPG>)

## Notes

### 1. Why is `disable-model-invocation: true` appropriate for this skill?

Setting disable-model-invocation: true prevents the model from autonomously or continuously triggering the skill without explicit user intent, ensuring human oversight over every invocation

### 2. Why should the skill avoid broad Bash approval?

Avoiding broad Bash approval restricts execution to pre-approved, read-only diagnostic commands, preventing unintended file modifications, credential leaks, or destructive infrastructure changes

### 3. What work is performed by Bash, and what work is performed by Claude?

Bash executes the deterministic retrieval of pipeline status and logs via Azure CLI/API calls, while Claude analyzes the gathered evidence, categorizes the failure, and structures the diagnostic recommendation.

### 4. Why are permission rules required in addition to written safety instructions?

Written instructions guide model intent, whereas explicit tool permission rules programmatically enforce constraints at the system level to block unauthorized actions.

---

# Task 6 — Introduce a Safe Failure in the Application Pipeline

## Goal

Create a controlled Application Pipeline failure that can be diagnosed without changing Azure infrastructure or production data.

## Evidence

### Screenshot 8 — Controlled Application Pipeline Failure

Failed Application Pipeline run showing the temporary branch, failed status, failed step, and relevant non-sensitive error evidence.

![alt text](<screenshots/week 10-assignment 5-task6-screenshot8.JPG>)


## Notes

### 1. What exact failure did you introduce?

I introduced a deliberate syntax error (conflicting action statement) within the Ansible database role task configuration file (ansible/roles/database/tasks/main.yml).


### 2. Which category should detect it?

It is detected by the configuration management/pipeline execution failure category.

### 3. Why is the failure safe and easily reversible?

The change was isolated to a configuration task file on a temporary branch, affecting only the execution step without altering live cloud infrastructure or permanent production databases.

### 4. How did you prevent the deliberate failure from reaching `main` or changing the deployed application?

The change was committed and tested strictly within a dedicated drill branch (drill/pipeline-failure) without merging it into the main production branch.

---

# Task 7 — Diagnose and Save the Incident Evidence

## Goal

Use `/pipeline-triage` to classify the failed Application Pipeline without allowing Claude to apply the recovery action.

## Evidence

### Screenshot 9 — Failed-State Diagnosis and Incident Report

`/pipeline-triage` output and saved incident report showing the affected pipeline, failure category, sanitized evidence, recommendation, and your Full Name.

![alt text](<screenshots/week 10-assignment 5-task7-screenshot9.JPG>)

## Notes

### 1. Which failure category was identified?

Ansible playbook execution error / configuration syntax failure.

### 2. What exact evidence supported the diagnosis?

Console log error output indicating a conflicting action statement in /home/vsts/work/1/s/ansible/roles/database/tasks/main.yml.

### 3. Did Claude apply the fix or rerun the pipeline? Why is that important?

No, Claude only diagnosed the issue and recommended a fix. This is critical to maintain human-in-the-loop control and prevent automated, unverified changes from hitting production systems

### 4. Which part represents Gather, and which part represents Analyze?

The execution of the triage script and retrieval of pipeline logs represent the Gather phase, while Claude's inspection and classification of those logs represent the Analyze phase.

---

# Task 8 — Apply the Human-Reviewed Fix and Verify Recovery

## Goal

Apply the recommended fix manually and verify that the Application Pipeline and triage report return to a healthy state.

## Evidence

### Screenshot 10 — Corrected Application Pipeline Run

Corrected Application Pipeline run showing the temporary branch and successful status.

![alt text](<screenshots/week 10-assignment 5-task8-screenshot10.JPG>)


---

### Screenshot 11 — Recovery Triage Result

Recovery `/pipeline-triage` output showing Overall Status `HEALTHY`, exit code `0`, your Full Name, and both saved report filenames.

![alt text](<screenshots/week 10-assignment 5-task8-screenshot11.JPG>)

## Notes

### 1. What exact fix did you apply?

I corrected the conflicting action statement syntax within the Ansible database task file and pushed the fix to the drill branch.

### 2. Did the fix match Claude’s recommendation? Explain briefly.

Yes, the fix matched Claude's recommendation by resolving the syntax conflict identified in the database role task file.

### 3. What evidence proves that the pipeline recovered?

The Azure DevOps pipeline run completed successfully with green checkmarks across all stages, and the subsequent triage report returned Overall Status HEALTHY with exit code 0.

### 4. Why is a second triage run required after the pipeline becomes green?

A second triage run generates the final recovery report (recovery-report.txt) to formally document that the incident has been resolved and the environment has returned to a verified healthy state.

### 5. What risk would be created if Claude could automatically edit, push, approve, and rerun the pipeline?

Automated execution without human gatekeeping creates severe security and operational risks, including unauthorized code modifications, accidental exposure of secrets, service downtime, and deployment of unverified configurations to production.

---

# LinkedIn Post — Mandatory

## LinkedIn Post URL



## Evidence

### Screenshot 12 — Published LinkedIn Post

Published LinkedIn post showing its text and at least one image or link.



---

# Required Repository Files

Confirm that the following files are available in your repository:

* [ ] `CLAUDE.md`
* [ ] `pipeline-triage.sh`
* [ ] `.claude/skills/pipeline-triage/SKILL.md`
* [ ] `reports/incident-failure-report.txt`
* [ ] `reports/recovery-report.txt`

---

# Submission Instructions

* Complete all tasks in sequence.
* Include all 12 required screenshots.
* Answer every Notes question in your own words.
* Include your GitHub repository or fork URL.
* Include your public LinkedIn post URL.
* Ensure your Full Name appears in the required reports.
* Do not include raw logs containing sensitive information.
* Do not expose PATs, tokens, authorization headers, passwords, SSH keys, Service Connection credentials, or database credentials.

---

# Completion Checklist

* [ ] Both Azure DevOps pipelines were healthy before the drill.
* [ ] The supplied files were copied to the correct repository locations.
* [ ] Only the required student-specific placeholders were updated.
* [ ] `CLAUDE.md` contains the required context and safety rules.
* [ ] `pipeline-triage.sh` passed Bash syntax validation.
* [ ] The script has executable permission.
* [ ] The script uses read-only Azure DevOps operations.
* [ ] The script retrieves pipeline metadata and console logs.
* [ ] No token or password is stored in the script.
* [ ] The healthy baseline reported `HEALTHY` with exit code `0`.
* [ ] `/pipeline-triage` was invoked manually.
* [ ] The skill does not have broad Bash approval.
* [ ] The controlled failure affected only the Application Pipeline.
* [ ] The failure occurred before deployment changes were applied.
* [ ] The deliberate failure was not merged into `main`.
* [ ] The failed-state report was saved before applying the fix.
* [ ] Claude diagnosed the failure but did not apply the fix.
* [ ] The fix was reviewed and applied manually.
* [ ] The corrected Application Pipeline completed successfully.
* [ ] The recovery triage reported `HEALTHY` with exit code `0`.
* [ ] `incident-failure-report.txt` exists.
* [ ] `recovery-report.txt` exists.
* [ ] All Notes questions have been answered.
* [ ] All 12 screenshots have been added.
* [ ] The GitHub repository or fork URL has been included.
* [ ] The LinkedIn post is public.
* [ ] The LinkedIn post URL has been included.
* [ ] No sensitive information is exposed.

---

# Final Submission

**Full Name:** [Enter your full name]

**GitHub Repository or Fork URL:** [Paste your repository URL]

**LinkedIn Post URL:** [Paste your public LinkedIn post URL]

---

*This submission is part of the DevOps Micro Internship (DMI) — Agentic AI Track.*
