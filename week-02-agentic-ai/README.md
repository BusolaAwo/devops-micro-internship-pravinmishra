# Week 02 — Agentic-ai

## Assignment Overview

i am to  set up your local development environment for Agentic AI using Claude Code ,install and authenticate Claude Code CLI, fork and clone the starter repository and observe how the Agentic Loop (Gather → Act → Verify) works in practice.




## Assignment1 Task 1: Task 1 — Install Claude Code

Install the Claude Code CLI globally and authenticate it using your Anthropic account.

Screenshot 1 — Terminal showing claude --version with the version number visible

![Assignment 1 Screenshot](screenshots/week02-assignment%2001-screenshot%201.JPG)

Screenshot 2 — Claude Code authenticated and showing the terminal prompt (my name visible)

![Assignment 1 Screenshot](screenshots/week02-assignment%2001-screenshot%202.JPG)

## Task 2 — Fork and Clone the Starter Repository

Fork the provided GitHub repository, clone it to your local machine, and open it in VS Code.


Screenshot 3 — VS Code with the project open, file tree visible showing index.html, style.css, images/

![Assignment 1 Screenshot](screenshots/week02-assignment%2001-screenshot%203.JPG)

## Task 3 — Observe the Agentic Loop

Interact with Claude Code and observe how it performs the Agentic Loop (Gather → Act → Verify) while answering project-related questions.

Evidence
Screenshot 4 — Claude's response to the first question, showing it read the files (tool calls visible)

![Assignment 1 Screenshot](screenshots/week02-assignment%2001-screenshot%204.JPG)

Screenshot 5 — Claude's response to the second question, showing it ran a command and reported the line count

![Assignment 1 Screenshot](screenshots/week02-assignment%2001-screenshot%205.JPG)

Repo URL:https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git


## Assignment 2 — Teaching Claude my Project
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI


Task 1 — Capture the Before State

Screenshot 1 — Claude’s generic response before CLAUDE.md exists (project contains only index.html, style.css, images/, README.MD, privacy.html, terms.html)

![Assignment 2 Screenshot](<screenshots/week 02-assignment 02-screenshot1.JPG>)

## Task 2 — Generate the First Draft with /init

Generate an initial CLAUDE.md file using the /init command and review the auto-generated content.


Screenshot 2 — The auto-generated CLAUDE.md open in VS Code showing its content

![Assignment 2 Screenshot 2](<screenshots/week02-assignment 02-screenshot2.JPG>)

## Task 3 — Customize the CLAUDE.md

Update the generated CLAUDE.md file by adding project-specific instructions across all required sections.

Screenshot 3 — Your customized CLAUDE.md in VS Code showing all 5 sections (scroll to show the full file)

![Assignment 2 Screenshot 3](<screenshots/week02-assignment 02-screenshot3.JPG>)

## Task 4 — Test the After State

Verify that Claude’s behavior changes after adding CLAUDE.md by running a new session and comparing responses before and after context is applied.

Screenshot 4 — Claude's specific, detailed answer after reading CLAUDE.md (Claude mentioning S3, CloudFront and Terraform)

![Assignment 2 Screenshot 4](<screenshots/week02-assignment 02-screenshot4.JPG>)

Screenshot 5 — Claude refusing or warning against adding React because of the "No JavaScript" convention defined in CLAUDE.md

![Assignment 2 Screenshot 5](<screenshots/week02-assignment 02-screenshot5.JPG>)

## Task 5 — Commit and push your changes to your fork in GitHub

Commit the CLAUDE.md file and push it to your GitHub fork so the project instructions are version-controlled.


Screenshot 6 — CLAUDE.md visible in your GitHub repository after pushing the commit

![Assignment 2 Screenshot 6](<screenshots/week 02-assignment 02-screenshot6.JPG>)


Repo URL: https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git



## Assignment 3 — Building Your Command Center
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

Purpose
In this assignment, I  builT a local Claude Skills system by creating the .claude/skills/ folder structure, adding predefined skill files, and executing a real agentic command (/scaffold-terraform) to generate infrastructure code. I also observe how skills enforce tool restrictions and enable controlled automation.

## Task 1 — Create the Skill Folder Structure

Create the required .claude/skills/ directory structure for all skills.

Screenshot 1 — VS Code sidebar showing .claude/skills/ folder with all 4 subfolders visible

![Assignment 3 Screenshot 1](<screenshots/week02- assignment 03-screenshot1.JPG>)

