# Assignment 6 — AI-Assisted Terraform Drift and Policy Review

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Student Details

**Full Name:** Busola Helen Awotimide
**GitHub Repository/Folder URL:** Add your GitHub URL here

---

## Purpose

Build a read-only Terraform drift and policy review workflow using Bash, Terraform plan data, `jq`, Claude Code, a reusable `/tf-drift-review` Skill, and a `PreToolUse` safety hook.

The workflow must follow this pattern:

```text
Gather Evidence
  --> Analyze with Agentic AI
  --> Human Reviews and Acts
  --> Verify the Result
```

The `/tf-drift-review` Skill and `tf-drift-check.sh` must never run `terraform apply`, `terraform destroy`, or commands using `-auto-approve`.

---

# Task 1 — Confirm the Clean Baseline and Create the Workspace

## Goal

Confirm that your Terraform configuration and deployed infrastructure are currently aligned before building the drift-review workflow.

## Evidence

### Screenshot 1 — Clean Terraform Plan

Add a screenshot of `terraform plan` showing no pending changes.

![alt text](<screenshots/week 08-assignment 6-task1-screenshot1.JPG>)
---

### Screenshot 2 — Assignment Workspace

Add a screenshot of the folder structure showing `AI Assignment/`, `reports/`, and the Terraform project.

![alt text](<screenshots/week 08-assignment 6-task1-screenshot2.JPG>)

## Questions

### 1. What does `No changes` tell you about the current relationship between Terraform and the deployed infrastructure?

It tells me that the real-world cloud infrastructure managed by my Terraform configuration matches the desired state defined in my HCL code and state file, with zero divergence or pending alterations.

### 2. Why is a clean baseline important before introducing a test change?

A clean baseline ensures that any subsequent plan outputs or drift reports exclusively capture the specific, intentional changes I introduce, preventing noise or pre-existing uncommitted discrepancies from confusing the review.


---

# Task 2 — Create Project Context and Safety Rules in `CLAUDE.md`

## Goal

Provide Claude Code with clear project context, evidence requirements, and safety boundaries.

## Evidence

### Screenshot 3 — Project Context and Safety Rules

Add a screenshot of `CLAUDE.md` open in VS Code showing the Project Overview, Review Workflow, Safety Rules, and Output Rules.

![alt text](<screenshots/week 08-assignment 6-task2-screenshot3.JPG>)

## Questions

### 1. Why should Claude receive project-specific rules about what counts as valid evidence?

It prevents the AI from relying on hallucinated assumptions or conversational guesses, forcing it to anchor all analysis strictly on deterministic outputs like JSON plan files and generated text reports

### 2. Why must the human remain responsible for running `terraform apply`?

Infrastructure-mutating operations carry high risks of unintended service disruption or resource deletion, requiring human judgment and validation before execution.

### 3. Which rule prevents Claude from declaring a change safe without evidence?

The output and safety rules mandate that any security or health declaration must be backed by explicit programmatic proof from the evidence-gathering script.

---

# Task 3 — Build the Terraform Drift and Policy Check Script

## Goal

Create a Bash script that gathers Terraform plan evidence and checks it for destructive actions and unsafe ingress rules.

## Evidence

### Screenshot 4 — Script Variables and Checks Array

Add a screenshot of the top section of `tf-drift-check.sh` showing the variables and `checks` array.

![alt text](<screenshots/week 08-assignment 6-task3-screenshot4.JPG>)
---

### Screenshot 5 — Destructive-Action and Open-Ingress Checks

Add a screenshot showing `check_destructive_actions` and `check_open_ingress`, including the `jq` checks.

![alt text](<screenshots/week 08-assignment 6-task3-screenshot5.JPG>)

---

### Screenshot 6 — Script Validation and Permissions

Add a screenshot showing successful `bash -n` and `ls -l` output.

![alt text](<screenshots/week 08-assignment 6-task3-screenshot6.JPG>)

## Questions

### 1. What does `terraform plan -detailed-exitcode` return for exit codes `0`, `1`, and `2`?

0 indicates no changes/success, 1 indicates an error occurred, and 2 indicates that changes are pending.

### 2. Why is Terraform plan JSON easier and safer to automate against than parsing human-readable Terraform output?

JSON provides a structured, machine-parsable schema that jq can reliably query without breaking due to formatting or phrasing shifts in standard terminal outputs.

### 3. What type of resource action does `check_destructive_actions` search for?

It searches for destructive lifecycle actions such as delete or destroy operations.

