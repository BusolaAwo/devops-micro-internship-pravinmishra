# Assignment 6 — AI-Assisted Ansible Change Risk Review

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will build an AI-assisted Ansible risk-review workflow using `ansible-playbook --check --diff`, Bash scripting, and Claude Code.

You will review possible server changes before applying them, classify risky tasks, and keep the final apply decision under human control.

---

# Task 1 — Confirm EpicBook Connectivity and Create the Workspace

## Goal

Confirm that your previous EpicBook Ansible project is working before creating the risk-review automation.

### Evidence

#### Screenshot 1 — Output of `ansible web -i inventory.ini -m ping`

![alt text](<screenshots/week 09-assignment 6-task1-screenshot1.JPG>)

---

#### Screenshot 2 — Output of `ansible-playbook -i inventory.ini site.yml --syntax-check`

![alt text](<screenshots/week 09-assignment 6-task1-screenshot2.JPG>)

---

#### Screenshot 3 — Output of `pwd` and `find . -maxdepth 4 -type d | sort`

![alt text](<screenshots/week 09-assignment 6-task1-screenshot3.JPG>)

---

### Notes

Answer the following in your own words:

**1. What proves that Ansible can reach your EpicBook VM?**

The successful ping return output (57.156.59.246 | SUCCESS => {"ping": "pong"}) confirming active network reachability and valid authentication.

---

**2. Why should you confirm playbook syntax before building a risk-review script?**

To ensure there are no YAML syntax errors, missing indentation, or parsing issues that would cause the underlying Ansible command to crash before dry-run execution begins.

---

# Task 2 — Create Project Context and Safety Rules in CLAUDE.md

## Goal

Create a `CLAUDE.md` file that tells Claude Code how this project must behave.

### Evidence

#### Screenshot 4 — `CLAUDE.md` open in VS Code or terminal showing the safety rules

![alt text](<screenshots/week 09-assignment 6-task2-screenshot4.JPG>)

---

### Notes

Answer the following in your own words:

**1. Why should Claude Code have project-specific safety rules?**

To establish strict operational guardrails, restricting autonomous execution and ensuring critical infrastructure modifications always remain under human oversight.

---

**2. Why should the human run the real Ansible playbook manually?**

Because the human operator holds final operational accountability and must review risk assessments before authorizing any state-changing production apply.

---

**3. Which rule prevents Claude Code from applying changes automatically?**

The safety directive prohibiting automated playbook execution (ansible-playbook without --check) and file modifications during audit tasks.

---

# Task 3 — Ask Claude Code to Plan the Risk Review

## Goal

Use Claude Code to produce a read-only plan before writing the Bash script.

### Evidence

#### Screenshot 5 — Claude Code showing the four-category risk-classification plan

![alt text](<screenshots/week 09-assignment 6-task3-screenshot5.JPG>)

---

### Notes

Answer the following in your own words:

**1. Which part of this task represents the Gather phase?**

The execution of the underlying check command (ansible-playbook --check --diff) to capture target state differences and raw text output.

---

**2. Which part represents the Analyze phase?**

The automated pattern-matching and categorization of changed tasks into risk tiers by the review script and Claude's code analysis.

---

**3. How did you verify Claude Code did not create or edit files?**

By verifying tool permission boundaries in the session logs and inspecting directory listings to confirm no modifications occurred during the planning phase.

---

# Task 4 — Build the Ansible Risk Review Script

## Goal

Create a Bash script that runs an Ansible dry run and classifies risky changes.

### Evidence

#### Screenshot 6 — Top section of `ansible-check-review.sh` showing `full_name`, `playbook_path`, `inventory_path`, and the `checks` array

![alt text](<screenshots/week 09-assignment 6-task4-screenshot6.JPG>)

---

#### Screenshot 7 — Middle section showing `extract_changed_tasks` and `check_tasks_matching_pattern`

![alt text](<screenshots/week 09-assignment 6-task4-7.JPG>)

---

#### Screenshot 8 — Bottom section showing the loop, summary, and exit behavior

![alt text](<screenshots/week 09-assignment 6-task4-8.JPG>)

---

#### Screenshot 9 — Output of `bash -n ansible-check-review.sh` and `ls -l ansible-check-review.sh`