## Task 2 — Add the Skill Files

Place all required skill files into their correct directories and verify their configuration.


Screenshot 2 — .claude/skills/scaffold-terraform/ open in VS Code showing both SKILL.md and template-spec.md

![Assignment 3 Screenshot 2](<screenshots/week 02- assignment 03-screenshot2.JPG>)

Screenshot 3 — tf-plan/SKILL.md frontmatter showing allowed-tools: Bash, Read, Grep (no Write) and disable-model-invocation: true


![Assignment 3 Screenshot 3](<screenshots/week02-assignment 03-screenshot3.JPG>)

## Task 3 — Run /scaffold-terraform

Execute the /scaffold-terraform skill to generate a full Terraform infrastructure setup.

Screenshot 4 — Claude's response showing the scaffold complete with the file list

![Assignment 3 Screenshot 4](<screenshots/week02-assignment 03-screenshot4.JPG>)

![Assignment 3 Screenshot 4a](<screenshots/week02-assignment 03-screenshot4a.JPG>)

![Assignment 3 Screenshot 4b](<screenshots/week02-assignment 03-screenshot4b.JPG>)


Screenshot 5 — VS Code sidebar showing the terraform/ folder with all generated files inside

![Assignment 3 Screenshot 5](<screenshots/week 02-assignment 03-screenshot5.JPG>)

## Task 4 — Run terraform init and /tf-plan

Initialize Terraform and execute the /tf-plan skill to observe plan execution and output analysis.

Screenshot 6 — Claude's /tf-plan response showing it ran the command and analyzed the result (pass or auth error both count)

![Assignment 3 Screenshot 6a](<screenshots/week 02-assignment 03-screenshot6a.JPG>)

GitHub Repository URL
Paste your forked repository URL here:

https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git

LinkedIn post URL:https://www.linkedin.com/posts/busola-helen-awotimide_dmibypravinmishra-agenticai-claudecode-ugcPost-7480843782410776576-qGKr?



## Assignment 4 — Building Your AI Team
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI


In this assignment, I built and configure a set of specialized AI subagents inside your project. i learnt how different models and tool permissions define agent behavior and you will trigger two real agent delegations to analyze security and cost aspects of your Terraform infrastructure.

Task 1 — Create the Agents Folder and Add Files

Create the .claude/agents/ directory and add all required agent files.


Screenshot 1 — VS Code sidebar showing .claude/agents/ with all 3 files

![Assignment 4 Screenshot 1](<screenshots/week 02-assignment 04-screenshot1.JPG>)

## Task 2 — Compare the Agent Configurations

Analyze the configuration differences between the three agents and demonstrate understanding of model and tool selection.

## Question 1

### Why does the cost optimizer use Haiku instead of Sonnet?

**Answer**

cost optimizers uses Haiku because its lightning fast so it get my savings answers right away without waiting, its also very cheap to run so the robot doesnt waste money while trying to save money, aside that it perfect for checklists cos it doesnt need a giant expensive brain to match items and fine errors

## Question 2

### Why does the security auditor NOT have Write in its tools list?

**Answer:**

The robot could accidentally break my website if it tried to change delicate security code on its own since its only job is to only look and report so taking away its pen to write keeps the code safe ensuring the robot can never rewrite or damage my files

## Question 3

### Why does the tf-writer use inherit instead of a specific model?

**Answer:**

It matches my project's size, changing from a small brain to a giant brain depending on what i need it also prevents misunderstandings ensuring the robot completely understands my instaructions aside that it automatically upgrades instantly to get smarter whenever a new brain is invented


Screenshot 2 — security-auditor.md frontmatter showing model and tools configuration

![Assignment 4 Screenshot 2](<screenshots/week 02-assignment 04-screenshot2.JPG>)


Screenshot 3 — cost-optimizer.md frontmatter showing the model and tools configuration

![Assignment 4 Screenshot 3](<screenshots/week 02-assignment 04-screenshot3.JPG>)


## Task 3 — Run the Security Auditor

Trigger the security auditor agent and analyze the generated security report for your Terraform infrastructure.

Screenshot 4 — The delegation message showing Claude launched the security-auditor

![Assignment 4 Screenshot 4](<screenshots/week 02-assignment 04-screenshot4.JPG>)


Screenshot 5 — Security audit report output

![Assignment 4 Screenshot 5](<screenshots/week 02-assignment 04-screenshot5.JPG>)