### 4. Why does finding a `delete` action also help detect replacements?

In Terraform, a resource replacement is executed as a destroy (delete) action followed by a create action, so catching a delete ensures replacements are flagged

### 5. Why must this script never run `terraform apply`?

The script's sole architectural purpose is read-only inspection and evidence gathering; running apply automatically would violate safety controls and bypass human review.

---

# Task 4 — Run the Script Against the Clean Baseline

## Goal

Verify that the review workflow reports a healthy result against your clean Terraform environment.

## Evidence

### Screenshot 7 — Healthy Baseline Report

Add a screenshot of the drift script output showing your full name and a `HEALTHY` result.

![alt text](<screenshots/week 08-assignment 6-task4-screenshot7.JPG>)

---

### Screenshot 8 — Baseline Script Exit Code

Add a screenshot showing the captured script exit code `0`.

![alt text](<screenshots/week 08-assignment 6-task4-screenshot8.JPG>)

## Questions

### 1. What is the Overall Status of your baseline?

Overall Status: HEALTHY

### 2. Which evidence proves there are currently no pending Terraform changes?

The terraform plan exit code 0 – no pending changes check and zero warning or failure flags in the summary report

### 3. Was `reports/tfplan.json` created? Explain why or why not.

Yes, because the evidence script generated and parsed the JSON plan representation to evaluate resource actions programmatically.

---

# Task 5 — Create and Run the `/tf-drift-review` Claude Code Skill

## Goal

Turn the Bash evidence-gathering workflow into a reusable Agentic AI review process.

## Evidence

### Screenshot 9 — `/tf-drift-review` Skill Configuration

Add a screenshot of `SKILL.md` showing the frontmatter, allowed tools, and safety rules.


![alt text](<screenshots/week 08-assignment 6-task5-screenshot9.JPG>)
---

### Screenshot 10 — Clean Agentic AI Review

Add a screenshot of `/tf-drift-review` showing the clean `HEALTHY` result.

![alt text](<screenshots/week 08-assignment 6-task5-screenshot10.JPG>)

## Questions

### 1. Why does this Skill have `Bash`, `Read`, and `Grep`, but not `Write`?

To enforce a strict read-only security boundary, preventing the agent from modifying code or executing destructive deployment commands

### 2. Why is manual invocation useful for this type of high-impact infrastructure review?

It gives the engineer explicit control over when the review runs, ensuring audits are performed intentionally at critical deployment gates.

### 3. Which part of the workflow is deterministic Bash automation?

The execution of tf-drift-check.sh, jq parsing, and exit-code evaluation.

### 4. Which part requires Claude's reasoning?

Synthesizing the gathered text reports, explaining security implications, and formatting the risk assessment summary


### 5. Why is this workflow better than simply asking Claude, “Is my infrastructure safe?”

Because an open-ended chatbot relies on general conversation, whereas this workflow forces Claude to analyze concrete, real-time programmatic evidence generated directly from the live state file.

---

# Task 6 — Introduce a Controlled Difference and Detect It

## Goal

Create a safe, intentional difference and confirm that Terraform and Claude detect and explain it.

## Evidence

### Screenshot 11 — Controlled Difference

Add a screenshot of the controlled change you introduced, with sensitive details hidden.

![alt text](<screenshots/week 08-assignment 6-task6-screenshot11.JPG>)

---

### Screenshot 12 — Detected Difference and Risk Assessment

Add a screenshot of `/tf-drift-review` showing the detected difference and risk assessment.

![alt text](<screenshots/week 08-assignment 6-task6-screenshot12.JPG>)

---

### Screenshot 13 — Detected Drift Report

Add a screenshot of `drift-detected-report.txt` showing your full name and the `WARN` or `FAIL` result.

![alt text](<screenshots/week 08-assignment 6-task6-screenshot13.JPG>)

## Questions

### 1. What change did you introduce?

An intentional modification to cloud resource configuration/tags to trigger a drift condition.

### 2. Was it true infrastructure drift or a Terraform configuration change?

It was a Terraform configuration change tested under controlled conditions.

### 3. What Terraform plan evidence proves that a change is pending?

The non-zero plan output showing modifications and exit code 2.

### 4. Was the action an update, deletion, replacement, or security-rule change?

An update action on the target resource

### 5. What did Claude recommend?

Claude recommended reviewing the exact diff and executing a controlled apply if the modification was authorized

### 6. Why should you review the recommendation before taking action?

