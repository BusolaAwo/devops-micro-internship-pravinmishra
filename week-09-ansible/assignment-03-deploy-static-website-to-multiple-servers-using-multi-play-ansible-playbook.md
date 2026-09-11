# Assignment 03 — Deploy a Static Website to Multiple Servers Using a Multi-Play Ansible Playbook

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Student Details

**Full Name:** Busola Helen Awotimide 
**Cloud Platform Used:** AWS   
**Server 1 URL:** ``  http://44.200.55.89
**Server 2 URL:** `   http://100.27.44.252

---

## Purpose

In this assignment, you will create a multi-play Ansible playbook to install Nginx, deploy a static website to two Ubuntu servers, and verify that the website is accessible from both servers.

You may use either AWS EC2 instances or Azure Virtual Machines as your managed servers.

---

# Task 1 — Create the Project Structure

## Goal

Create the required folders and files for the Ansible project.

## Evidence

### Screenshot 1 — Terminal or VS Code showing the complete `static-web` project structure

![alt text](<screenshots/week 09-assignment 3-task1-screenshot1.JPG>)

---

# Task 2 — Configure the Ansible Inventory

## Goal

Add both Ubuntu servers to the Ansible inventory.

## Evidence

### Screenshot 2 — Output of `ansible-inventory -i inventory.ini --graph` showing `web1` and `web2`

![alt text](<screenshots/week 09-assignment 3-task2-screenshot2.JPG>)

---

## Configuration File

Copy and paste the complete contents of your `inventory.ini` file below:



```[web]
web1 ansible_host=44.200.55.89
web2 ansible_host=100.27.44.252