![Assignment 4 Screenshot 5b](<screenshots/week 02-assignment 04-screenshot5b.JPG>)

## Task 4 — Run the Cost Optimizer

Trigger the cost optimizer agent and review the generated cost optimization report.


Screenshot 6 — The full cost optimization report

![Assignment 4 Screenshot 6](<screenshots/week 02-assignment 04-screenshot6.JPG>)

![Assignment 4 Screenshot 6a](<screenshots/week 02-assignment 04-screenshot6a.JPG>)

REPO URL : https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git



## Assignment 5 — Connecting Claude to the Outside World
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI


In this assignment, you will connect Claude Code to external systems using MCP (Model Context Protocol). You will configure the GitHub MCP server, securely store credentials, verify the connection, and run a live query that proves Claude is accessing real-time GitHub data.

## Task 1 — Create a GitHub Personal Access Token

Generate a GitHub Personal Access Token (PAT) that will be used for MCP authentication.


Screenshot 1 — GitHub token creation page showing the selected scopes (repo, read:user) — token value must NOT be visible

![Assignment 5 Screenshot 1](<screenshots/week 02-assignment 05-screenshot1.JPG>)

## Task 2 — Create .mcp.json at the Project Root

Create and configure the .mcp.json file to define the GitHub MCP server.


Screenshot 2 — .mcp.json open in VS Code showing the full configuration

![Assignment 5 Screenshot 2](<screenshots/week 02-assignment 05-screenshot2.JPG>)

## Task 3 — Add Your Token to settings.local.json

Store your GitHub token securely in .claude/settings.local.json and ensure it is not committed to version control.

Screenshot 3 — settings.local.json open in VS Code showing the env section — blur or cover the actual GitHub token value

![Assignment 5 Screenshot 3](<screenshots/week 02-assignment 05-screenshot3.JPG>)


## Task 4 — Verify the Connection with /mcp

Confirm that the GitHub MCP server is successfully connected inside Claude Code.


Screenshot 4 — /mcp output showing github: connected

![Assignment 5 Screenshot 4](<screenshots/week02-assignment 05-screenshot4.JPG>)


## Task 5 — Run a Live GitHub Query

Verify MCP functionality by retrieving real-time data from your GitHub account using Claude Code.


Screenshot 5 — Claude's response showing the GitHub MCP tool call and the retrieved README.md content.

![Assignment 5 Screenshot 5](<screenshots/week 02-assignment 05-screenshot5.JPG>)

GitHub Repository URL
Paste your forked repository URL here: https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git



## Assignment 6 — Safety Rails for Your AI Agent
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

In this assignment, you will configure safety and control mechanisms for Claude Code using permissions and hooks. You will define team-level command restrictions and implement prompt-level and tool-level hooks to prevent destructive actions before they execute.

## Task 1 — Create Claude Code Configuration Structure

Create the .claude directory structure required for team-level Claude Code configuration.

Screenshot 1 — .claude folder structure visible in VS Code Explorer

![Assignment 6 Screenshot 1](<screenshots/week 02-assignment 06-screenshot1.JPG>)


## Task 2 — Create the UserPromptSubmit Hook Script

Create a hook that checks user prompts before Claude processes them and blocks requests containing destructive intent.


Screenshot 2 — user-prompt-guard.sh open in VS Code showing the hook script

![Assignment 6 Screenshot 2](<screenshots/week 02-assignment 06-screenshot2.JPG>)


## Task 3 — Create the PreToolUse Hook Script

Create a hook that runs before Claude executes Bash commands and blocks dangerous infrastructure commands.


Screenshot 3 — pre-tool-guard.sh open in VS Code showing the hook script

![Assignment 6 Screenshot 3](<screenshots/week 02-assignment 06-screenshot3.JPG>)


## Task 4 — Create the PostToolUse Hook Script

Create a hook that runs after Claude executes a Bash command and logs selected Terraform commands.


Screenshot 4 — post-tool-logger.sh open in VS Code showing the hook script

![Assignment 6 Screenshot 4](<screenshots/week 02-assignment 06-screenshot4.JPG>)

## Task 5 — Configure settings.json to Connect Hook Scripts

Configure Claude Code permissions and connect the hook scripts created in the previous tasks.

Screenshot 5 — settings.json open in VS Code showing permissions and hooks configuration


![Assignment 6 Screenshot 5](<screenshots/week 02-assignment 06-screenshot5.JPG>)

## Task 6 — Test the UserPromptSubmit Hook