![alt text](<screenshots/week 09-assignment 6-task4-9.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is stored in the `changed_tasks` array?**

The specific task names and output blocks extracted from the dry-run logs that indicate modifications would occur during a real run.

---

**2. Which function finds changed tasks from the Ansible output?**

The extract_changed_tasks function, which parses the raw dry-run text stream for task header patterns and change indicators.

---

**3. Why does the script use `--check --diff`?**

To perform a safe, non-destructive simulation (--check) while printing precise line-by-line configuration differences (--diff) for audit visibility.

---

**4. Why does the script use different exit codes for healthy, warning, and failed results?**

To allow automated wrapper pipelines, shell scripts, and Claude skills to programmatically detect the risk posture and respond accordingly.

---

# Task 5 — Run the Baseline Dry-Run Review

## Goal

Run the script against your current EpicBook playbook and confirm the baseline risk status.

### Evidence

#### Screenshot 10 — Output of `./ansible-check-review.sh`

![alt text](<screenshots/week 09-assignment 6-task5-10.JPG>)

---

#### Screenshot 11 — Output of `echo "Captured Exit Code: $script_exit_code"` and `cat reports/ansible-risk-report.txt`

![alt text](<screenshots/week 09-assignment 6-task5-11.JPG>)

---

### Notes

Answer the following in your own words:

**1. What was the overall status of your baseline run?**

Healthy / Passing status indicating no unexpected high-risk configurations pending application.

---

**2. Did any tasks report `changed`?**

Only expected idempotent baseline checks or none, depending on the pre-existing state of the target server

---

**3. Were any changed tasks flagged as risky?**

No, baseline tasks aligned with expected clean operational parameters.

---

**4. What does the script exit code mean?**

An exit code of 0 denotes a clean, safe state, while non-zero codes indicate warnings or risky changes requiring operator attention.

---

# Task 6 — Create and Run the Claude Code Skill

## Goal

Turn the Bash script into a reusable Claude Code skill called `/ansible-risk-review`.

### Evidence

#### Screenshot 12 — `SKILL.md` showing the frontmatter, allowed tools, and safety rules

![alt text](<screenshots/week 09-assignment 6-task6-12.JPG>)

---

#### Screenshot 13 — Claude Code output after running `/ansible-risk-review`

![alt text](<screenshots/week 09-assignment 6-task6-13.JPG>)

---

### Notes

Answer the following in your own words:

**1. Why does this skill allow `Bash`, `Read`, and `Grep`?**

To enable Claude to execute the audit shell script, read generated report files, and search output logs without granting write permissions.

---

**2. Why does this skill not allow file editing?**

To maintain read-only safety guardrails, preventing the agent from modifying code or configuration files autonomously

---

**3. What part is handled by Bash?**

The deterministic execution of Ansible dry-runs, log capture, pattern matching, and file generation.

---

**4. What part is handled by Claude Code?**

The semantic interpretation of the risk reports, executive summary formatting, and presentation of findings to the user

---

**5. Why is this better than asking Claude Code if the playbook is safe without giving it evidence?**

Because it grounds the AI's analysis in real, deterministic command-line execution and log evidence rather than unverified parametric assumptions.

---

# Task 7 — Introduce a Controlled Risky Change and Let the Skill Catch It

## Goal

Add a small controlled risky change in your lab playbook and confirm the script and Claude Code catch it before applying.

### Evidence

#### Screenshot 14 — The added risky task inside the role file

![alt text](<screenshots/week 09-assignment 6-task7-14.JPG>)

---

#### Screenshot 15 — Output of `./ansible-check-review.sh`

![alt text](<screenshots/week 09-assignment 6-task7-15.JPG>)

---

#### Screenshot 16 — Claude Code `/ansible-risk-review` output showing the risky finding

![alt text](<screenshots/week 09-assignment 6-task7-16.JPG>)

---

#### Screenshot 17 — Output of `cat reports/risky-change-report.txt`

![alt text](<screenshots/week 09-assignment 6-task7-17.JPG>)

---

### Notes

Answer the following in your own words:

**1. Which risk category did the added task fall into?**

The high-risk category involving service restarts and configuration modifications.

---

**2. What evidence proves the task would change something?**

The dry-run diff output showing the targeted service state alteration and task execution flag.

---

**3. Did Claude Code apply the playbook?**

No, Claude Code strictly performed a read-only analysis and presented the warning.

---

**4. Why is it important that Claude Code only analyzed the risk?**

To ensure safety policies are enforced and human approval remains mandatory for all state-changing operations.

---

**5. Which phase of the Agentic Loop is represented by the Bash report?**

The Observation and Data Ingestion phase.

---

# Task 8 — Apply as the Human, Verify, and Write the Change Summary

## Goal

Review the risky-change report, apply the playbook manually as the human operator, and verify the result.

### Evidence

#### Screenshot 18 — Output of the real playbook run showing the final recap with `failed=0`

![alt text](<screenshots/week 09-assignment 6-task8-18.JPG>)

---

#### Screenshot 19 — Output of `ansible web -i inventory.ini -m ping`

![alt text](<screenshots/week 09-assignment 6-task8-19.JPG>)

---

#### Screenshot 20 — Second `/ansible-risk-review` output after applying the change

![alt text](<screenshots/week 09-assignment 6-task8-20.JPG>)

---

#### Screenshot 21 — Output of `ls -lah reports`

![alt text](<screenshots/week 09-assignment 6-task8-21.JPG>)

---

#### Screenshot 22 — `change-summary.md` showing all required sections and your Full Name

![alt text](<screenshots/week 09-assignment 6-task8-22.JPG>)

---

### Notes

Answer the following in your own words:

**1. What command did you run to apply the change for real?**

ansible-playbook -i inventory.ini site.yml
---

**2. Who made the final decision to apply the playbook?**

The human operator (Busola Helen Awotimide), following the review of the risk assessment report.

---

**3. What evidence proves the VM is still reachable?**

The successful ping execution (ansible web -i inventory.ini -m ping) returning pong

---

**4. Why should the risk review be run again after applying?**

To verify that the system state has successfully converged to expected parameters and that no residual drifts or warnings remain.

---

**5. What could go wrong if an AI agent applied Ansible changes automatically?**

An unvetted high-risk change or misinterpretation could disrupt production services, corrupt databases, or introduce security vulnerabilities without human oversight.

---

# LinkedIn Post Required

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:



---

#### Screenshot — Published LinkedIn post



---

# Required Files

Confirm that the following files are included in your GitHub repository or assignment folder:

- [ ] `CLAUDE.md`
- [ ] `ansible-check-review.sh`
- [ ] `.claude/skills/ansible-risk-review/SKILL.md`
- [ ] `reports/risky-change-report.txt`
- [ ] `reports/post-apply-report.txt`
- [ ] `change-summary.md`

---

# Submission Instructions

- Add all required screenshots in your submission.
- Full Name must be visible in required screenshots and reports.
- All required notes must be answered clearly.
- Do not expose SSH private keys, passwords, cloud credentials, database credentials, or secret environment variables.
- Add your GitHub repository or folder URL inside this document.

---

# Completion Checklist

- [ ] Task 1: EpicBook connectivity confirmed and workspace created
- [ ] Task 2: `CLAUDE.md` created with safety rules
- [ ] Task 3: Claude Code produced a read-only risk-review plan
- [ ] Task 4: `ansible-check-review.sh` created and syntax checked
- [ ] Task 5: Baseline dry-run review completed
- [ ] Task 6: Claude Code `/ansible-risk-review` skill created and tested
- [ ] Task 7: Controlled risky change introduced and detected
- [ ] Task 8: Human applied the change and verified the result
- [ ] Risky-change report saved
- [ ] Post-apply report saved
- [ ] Change summary completed
- [ ] All screenshots added
- [ ] All notes answered
- [ ] LinkedIn post published
- [ ] LinkedIn post URL added
- [ ] No sensitive information exposed

---

## About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra and The CloudAdvisory, focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## Resources

- DMI Official Website: [https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme](https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme)
- University: [https://university.pravinmishra.com?utm_source=github&utm_medium=readme](https://university.pravinmishra.com?utm_source=github&utm_medium=readme)
- Discord Community: [https://discord.pravinmishra.com?utm_source=github&utm_medium=readme](https://discord.pravinmishra.com?utm_source=github&utm_medium=readme)
- Blog: [https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme](https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme)
- YouTube Playlist: [https://www.youtube.com/playlist?list=PLFeSNDtI4Cho](https://www.youtube.com/playlist?list=PLFeSNDtI4Cho)
- Pravin Mishra LinkedIn: [https://www.linkedin.com/in/pravin-mishra-aws-trainer/](https://www.linkedin.com/in/pravin-mishra-aws-trainer/)
- CloudAdvisory LinkedIn: [https://www.linkedin.com/company/thecloudadvisory/](https://www.linkedin.com/company/thecloudadvisory/)

---

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*