To ensure the AI's interpretation aligns with system requirements and that no hidden risks or unintended resource replacements were overlooked.

---

# Task 7 — Add a `PreToolUse` Hook to Block Unsafe Apply Attempts

## Goal

Add a Claude Code safety control that prevents `terraform apply` from running through Claude Code when the most recent drift report contains:

```text
Overall Status: FAIL
```

## Evidence

### Screenshot 14 — `PreToolUse` Safety Hook

Add a screenshot of `.claude/settings.json` showing the `PreToolUse` safety hook.

![alt text](<screenshots/week 08-assignment 6-task7-screenshot14.JPG>)
---

### Screenshot 15 — Blocked Apply Attempt

Add a screenshot of Claude Code showing the blocked `terraform apply` attempt.

![alt text](<screenshots/week 08-assignment 6-task7-screenshot15.JPG>)

## Questions

### 1. What is the difference between the `/tf-drift-review` Skill and the `PreToolUse` hook?

The Skill is an on-demand analysis tool for generating reports, whereas the PreToolUse hook is an automated safety gate that intercepts tool calls right before execution.


### 2. Which component performs analysis?

The /tf-drift-review skill and underlying Bash check script.


### 3. Which component enforces the safety gate?

The PreToolUse settings hook in .claude/settings.json


### 4. Why does the hook inspect the existing report rather than making an infrastructure decision itself?

It decouples safety enforcement from AI judgment, relying on hardcoded programmatic report statuses rather than conversational AI intent.

### 5. Why is a deterministic guard useful for high-impact commands?

It eliminates ambiguity and guarantees that dangerous commands cannot slip through due to misinterpretation or prompt injection.

---

# Task 8 — Resolve the Difference and Verify the Final State

## Goal

Resolve the detected difference intentionally, verify the infrastructure returns to the intended state, and document the complete review process.

## Evidence

### Screenshot 16 — Human-Reviewed Resolution

Add a screenshot of the human-reviewed resolution or `terraform apply` output where applicable.

![alt text](<screenshots/week 08-assignment 6-task8-screenshot16.JPG>)

---

### Screenshot 17 — Final Healthy Review

Add a screenshot of the final `/tf-drift-review` showing `HEALTHY`.

![alt text](<screenshots/week 08-assignment 6-task8-screenshot17.JPG>)

---

### Screenshot 18 — Saved Reports

Add a screenshot of `ls -lah reports` showing both:

- `drift-detected-report.txt`
- `resolved-report.txt`

![alt text](<screenshots/week 08-assignment 6-task8-screenshot18.JPG>)

---

### Screenshot 19 — Drift Review Summary

Add a screenshot of `drift-review-summary.md` showing all required sections and your full name.

![alt text](<screenshots/week 08-assignment 6-task8-screenshot19.JPG>)

## Terraform Drift Review Summary

### 1. Change Introduced

Explain the controlled change you introduced.

State whether it was:

- True infrastructure drift, or
- A Terraform configuration change

Controlled change: Introduced a deliberate resource configuration change to trigger evaluation workflows.

Type: Terraform configuration change.

### 2. Evidence Collected

Describe the Terraform plan evidence and affected resource.

Plan evidence: Captured pending resource diffs via terraform plan -detailed-exitcode and parsed output structures.

Affected resource: Application compute and security baseline configurations tracked in the state.

### 3. Risk Assessment

Explain the risk identified by the Bash check and Claude Code.

Identified risk: Flagged potential configuration divergence and rule mismatches before synchronization.

### 4. Human-Approved Action

Explain the action you reviewed and executed manually.

Executed action: Reviewed plan details manually and executed terraform apply to realign infrastructure.

### 5. Verification

Explain the evidence proving the environment returned to the intended state.

Evidence: Post-remediation review scripts confirmed Overall Status: HEALTHY with exit code 0

### 6. Safety Decision

Explain why Claude was allowed to gather and analyze evidence but not automatically perform infrastructure-changing actions.

Rationale: Claude was restricted to evidence gathering and analysis to maintain strict human control over cloud mutation actions.

### 7. Agentic Loop Mapping

Explain how your workflow followed:

```text
Gather --> Analyze --> Human Act --> Verify
```



## Questions

### 1. What action did you execute to resolve the difference?

Executed terraform apply tfplan.out to synchronize real-world infrastructure with the desired state configuration

### 2. Did you review `terraform plan` before taking action?

Yes, the plan output and summary report were thoroughly reviewed prior to applying changes.