[web:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_ed25519

---

# Task 3 — Verify Ansible Connectivity

## Goal

Confirm that the Ansible controller can connect to both servers.

## Evidence

### Screenshot 3 — Ansible ping output showing `SUCCESS` and `pong` for both servers


![alt text](<screenshots/week 09-assignment 3-task3-screenshot3.JPG>)
---

# Task 4 — Download and Personalize the Static Website

## Goal

Download `index.html` to the Ansible controller and personalize the website with your full name.

## Evidence

### Screenshot 4 — Edited `files/index.html` showing the footer line with your full name

week-09-ansible/screenshots/week 09-assignment 3-task4-screenshot4.JPG

---

# Task 5 — Create the Multi-Play Ansible Playbook

## Goal

Create a single Ansible playbook containing separate plays for installation, deployment, and verification.

## Configuration File

Copy and paste the complete contents of your `site.yml` file below:



``` name: Play 1 - Install and Configure Nginx
hosts: web
become: true
tasks:

name: Update APT package cache
ansible.builtin.apt:
update_cache: yes

name: Install Nginx package
ansible.builtin.apt:
name: nginx
state: present

name: Start and enable Nginx service
ansible.builtin.service:
name: nginx
state: started
enabled: true

name: Play 2 - Deploy the Static Website
hosts: web
become: true
tasks:

name: Copy static website file to web server
ansible.builtin.copy:
src: files/index.html
dest: /var/www/html/index.html
owner: www-data
group: www-data
mode: "0644"
notify: Reload Nginx

handlers:

name: Reload Nginx
ansible.builtin.service:
name: nginx
state: reloaded

name: Play 3 - Verify Both Websites from Controller
hosts: localhost
connection: local
gather_facts: false
tasks:

name: Send HTTP GET request to web servers
ansible.builtin.uri:
url: "http://{{ hostvars[item].ansible_host }}"
status_code: 200
loop: "{{ groups['web'] }}"
register: website_checks

name: Assert that website status is 200
ansible.builtin.assert:
that:
- item.status == 200
success_msg: "{{ item.item }} returned HTTP 200"
loop: "{{ website_checks.results }}"

---

# Task 6 — Validate the Playbook Syntax

## Goal

Check the playbook for YAML or Ansible syntax errors before running it.

## Evidence

### Screenshot 5 — Successful syntax-check output showing `playbook: site.yml`

week-09-ansible/screenshots/week 09-assignment 3-task6-screenshot5.JPG

---

# Task 7 — Run the Multi-Play Playbook

## Goal

Install Nginx, deploy the website, and verify both servers in one playbook run.

## Evidence

### Screenshot 6 — Play 3 verification showing HTTP `200` for both servers

week-09-ansible/screenshots/week 09-assignment 3-task7-screenshot6.JPG

---

### Screenshot 7 — Final play recap showing `unreachable=0` and `failed=0` for `web1`, `web2`, and `localhost`

week-09-ansible/screenshots/week 09-assignment 3-task7-screenshot7.JPG

---

# Task 8 — Verify Idempotency

## Goal

Run the playbook again and confirm that it does not make unnecessary changes.

## Evidence

### Screenshot 8 — Second playbook run showing the play recap with `changed=0`, `unreachable=0`, and `failed=0` for both web servers

week-09-ansible/screenshots/week 09-assignment 3-task8-screenshot8.JPG

---

# Task 9 — Test Both Websites Manually

## Goal

Confirm that the static website is accessible from both public IP addresses.

## Evidence

### Screenshot 9 — `curl -I` output showing HTTP `200 OK` from both servers

week-09-ansible/screenshots/week 09-assignment 3-task9-screenshot9.JPG
---

### Screenshot 10 — Browser showing the website from Server 1 with the public IP and your full name visible

week-09-ansible/screenshots/week 09-assignment 3-task9-screenshot10.JPG

week-09-ansible/screenshots/week 09-assignment 3-task9-screenshot10a.JPG

---

### Screenshot 11 — Browser showing the website from Server 2 with the public IP and your full name visible

week-09-ansible/screenshots/week 09-assignment 3-task9-screenshot11.JPG

week-09-ansible/screenshots/week 09-assignment 3-task9-screenshot11a.JPG

---

## Website URLs

Add both deployed website URLs below:


Server 1: http://44.200.55.89
Server 2: http://100.27.44.252
```

---

# Task 10 — Complete the Project README

## Goal

Document how the project works and record what you learned.

## README Content

Copy and paste the complete contents of your `README.md` file below:

```markdown

```# Automated Static Website Deployment with Ansible

## Overview
This project automates the provisioning, configuration, and verification of a personalized static website across two remote AWS Ubuntu instances (`web1` and `web2`) using Ansible. It demonstrates Infrastructure as Code (IaC) principles, multi-playbook orchestration, service management, and automated health verification.

## Architecture & Inventory
- **Controller Node**: Local environment running Ansible and Python virtual environment (`.venv`).
- **Managed Nodes**:
  - `web1`: `44.200.55.89` (Ubuntu)
  - `web2`: `100.27.44.252` (Ubuntu)
- **Web Server**: Nginx web server configured to serve static assets with the custom footer displaying **Busola Helen Awotimide**.

## Playbook Structure (`site.yml`)
The project utilizes a multi-play playbook containing:
1. **Play 1**: Updates the APT cache, installs Nginx, and ensures the service is started and enabled on all target web servers.
2. **Play 2**: Copies the custom static website files to the remote web roots (`/var/www/html/index.html`), applies correct file permissions (`0644`), ownership (`www-data:www-data`), and triggers a handler to reload Nginx.
3. **Play 3**: Executes HTTP GET requests from the local controller to verify that both web servers return an HTTP `200 OK` status code successfully.

## Usage & Execution

1. Activate your virtual environment and navigate to the project directory:
   ```bash
   source .venv/bin/activate
   cd ansible-onboarding/static-web

---

# LinkedIn Post Required

## Evidence

### LinkedIn Post URL

Paste your LinkedIn post URL here:



---

### Screenshot — Published LinkedIn post



---

# Assignment Questions

Answer the following in your own words:

**1. What issue did you face while completing this assignment, and how did you fix it?**

While working on the playbook structure, I encountered YAML parsing errors due to minor spacing and unquoted configuration values, as well as handling initial connectivity and python configuration requirements for the managed Ubuntu instances. I resolved these by carefully validating syntax blocks using --syntax-check and standardizing indentation and quoting for task parameters.

---

**2. What did you learn from this assignment?**

I learned how to structure multi-play Ansible playbooks to handle system package installations, file synchronization with specific permissions, handler-driven service reloads, and automated API-driven health checks directly from the controller node

---

**3. Why is it useful to split installation, deployment, and verification into separate plays?**

Splitting tasks into distinct plays separates concerns based on execution context and privilege levels. For instance, package installation and file copying require administrative privileges (become: true) on remote web servers, whereas HTTP verification runs efficiently from the local controller node using hosts: localhost and gather_facts: false. This makes the workflow modular, easier to maintain, and logically isolated.

---

**4. What is one benefit of using the Ansible `copy` module instead of cloning the website directly from Git on every managed server?**

The Ansible copy module ensures that static assets are pushed directly from the controller source directory, eliminating the security risk and operational overhead of storing Git deployment keys or credentials on production web servers. It also provides precise, declarative control over file ownership and permissions (www-data:www-data, 0644).

---

**5. What does idempotency mean in this assignment?**

Idempotency means that executing the playbook multiple times produces changes only when actual configuration drift occurs. If the web servers are already fully configured, services are running, and files match the target state, running the playbook again will not re-apply redundant updates, ensuring predictable and safe state management.

---

**6. What does the Ansible `uri` module verify in Play 3?**

In Play 3, the Ansible uri module sends HTTP GET requests to the public IP addresses of web1 and web2 to verify that the Nginx web servers are actively running, reachable, and successfully returning an HTTP 200 OK status code.

---

# Required Files

Confirm that the following files are included in your assignment folder:

- [ ] `inventory.ini`
- [ ] `site.yml`
- [ ] `files/index.html`
- [ ] `README.md`

---

# Submission Instructions

- Add all required screenshots in the correct order.
- Full Name must be visible in required screenshots.
- Include both deployed website URLs.
- Paste `inventory.ini`, `site.yml`, and `README.md` as editable text.
- Answer all assignment questions clearly in your own words.
- Add your LinkedIn post URL.
- Do not expose SSH private keys, passwords, cloud account IDs, or other sensitive information.

---

# Completion Checklist

- [ ] Task 1: `static-web` folder structure is complete
- [ ] Task 2: Both servers are listed under the `[web]` group in `inventory.ini`
- [ ] Task 2: Inventory graph shows `web1` and `web2`
- [ ] Task 3: Ansible ping returns `SUCCESS` and `pong` for both servers
- [ ] Task 4: `files/index.html` contains your full name
- [ ] Task 5: `site.yml` contains three separate plays
- [ ] Task 5: Play 1 installs, starts, and enables Nginx
- [ ] Task 5: Play 2 deploys `index.html` using the `copy` module
- [ ] Task 5: Nginx reload handler is included
- [ ] Task 5: Play 3 verifies both web servers from the controller
- [ ] Task 6: Playbook syntax check passes
- [ ] Task 7: First playbook run completes with `unreachable=0` and `failed=0`
- [ ] Task 7: URI verification returns HTTP `200` for both servers
- [ ] Task 8: Second playbook run demonstrates idempotency
- [ ] Task 8: Second run shows `changed=0` for both web servers
- [ ] Task 9: Both `curl -I` commands return HTTP `200 OK`
- [ ] Task 9: Website loads from Server 1
- [ ] Task 9: Website loads from Server 2
- [ ] Task 9: Full name is visible on both deployed websites
- [ ] Task 10: `README.md` contains all required explanations
- [ ] Screenshots 1–11 are included
- [ ] `inventory.ini`, `site.yml`, and `README.md` are pasted as editable text
- [ ] Both website URLs are included
- [ ] Assignment questions are answered
- [ ] LinkedIn post published
- [ ] LinkedIn post URL added
- [ ] No sensitive information is exposed

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

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*