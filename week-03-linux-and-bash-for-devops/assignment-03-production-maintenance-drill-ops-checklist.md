# Assignment 3 — Production Maintenance Drill (OPS Checklist)

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will treat your already deployed React application (on Ubuntu VM with Nginx) as a live production system. You will perform structured operational checks covering network validation, service health, log analysis, resource monitoring, configuration verification, and incident simulation with recovery — mirroring real on-call DevOps responsibilities.

---

# Task 1 — Server Access & Networking Validation

## Goal

Verify that the deployed React application is reachable from the browser and confirm basic network connectivity of the Ubuntu VM.

### Evidence

#### Screenshot 1 — Browser showing the React app with your Full Name visible on the UI

![alt text](<screenshots/assignment 03-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `ip a`

![alt text](<screenshots/assignment 03-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `sudo ss -tulpen`

![alt text](<screenshots/assignment 03-screenshot 3.JPG>)

---

#### Screenshot 4 — Output of `sudo ufw status`

![alt text](<screenshots/assignment 03-screenshot 4.JPG>)

---

### Notes

Answer the following in your own words:

**1. What proves Nginx is listening on 0.0.0.0:80?**

 When I ran the socket statistics command sudo ss -lptn in my terminal, I saw a specific entry pointing to 0.0.0.0:80 with nginx explicitly listed as the process name. This output tells me that my Nginx web server is successfully running and bound to port 80 across all available network interfaces on my machine. Seeing this active binding in the terminal is my proof that Nginx is ready and waiting to receive incoming HTTP requests from the public internet.

---

**2. What proves SSH is active on port 22?**

 To verify my secure connection, I checked the active listeners using sudo ss -lptn and located the entry showing sshd bound to *:22. Additionally, running systemctl status ssh showed me a bright green active (running) status indicator in the terminal output. These two pieces of evidence prove to me that the SSH daemon is healthy, running in the background, and actively listening on port 22 to secure my remote terminal sessions.
---

**3. Did you find any unexpected open ports? Explain briefly.**

 When I analyzed my open port list, I was glad to see that absolutely no unexpected ports were open on my system. The only active network bindings showing up were port 22 for my SSH connection and port 80 for Nginx. This is exactly what I wanted to see because it means my firewall rules are working perfectly, leaving no unmonitored services running in the background that could compromise my server's security.

# Task 2 — Service Health & Systemd Validation (Nginx)

## Goal

Verify that Nginx is properly installed, running, enabled at boot, and safely configured.

### Evidence

#### Screenshot 1 — Output of `systemctl status nginx --no-pager`

![alt text](<screenshots/assignment 03-task02-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `sudo nginx -t`

![alt text](<screenshots/assignment 03-task02-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `sudo ss -lptn '( sport = :80 )'`

![alt text](<screenshots/assignment 03-task02-screenshot 3.JPG>)

---

### Notes

Answer the following in your own words:

**1. What happens if Nginx fails to restart in production?**

 If Nginx fails to restart when I attempt to reload it, my web server will immediately go offline, causing instant downtime for my application. Users trying to visit my site or reach my API will see connection timeout errors instead of my actual content. This halts traffic flow completely, breaks the user experience, and could lead to lost revenue and user trust until I manually log in and resolve the issue
---

**2. What's your basic rollback plan?**


 My rollback plan is simple and fast

 Safety Backup: I always copy the working configuration (cp default default.bak) before making edits.

 First Line of Defense: Run sudo nginx -t immediately to catch syntax errors and undo the breaking change.

 Hard Rollback: If the config is too messed up, I immediately swap the broken file with my backup copy (mv default.bak default) and restart the service to restore uptime.
---

# Task 3 — Logs & Request Trace

## Goal

Verify real traffic flow and analyze logs to understand system behavior and errors.

### Evidence

#### Screenshot 1 — Output of `sudo tail -n 30 /var/log/nginx/access.log`

![alt text](<screenshots/assignment 03-task03-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `sudo tail -n 30 /var/log/nginx/error.log`

![alt text](<screenshots/assignment 03-task03-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `sudo journalctl -u nginx --no-pager -n 50`

![alt text](<screenshots/assignment 03-task03-screenshot 3.JPG>)

---

### Notes

Answer the following in your own words:

**1. Were there any errors in the logs?**

- If yes, mention 1–2 example error lines from the logs and explain what each one means in simple terms.
- If no, explain what it means if the error log is empty or shows no recent errors during your check.

 When I examined my log files using sudo tail -n 30 /var/log/nginx/error.log, I was relieved to find that my error log was completely clean and showed no error entries. This quiet log indicates that my Nginx web server is running smoothly without any underlying configuration mistakes, broken backend paths, or file access permission issues while handling my incoming requests.
---

**2. If there were no errors, what does that indicate about the system?**

 Finding zero errors in my logs indicates that my system is highly stable and healthy. It proves to me that Nginx has the correct permission settings to read my static React build files in /var/www/html and that my configuration file syntax is completely solid. It also tells me that the server is not experiencing resource exhaustion or broken network pathways.
---

**3. Based on the access logs, were your curl requests visible in the log entries? What does that prove about traffic flow?**

 Yes, my exact curl requests were fully visible when I ran sudo tail -n 30 /var/log/nginx/access.log, displaying my client IP and a successful 200 OK response. This clearly proves that my end-to-end traffic flow is working perfectly. It confirms that my network requests are successfully passing through the firewall, reaching Nginx, and receiving the correct files back without getting dropped along the way.
---

# Task 4 — System Resource Health Check (Capacity Red Flags)

## Goal

Assess server capacity and detect potential performance or failure risks.

### Evidence

#### Screenshot 1 — Output of `uptime`

![alt text](<screenshots/assignment 03-task04-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `free -h`

![alt text](<screenshots/assignment 03-task04-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `df -h`

![alt text](<screenshots/assignment 03-task04-screenshot 3.JPG>)

---

#### Screenshot 4 — Output of `sudo du -sh /var/* | sort -h`

![alt text](<screenshots/assignment 03-task04-screenshot 4.JPG>)

---

### Notes

Answer the following in your own words:

**1. Which resource looks most critical right now? (CPU/load, memory, or disk) Explain why.**

 Definitely memory (RAM). Looking at the resource outputs, the CPU load is practically idling and we have plenty of disk space left, but RAM is a finite bottleneck on small cloud instances. Once you run a few services, the free memory shrinks fast, making it the one resource we have to keep the closest eye on to keep things running smoothly.

---

**2. What happens if disk becomes 100% full in a production server?**

 If the disk fills up completely, everything grinds to a halt. The operating system can't create temporary files, Nginx can't write to its logs (which often causes it to fail) and databases crash because they can't save any new data. Basically, the server goes into a broken state where nothing new can be processed or saved.

---

# Task 5 — Configuration & Deployment Verification

## Goal

Ensure the correct React build is deployed and Nginx is serving it properly.

### Evidence

#### Screenshot 1 — Output of `ls -lah /var/www/html | head -n 20`

![alt text](<screenshots/assignment 03-task05-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `grep -R "Deployed by" -n /var/www/html 2>/dev/null | head`

![alt text](<screenshots/assignment 03-task05-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `grep -n "try_files" /etc/nginx/sites-available/default`

![alt text](<screenshots/assignment 03-task05-screenshot 3.JPG>)

---

### Notes

Answer the following in your own words:

**1. How do you confirm that the correct version of the application is deployed?**

 I check it by looking directly at the source files on the server and testing the live endpoint. First, I use ls -lah inside the Nginx web root folder to make sure the file modified dates match my most recent build update. Then, I use a quick grep command to search the HTML/JS files for our custom deployment markers (like a specific "Deployed by" comment) to prove the new code is actually live.

---

# Task 6 — Nginx Configuration Failure Simulation

## Goal

Simulate a real-world Nginx misconfiguration and recover the service safely.

### Evidence

#### Screenshot 1 — Output of `sudo nginx -t` showing the syntax error (broken config)

![alt text](<screenshots/assignment 03-task06-screenshot 1.JPG>)

---

#### Screenshot 2 — Output of `sudo nginx -t` showing syntax ok (fixed config)

![alt text](<screenshots/assignment 03-task06-screenshot 2.JPG>)

---

#### Screenshot 3 — Output of `curl -I http://<public-ip>` confirming recovery (200 OK)


![alt text](<screenshots/assignment 03-task06-screenshot 3.JPG>)
---

### Notes

Answer the following in your own words:

**1. What caused the configuration failure?**

 To simulate a real-world failure, I deliberately introduced a syntax error into my Nginx server block configuration file located at /etc/nginx/sites-available/default. I did this by removing a crucial semicolon at the end of a directive and leaving an unclosed curly brace. This broken syntax made it impossible for Nginx to parse its configuration files, causing the service check to fail when I tested it

---

**2. How did you fix the issue?**

 I fixed the issue by running sudo nginx -t in my terminal, which instantly pointed out the exact line number and file where the syntax was broken. I then opened the configuration file with Nano, fixed the missing semicolon, and saved the file. After running the test command again to confirm the syntax was okay, I reloaded Nginx using sudo systemctl reload nginx to safely restore my web service.

---

**3. How can you avoid this kind of issue in real production systems?**

The easiest way to avoid this is to build a habit of always testing your configurations before restarting the service. In a real job, you also wouldn't want to edit files directly on the server. You'd write your configs locally, save them in Git so you have a history of changes, and let an automated pipeline test and deploy them for you.

---

# Task 7 — Web Application Failure Simulation

## Goal

Simulate missing deployment content and recover the application safely.

### Evidence

#### Screenshot 1 — Output of `curl -I http://<public-ip>` showing failure (non-200 response)


![alt text](<screenshots/assignment 03-task07-screenshot 1.JPG>)
---

#### Screenshot 2 — Output of `curl -I http://<public-ip>` confirming recovery (200 OK)

![alt text](<screenshots/assignment 03-task07-screenshot 2.JPG>)

---

### Notes

Answer the following in your own words:

**1. What caused the application to break in this scenario?**

 The application broke because the compiled static React build files in my /var/www/html directory were renamed or completely deleted during my simulation. Since Nginx could no longer find the default index.html file to serve when incoming web requests hit port 80, it immediately threw a 404 Not Found error, causing my web application's frontend page to appear completely broken to visitors.
---

**2. How did you fix the issue and restore the application?**

 I restored the web application by copying my backup build files back into the /var/www/html directory. Once the files were in place, I adjusted the folder ownership to www-data so Nginx had the correct read permissions to serve the files. Finally, I ran a curl -I request to confirm that the server was successfully returning a healthy 200 OK status, bringing my React website fully back to life.
---

**3. What steps would you take to prevent this kind of issue in real production systems?**

 First, I'd make sure we aren't manually dragging files onto a production server; everything should go through an automated deployment script. Second, I'd set up automated backups of our web directories so we can restore files in a single click if something gets accidentally wiped out. Finally, having an automated system alert us the second the site goes down is key to catching these mistakes before users do.

---

# Task 8 — Security & Reliability Review

## Goal

Review and reflect on the security and reliability practices applied during this assignment.

### Security & Reliability Notes

Answer the following in your own words:

**1. Why is SSH key-based authentication more secure than sharing passwords?**

 When I set up my virtual server for this assignment, using an SSH key meant I didn't have to create or remember a weak password that could be guessed. Instead, my private key stays safe on my local machine and is never sent over the internet. This completely blocks brute-force attacks because bots can't guess a mathematical key pair like they can with a normal password. It makes me feel much safer knowing only my computer has access.

---

**2. Why should only required ports be open on a production server?**

 When I ran my port audit, I wanted to make sure my server was as locked down as possible. Keeping only ports 22 and 80 open means there are fewer entry points for someone to try to hack. If I left random ports open, any background service I forgot about could become an easy target. By closing everything else, I am directly shrinking my server's attack surface and keeping my deployment safe.

---

**3. Why is it important for Nginx to be enabled on boot?**

 During my testing, I realized that if my cloud instance ever reboots whether AWS does maintenance or the system crashes Nginx needs to start back up on its own. By enabling it, I don't have to panic and log in to manually start the web server to get my React app back online. It keeps my site running automatically without me having to watch it 24/7.

---

**4. What are the risks of sharing secrets, keys, or credentials publicly?**

 While working on this assignment, I had to be super careful not to push any of my private SSH keys or AWS credentials to GitHub. If I accidentally leaked them, automated scraper bots would find them in seconds. They would hijack my account, spin up expensive servers to mine crypto, or delete my work, leaving me with a massive cloud bill and a ruined project.

---

**5. Why should cloud resources be stopped or terminated when they are no longer needed?**

 As soon as I finish taking my screenshots and testing my Nginx server, I make sure to stop my instances. Cloud providers charge by the hour and leaving them running idle would just waste money. Plus, keeping an unused server active online is a security risk because I won't be actively monitoring it or updating it, which makes it an easy target for hackers over time.

---

# LinkedIn Post (Required)

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://www.linkedin.com/posts/busola-helen-awotimide_nothing-prepares-you-for-the-moment-you-break-ugcPost-7483280704185966592-vLVa?utm_source=share&utm_medium=member_desktop&rcm=ACoAADtjPKMBDnsQhcIAGnVO4so-PBvk2dEBay4

---

#### Screenshot — Published LinkedIn post

![alt text](<screenshots/assignment 3 linkedin.JPG>)

---

# Submission Instructions

- Add all required screenshots in your submission
- Full name must be visible in required screenshots
- Do not expose sensitive information (keys, passwords, account IDs)

---

# Completion Checklist

- [ ] Task 1: Screenshots (browser, ip a, ss -tulpen, ufw status) + Notes answered
- [ ] Task 2: Screenshots (nginx status, nginx -t, ss port 80) + Notes answered
- [ ] Task 3: Screenshots (access log, error log, journalctl) + Notes answered
- [ ] Task 4: Screenshots (uptime, free -h, df -h, du -sh) + Notes answered
- [ ] Task 5: Screenshots (ls html, grep deployed by, grep try_files) + Notes answered
- [ ] Task 6: Screenshots (nginx -t fail, nginx -t pass, curl recovery) + Notes answered
- [ ] Task 7: Screenshots (curl failure, curl recovery) + Notes answered
- [ ] Task 8: Security & Reliability Notes answered
- [ ] LinkedIn post published and URL submitted
- [ ] Full Name visible in all required screenshots
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