### 3. What evidence proves the environment is now aligned?

The post-remediation drift review report showing Overall Status: HEALTHY and zero pending modifications


### 4. Why is a second drift review required after the fix?

To provide programmatic verification that the applied resolution successfully corrected the discrepancy

### 5. What could go wrong if an AI agent automatically applied every detected Terraform change?


The agent could introduce unintended resource destruction, security regressions, or service downtime without human oversight.

### 6. In one sentence, explain the difference between asking an AI chatbot “Is my infrastructure okay?” and using this evidence-based Agentic AI workflow.

Asking a chatbot yields conversational speculation, whereas this workflow programmatically gathers plan JSON, evaluates policy checks through deterministic scripts, and enforces strict pre-execution safety hooks.

---

# LinkedIn Post — Mandatory

## Goal

Publish a LinkedIn post in your own words describing:

- The Terraform drift-and-policy review workflow you built
- The Bash evidence-gathering script
- The Claude Code `/tf-drift-review` Skill
- The controlled difference you introduced
- How the workflow identified the risk
- How the `PreToolUse` hook acted as a safety gate
- Why human review remained part of the process
- One lesson you learned about reviewing `terraform plan`

Include a screenshot of the detected change and a screenshot of the final `HEALTHY` review in your post.

Suggested tags:

```text
#DMIByPravinMishra #Terraform #AgenticAI #ClaudeCode #DevOps
```

## LinkedIn Evidence

### LinkedIn Post URL



### Published LinkedIn Post Screenshot — Mandatory



---

# Required Assignment Files

Confirm that the following files are included in your GitHub repository:

- `CLAUDE.md`
- `AI Assignment/tf-drift-check.sh`
- `.claude/skills/tf-drift-review/SKILL.md`
- `.claude/settings.json` containing the safety hook
- `reports/drift-detected-report.txt`
- `reports/resolved-report.txt`
- `drift-review-summary.md`

---

# Submission Instructions

- Complete Tasks 1–8 in sequence.
- Include Screenshots 1–19 exactly as specified.
- Answer every question under Tasks 1–8 in your own words.
- Complete all seven sections of the Terraform Drift Review Summary.
- Include the GitHub repository/folder URL containing the assignment files.
- Include your full name in the required reports and screenshots.
- Include the LinkedIn post URL and a screenshot of the published LinkedIn post.
- Do not expose access keys, passwords, tokens, account IDs, private keys, Terraform secrets, or other sensitive information.
- Review all screenshots carefully and hide or redact sensitive details where necessary.

---

# Completion Checklist

- [ ] Confirmed a clean Terraform baseline
- [ ] Created the required assignment workspace
- [ ] Created or updated `CLAUDE.md`
- [ ] Added project context and safety rules
- [ ] Created `tf-drift-check.sh`
- [ ] Added my full name to the report
- [ ] Validated the Bash script
- [ ] Made the script executable
- [ ] Used `terraform plan -detailed-exitcode`
- [ ] Used Terraform plan JSON
- [ ] Used `jq` to inspect destructive actions
- [ ] Used `jq` to inspect unsafe ingress
- [ ] Confirmed the baseline returns `HEALTHY`
- [ ] Created `/tf-drift-review`
- [ ] Restricted the Skill to appropriate tools
- [ ] Confirmed the Skill remains read-only
- [ ] Confirmed the Skill never runs `terraform apply`
- [ ] Confirmed the Skill never runs `terraform destroy`
- [ ] Introduced a controlled detectable difference
- [ ] Correctly identified whether it was true drift or a configuration change
- [ ] Saved `drift-detected-report.txt`
- [ ] Added the `PreToolUse` safety hook
- [ ] Verified the hook blocks `terraform apply` when the report is `FAIL`
- [ ] Reviewed the Terraform evidence before resolving the change
- [ ] Performed any infrastructure-changing action manually
- [ ] Ran the drift review again after resolution
- [ ] Confirmed the final status is `HEALTHY`
- [ ] Saved `resolved-report.txt`
- [ ] Completed `drift-review-summary.md`
- [ ] Mapped the workflow to `Gather --> Analyze --> Human Act --> Verify`
- [ ] Included all 19 numbered screenshots
- [ ] Answered all required questions
- [ ] Published the required LinkedIn post
- [ ] Added the LinkedIn post URL and screenshot
- [ ] Included the GitHub repository/folder URL
- [ ] Confirmed that no sensitive information is exposed

---

*This submission is part of the DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*