Prove the prompt-level hook works by typing a destructive prompt and verifying it is blocked before Claude processes the request.


Screenshot 6 — UserPromptSubmit hook blocking the destructive prompt

![Assignment 6 Screenshot 6](<screenshots/week 02-assignment 06-screenshot6.JPG>)


## Task 7 — Test the PreToolUse Hook

Prove the tool-level hook works by asking Claude to execute a dangerous Bash command.

Screenshot 7 — PreToolUse hook blocking terraform destroy

![Assignment 6 Screenshot 7](<screenshots/week 02-assignment 06-screenshot7.JPG>)

## Task 8 — Test the PostToolUse Logging Hook

Prove the logging hook runs after a successful command execution and records Terraform operations.


Screenshot 8 — Claude running terraform validate successfully

![Assignment 6 Screenshot 8](<screenshots/week 02-assignment 06-screenshot8.JPG>)

Screenshot 9 — .claude/deploy.log showing the logged command

![Assignment 6 Screenshot 9](<screenshots/week 02-assignment 06-screenshot9.JPG>)


## Assignment 7 — A Claude That Remembers
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI


In this assignment, I explored Claude Code’s memory system. i located the project memory file, store structured information into it, restart your session and verify that Claude can recall stored knowledge across sessions without being prompted again.

## Task 1 — Find the Memory File Location

Discover exactly where Claude Code stores memory for this project.

Screenshot 1 — Memory file path shown by Claude

![Assignment 7 Screenshot 1](<screenshots/week 02-assignment 07-screenshot1.JPG>)

## Task 2 — Give Claude Information to Remember

Teach Claude three specific facts about the project and instruct it to save them to the memory file.

Screenshot 2 — Claude confirming the memory was saved

![Assignment 7 Screenshot 2](<screenshots/week 02-assignment 07-screenshot2.JPG>)

Screenshot 3 — The MEMORY.md file open in VS Code showing the saved content

![Assignment 7 Screenshot 3](<screenshots/week 02-assignment 07-screenshot3.JPG>)

## Task 3 — Close the Session Completely

Terminate the current Claude Code session and restart it to ensure memory is the only persistent context source.

Screenshot 4 — VS Code reopened with a fresh Claude Code session showing no previous conversation

![Assignment 7 Screenshot 4](<screenshots/week 02-assignment 07-screenshot4.JPG>)

## Task 4 — Prove Memory Recall Across Sessions

Run three tests that prove Claude remembers what you told it — without you saying it again in the new session.


Screenshot 5 — Claude recalling hero section colors

![Assignment 7 Screenshot 5](<screenshots/week 02-assignment 07-screenshot5.JPG>)

![Assignment 7 Screenshot 5a](<screenshots/week 02-assignment 07-screenshot5a.JPG>)

Screenshot 6 — Claude refusing JavaScript request based on memory rule

![Assignment 7 Screenshot 6](<screenshots/week 02-assignment 07-screenshot6.JPG>)

Linkedin Post Link
Paste your Linkedin post link here:https://www.linkedin.com/posts/busola-helen-awotimide_dmibypravinmishra-agenticai-claudecode-activity-7481124868600725504-3NcH?


GitHub Repository URL
Paste your forked repository URL here:

https://github.com/BusolaAwo/devops-micro-internship-pravinmishra.git


## Assignment 8 — Week 2 Reflection Blog
Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI


In this assignment, i reflected on my Week 2 learning journey and wrote a short blog capturing my experience working with Agentic AI tools such as Claude Code, Skills, Subagents, MCP, Hooks, Permissions, and Memory.

i also publish a LinkedIn post summarizing my learning and share both links for evaluation.

## Task 1 — Write Your Reflection Blog

Write a reflection blog covering your Week 2 learning experience.

Screenshot 1 — Blog published and visible

![Assignment 8 Screenshot 2](<screenshots/week 02- assignment 08-screenshot2.JPG>)

Blog Link:https://medium.com/@awsawotimide/the-week-i-stopped-collecting-ai-tools-and-started-building-system-f64c0419deae?sharedUserId=awsawotimide


## Task 2 — Create LinkedIn Post

Screenshot 2 — LinkedIn post published

![Assignment 8 LinkedIn Post](<screenshots/week 02- assignment 08 linkedin post.JPG>)


LINKEDIN POST LINK :https://www.linkedin.com/posts/busola-helen-awotimide_dmibypravinmishra-agenticai-claudecode-activity-7481127020140306432-XunJ?






