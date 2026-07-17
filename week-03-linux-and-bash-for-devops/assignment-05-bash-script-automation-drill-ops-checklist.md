# Assignment 5 — Bash Script Automation Drill (OPS Checklist)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will practice Bash scripting by building a series of small automation scripts covering environment setup, variables, arrays, loops, file conditionals, if-else logic, and functions. These scripts form the foundation of real-world Linux automation used in DevOps, cloud, and production support environments.

---

# Task 1 — Bash Environment & Workspace Setup

## Goal

Verify that Bash is available on your system and create a clean workspace for this assignment.

### Evidence

#### Screenshot 1 — Output of `echo $SHELL` and `bash --version`

![alt text](<screenshots/assignment 05-task1-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `pwd` and `ls -lah` showing the scripts directory


![alt text](<screenshots/assignment 05-task1-screenshot 2.JPG>)
---

### Notes

Answer the following in your own words:

**1. What is Bash?**

 For my deployment work, Bash (Bourne Again Shell) serves as my primary command-line interpreter and scripting language on Linux. It gives me a direct interface to interact with the operating system kernel, execute automation commands, and manage system files. Writing scripts in Bash allows me to combine repetitive terminal commands into automated executable workflows, which makes managing cloud servers and deployments incredibly efficient.

---

**2. What is the difference between shell and Bash?**


  I look at a shell as a general category or interface standard, whereas Bash is a specific tool that implements it. The shell is any macro processor that provides a command-line interface to execute system utilities. Bash is just one popular, advanced type of shell that includes extra features like command history and tab completion, which I rely on constantly over older, basic shells like Sh.
---

**3. Why is it important to confirm the Bash version before writing scripts?**

 Checking my Bash version is a crucial first step because newer scripting features, arrays, and syntax options aren't backward compatible with legacy versions found on older enterprise servers. If I write an advanced automation script using features from Bash 4 or 5 and try to run it on a server with Bash 3, the script will throw syntax errors and break. Confirming the version beforehand guarantees my scripts execute reliably everywhere.

---

# Task 2 — Your First Bash Script

## Goal

Create your first Bash script, make it executable, and run it from the terminal.

### Evidence

#### Screenshot 1 — Content of `first-script.sh`

![alt text](<screenshots/assignment 05-task2-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `./first-script.sh`

![alt text](<screenshots/assignment 05-task2-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `ls -l first-script.sh` showing executable permission

![alt text](<screenshots/assignment 05-task2-screenshot 3 copy.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of `#!/bin/bash`?**

 When I write scripts like forth-script.sh, placing #!/bin/bash at the very first line is my way of telling the operating system exactly which interpreter to use. This line known as a shebang tells the kernel to bypass any default shell I might be using and run the script specifically with the Bash interpreter found at that absolute path. This ensures my variables, loops, and syntax execute exactly as I intended.

---

**2. Why do we use `chmod +x` before running a script?**

 By default, when I create a new script file in Linux, the OS blocks execution permissions as a built-in security measure to prevent accidental scripts from running. When I run chmod +x, I am modifying the file's permission metadata to explicitly grant executable rights. This allows me to run the script directly as a program, which is essential for testing my automation scripts on my cloud instances.


---

**3. What is the difference between running a script using `./script.sh` and `bash script.sh`?**

 When I use ./script.sh, I am telling the system to execute the file directly as a standalone program, relying entirely on the shebang line inside the script to find the interpreter. When I run bash script.sh, I am directly invoking the Bash shell myself and passing the script as an argument, which works even if I haven't granted execution permissions on the file yet.

---

# Task 3 — Variables: User Information Script

## Goal

Use variables to store and display user-related information.

### Evidence

#### Screenshot 1 — Content of `user-info.sh`

![alt text](<screenshots/assignment 05-task3-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `./user-info.sh`

![alt text](<screenshots/assignment 05-task3-screenshot 2.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is a variable in Bash?**

 When I build automation scripts, I use a variable as a temporary storage container or placeholder in the system memory to hold data like user information, file paths, or text strings. Instead of hardcoding values multiple times throughout my scripts, defining a variable allows me to dynamically store, update, and reuse that data anywhere in my code, making my scripts far cleaner and easier to maintain.

---

**2. Why should we avoid spaces around the `=` sign when creating variables?**

 I have to be extremely careful with my spacing because Bash interprets the very first word of a line as a command to execute. If I put spaces around the equals sign, Bash will treat my variable name as an individual command and the equals sign or value as an argument, throwing an immediate command not found error. Omitting spaces ensures the shell correctly reads it as a single assignment operation.

---

**3. How do you access the value stored inside a Bash variable?**

 To extract and use the data I have stored inside a variable, I prepend the variable name with a dollar sign $ when calling it, such as writing $NAME. When the Bash interpreter evaluates that line in my script, it performs variable expansion, substituting the variable placeholder with the actual text string or numeric value I assigned to it earlier in the script execution.

---

# Task 4 — Arrays & Loops: Tools Checklist Script

## Goal

Use arrays and loops to print a checklist of tools used in Bash scripting.

### Evidence

#### Screenshot 1 — Content of `tools-checklist.sh`

![alt text](<screenshots/assignment 05-task4-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `./tools-checklist.sh`


![alt text](<screenshots/assignment 05-task4-screenshot 2.JPG>)
---

### Notes

Answer the following in your own words:

**1. What is an array in Bash?**

 When I write scripts, I use an array as a special variable that allows me to store multiple related values under a single name instead of creating dozens of separate variables. It acts like a grouped list in the system memory, holding several data elements like lists of software packages, server ports, or configuration files that I can easily reference, track, and manipulate as a collective unit

---

**2. Why are arrays useful in scripts?**

 Arrays are incredibly useful in my scripts because they help me keep my code clean, organized, and scalable. Instead of writing repetitive code block after code block to process individual items one by one, I can store them in a single array and use loops to run operations across the entire group. This makes automating tasks like package installations or server configuration audits incredibly fast

---

**3. What does `"${tools[@]}"` mean?**

In my script, writing "${tools[@]}" is how I tell Bash to expand and retrieve every single element stored inside my tools array. The @ symbol acts as a wildcard to target all items, while wrapping the expression in double quotes ensures that any tools with spaces in their names are treated as single, individual items instead of being broken apart by the shell.


---

**4. What is the purpose of the `for` loop in this script?**

The purpose of the for loop in my script is to automate the process of cycling through my list of tools one by one. Instead of writing separate echo commands for every single tool, the loop takes my array, assigns each tool to a temporary variable on each pass, and prints out my checklist. This allows me to scale my list of tools seamlessly.

---

# Task 5 — Loops: Number Counter Script

## Goal

Use loops to repeat a task multiple times.

### Evidence

#### Screenshot 1 — Content of `counter.sh`

![alt text](<screenshots/assignment 05-task5-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `./counter.sh`


![alt text](<screenshots/assignment 05-task5-screenshot 2.JPG>)
---

### Notes

Answer the following in your own words:

**1. What is a loop?**

In my scripting, I define a loop as a control flow structure that lets me execute a specific block of commands repeatedly until a certain condition is met. Instead of writing the exact same lines of code over and over again, the loop automates the repetition by cycling through a set list, array, or numeric range, saving me massive amounts of manual typing.

---

**2. Why do we use loops in Bash scripting?**

I use loops in my Bash scripts to automate repetitive administrative and deployment tasks, such as iterating through a list of server IPs, installing a batch of packages, or auditing system ports. It makes my code highly efficient and scalable, allowing me to process hundreds of files or configurations with just a few lines of logic instead of writing unique commands for every single item.

---

**3. How many times did the loop run in your script?**

Based on the tools checklist array I set up in my script, the loop executed exactly five times to print out each of my listed utilities. Because I used the dynamic array expansion syntax to feed the loop, it automatically counted the number of elements I defined inside my array and ran precisely once for each tool in that group without any manual counting on my part.

---

**4. What would you change if you wanted the loop to run 10 times?**

If I wanted the loop to run exactly ten times, I would modify my script to use a standard sequence expression like for i in {1..10}. Alternatively, if the loop is reading from an array, I would simply expand my array definition to include ten distinct items, which allows my existing array based loop logic to dynamically scale up its iterations to match the new size.

---

# Task 6 — Files & Conditionals: File Validation Script

## Goal

Use file checks and conditionals to verify whether files and directories exist.

### Evidence

#### Screenshot 1 — Output of `ls -lah ../test-folder`

![alt text](<screenshots/assignment 05-task6-screenshot 1.JPG>)

---

#### Screenshot 2 — Content of `file-check.sh`

![alt text](<screenshots/assignment 05-task5-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `./file-check.sh`

![alt text](<screenshots/assignment 05-task6-screenshot 3.JPG>)

---

### Notes

Answer the following in your own words:

**1. What does `-d` check in Bash?**

I use the -d flag inside an if statement to verify whether a specific path exists and is actually a directory. When I run this check, Bash looks at the target path on the filesystem; if the folder is present, the condition evaluates to true, allowing my script to safely create, modify, or move files inside it.

---

**2. What does `-f` check in Bash?**

I use the -f flag in my conditional checks to confirm whether a path points to a regular file, as opposed to a directory or a special system file. This is incredibly useful in my deployment scripts because it allows me to verify that essential files, like my configuration scripts or built index files, are actually present before I try to read or execute them.

---

**3. Why should file and directory paths be stored in variables?**

Storing my file and directory paths in variables is a practice I rely on to keep my scripts clean, organized, and adaptable. Instead of hardcoding a path like /var/www/html multiple times, I can define it once at the top of my script. If the directory layout changes, I only have to update a single line of code to apply the change everywhere.

---

**4. What happens if the file does not exist?**
If a file my script expects to find does not exist, any commands trying to read, edit, or execute it will fail and throw an error in my terminal. To prevent my automation from crashing unexpectedly, I use if [ ! -f "$FILE" ] checks to catch the missing file early, print a clear warning, and exit the script gracefully.


---

# Task 7 — Conditionals: Pass or Retry Script

## Goal

Use if-else conditionals to make decisions based on a variable value.

### Evidence

#### Screenshot 1 — Content of `score-check.sh` with `score=85`

![alt text](<screenshots/assignment 05-task7-screenshot 1.JPG>)

---

#### Screenshot 2 — Output showing `Result: Pass`

![alt text](<screenshots/assignment 05-task7-screenshot 2.JPG>)

---

#### Screenshot 3 — Content of `score-check.sh` with `score=55`

![alt text](<screenshots/assignment 05-task7-screenshot 3.JPG>)

---

#### Screenshot 4 — Output showing `Result: Retry`

![alt text](<screenshots/assignment 05-task7-screenshot 4.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of if-else in Bash?**

I use if-else statements in my scripts to give my automation decision-making power based on real-time conditions. Instead of blindly running commands in a straight line, it lets my script evaluate a test like checking if a server port is open—and choose one execution path if the test passes, or run an alternative block of code if it fails.

---

**2. What does `-ge` mean?**

In my Bash conditional statements, -ge is the comparison operator I use to check if an integer is "greater than or equal to" another number. Because standard mathematical symbols like >= can confuse the shell's redirection syntax, using this flag allows me to safely compare numeric variables, like verifying if a server has enough available RAM or disk space before proceeding.

---

**3. Why should conditions be tested with different values?**

Testing my conditions with different values is crucial to make sure my script handles every possible scenario without breaking. By feeding it numbers that fall above, below and exactly on my target threshold, I can verify that both the if and the else blocks execute perfectly, which prevents logical bugs from causing silent failures in my production deployments.

---

**4. How can conditionals help in automation scripts?**


Conditionals are the absolute backbone of my automation scripts because they make my workflows robust and self-healing. By using them to check for things like network connectivity, active services, or file existence before executing commands, I can prevent my script from running into fatal errors, letting it automatically recover or log clear, helpful warnings when things aren't set up right.
---

# Task 8 — Functions: Final Bash Automation Script

## Goal

Create a final Bash script using functions to organize reusable code.

### Evidence

#### Screenshot 1 — Content of `final-automation.sh`

![alt text](<screenshots/assignment 05-task8-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `./final-automation.sh`


![alt text](<screenshots/assignment 05-task8-screenshot 2.JPG>)
---

#### Screenshot 3 — Output of `ls -lah` showing all created scripts


![alt text](<screenshots/assignment 05-task8-screenshot 3.JPG>)
---

### Notes

Answer the following in your own words:

**1. What is a function in Bash?**

I define a function in my scripts as a self-contained block of reusable code designed to perform a single, specific action. Instead of rewriting the same block of logic multiple times, I can group my commands under a descriptive name and call that function whenever I need it, which makes my code modular and clean.

---

**2. Why are functions useful in scripts?**

Functions are incredibly useful because they keep me from repeating myself and make my code much easier to read and maintain. If I need to update a specific action, like my error logging format, I only have to edit the code inside that single function rather than searching through my entire script to change it in multiple places.

---

**3. Which functions did you create in this script?**

In this script, I created modular functions dedicated to organizing my automation tasks: a directory setup function to verify and prepare our workspace paths, a check utilities function that iterates through our array of required binaries, and a final system report function that outputs our run status. These distinct functions keep my execution steps clean and organized

---

**4. How does this final script combine variables, arrays, loops, conditionals, files, and functions?**

This final script brings everything together by using functions as the main blocks of my logic, where variables store our directory paths and an array holds our list of tools. A for loop cycles through that array, using if-else conditionals with -d and -f to check the actual files on the system, making the entire deployment script completely dynamic.

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://www.linkedin.com/posts/busola-helen-awotimide_bash-no-dey-make-noise-but-e-dey-deliver-ugcPost-7483381169162690560-F5ET?utm_source=share&utm_medium=member_desktop&rcm=ACoAADtjPKMBDnsQhcIAGnVO4so-PBvk2dEBay4
---

#### Screenshot — Published LinkedIn post

![alt text](<screenshots/linkedin assignment 05.JPG>)

---

# Submission Instructions

- Add all required screenshots in your submission
- Full name must be visible in required screenshots
- All script files must be created and run successfully
- Required notes must be answered clearly for every task
- Do not expose sensitive information (keys, passwords, credentials)

---

# Completion Checklist

- [ ] Task 1: Environment setup verified, workspace created (Screenshots 1–2, Notes answered)
- [ ] Task 2: First script created, executed, permissions verified (Screenshots 1–3, Notes answered)
- [ ] Task 3: Variables script created and run (Screenshots 1–2, Notes answered)
- [ ] Task 4: Arrays and loops script created and run (Screenshots 1–2, Notes answered)
- [ ] Task 5: Counter loop script created and run (Screenshots 1–2, Notes answered)
- [ ] Task 6: File validation script created and run (Screenshots 1–3, Notes answered)
- [ ] Task 7: Pass/Retry conditional script tested with both values (Screenshots 1–4, Notes answered)
- [ ] Task 8: Final automation script created and run (Screenshots 1–3, Notes answered)
- [ ] All scripts run without errors
- [ ] Full Name visible in all required screenshots
- [ ] LinkedIn post published and URL submitted
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