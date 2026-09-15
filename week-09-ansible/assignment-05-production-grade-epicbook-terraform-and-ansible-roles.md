# Assignment — Deploy EpicBook with Terraform and Ansible Roles

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will deploy the EpicBook web application using Terraform and Ansible roles.

Terraform provisions the cloud infrastructure, including one Ubuntu VM and one managed MySQL database. Ansible roles configure the VM, install required software, deploy the EpicBook application, configure Nginx, connect the app to the managed MySQL database, and verify the deployment.

---

# Task 1 — Set Up the Project Folder Layout

## Goal

Create the project folder structure for Terraform and Ansible roles.

Terraform will be used to provision the cloud infrastructure. Ansible roles will be used to configure the VM and deploy the EpicBook application.

### Evidence

#### Screenshot 1 — Terminal showing the completed `epicbook-prod` project structure

![alt text](<screenshots/week 09-assignment 5-task1-screenshot1.JPG>)

---

### Notes

Answer the following in your own words:

**1. Which cloud provider did you choose for this assignment?**

Microsoft Azure

---

**2. Why is it useful to keep Terraform files and Ansible files in separate folders?**

Keeping them separated maintains a clean separation of concerns: Terraform is dedicated to immutable infrastructure provisioning, while Ansible handles configuration management and application deployment

---

**3. What is the purpose of the `roles` directory in Ansible?**

It organizes automation code into modular, reusable components (common, nginx, epicbook), separating tasks, templates, and variables for better maintainability.
---

# Task 2 — Provision the Infrastructure with Terraform

## Goal

Run Terraform to provision the cloud infrastructure for the EpicBook deployment.

Terraform will create the VM, managed MySQL database, networking, security rules, and required outputs.

### Evidence

#### Screenshot 2 — `terraform apply` completed successfully

![alt text](<screenshots/week 09-assignment 5-task2-screenshot2.JPG>)

---

#### Screenshot 3 — Output of `terraform output`

![alt text](<screenshots/week 09-assignment 5-task2-screenshot3.JPG>)

---

#### Screenshot 4 — Azure Portal or AWS Console showing the VM running

![alt text](<screenshots/week 09-assignment 5-task2-screenshot4.JPG>)

---

#### Screenshot 5 — Azure Portal or AWS Console showing the managed MySQL database created

![alt text](<screenshots/week 09-assignment 5-task2-screenshot5.JPG>)

---

### Notes

Answer the following in your own words:

**1. What resources did Terraform create for this assignment?**

An Azure Resource Group, Virtual Network, Subnet, Network Security Group, Ubuntu Virtual Machine, public IP, and an Azure Database for MySQL flexible server instance.

---

**2. Why should you review `terraform plan` before running `terraform apply`?**

To inspect the execution graph and verify exactly what resources will be added, modified, or destroyed before making changes to live cloud infrastructure.
---

**3. Why should database passwords not be shown in Terraform output?**

Because Terraform outputs are displayed in plaintext in terminal histories and logs, exposing secrets in outputs creates a severe security risk.

---

# Task 3 — Verify SSH Key-Based Access

## Goal

Verify that the cloud VM can be accessed from the Ansible controller using SSH key-based authentication.

### Evidence

#### Screenshot 6 — Successful SSH hostname check from the Ansible controller

![alt text](<screenshots/week 09-assignment 5-task3-screenshot6.JPG>)

---

### Notes

Answer the following in your own words:

**1. What command did you use to verify SSH access?**

ssh -i <private_key> azureuser@<public_ip> (or checking host connectivity via ansible controller)
---

**2. What proves that SSH key-based access worked successfully?**

The remote terminal shell prompt opened successfully as the VM user without prompting for a password

---

**3. What would you check if SSH returned `Permission denied (publickey)`?**

I would check the private key file permissions (chmod 400), verify that the correct public key was added to the VM, and ensure the correct username was specified.

---

# Task 4 — Create the Ansible Inventory and Configuration

## Goal

Create the Ansible inventory file and local Ansible configuration for the EpicBook VM.

The inventory tells Ansible which VM to manage and which SSH user to use.

### Evidence

#### Screenshot 7 — `inventory.ini` showing the VM under the `web` group

![alt text](<screenshots/week 09-assignment 5-task4-screenshot7.JPG>)

---

#### Screenshot 8 — Output of `ansible-inventory -i inventory.ini --graph`

![alt text](<screenshots/week 09-assignment 5-task4-screenshot8.JPG>)

---

#### Screenshot 9 — Output of `ansible web -i inventory.ini -m ping`

![alt text](<screenshots/week 09-assignment 5-task4-screenshot9.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of `inventory.ini`?**

It defines the target hosts and groups (such as web) that Ansible will manage and run playbooks against.

---

**2. What does `ansible_host` store?**


The public IP address of the target remote virtual machine.
---

**3. What does `ansible_ssh_private_key_file` tell Ansible?**

The local filesystem path to the SSH private key file required to securely authenticate with the target VM.

---

**4. Why is `host_key_checking = False` used only for this temporary lab?**

It bypasses SSH host key prompts for new connections, which speeds up automation runs but disables Man-in-the-Middle (MitM) protections.

---

# Task 5 — Create the Main Ansible Playbook

## Goal

Create the main Ansible playbook that runs the required roles in the correct order.

The `site.yml` file will call the `common`, `nginx`, and `epicbook` roles.

### Evidence

#### Screenshot 10 — `site.yml` showing the roles in the correct order


![alt text](<screenshots/week 09-assignment 5-task5-screenshot10.JPG>)
---

#### Screenshot 11 — Output of `ansible-playbook -i inventory.ini site.yml --syntax-check`

![alt text](<screenshots/week 09-assignment 5-task5-screenshot11.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of `site.yml`?**

It acts as the orchestration entrypoint playbook that executes the defined roles in their proper sequence against targeted inventory groups.

---

**2. Why should the roles run in the order `common`, `nginx`, and `epicbook`?**

Because system dependencies must be set up first (common), followed by the web server reverse proxy (nginx), before deploying the application code and process manager (epicbook).
---

**3. What does `become: true` allow Ansible to do?**

It allows Ansible to execute tasks with elevated privileges (as sudo root user) on the target host.
---

# Task 6 — Create the `common` Role

## Goal

Create the `common` role to prepare the Ubuntu VM with the basic packages required for the EpicBook deployment.

This role handles the common server setup before Nginx and the application are configured.

### Evidence

#### Screenshot 12 — `roles/common/tasks/main.yml` showing the common setup tasks

![alt text](<screenshots/week 09-assignment 5-task6-screenshot12.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the responsibility of the `common` role?**

To update system packages, install core dependencies like Node.js, npm, git, and mysql-client, and prepare the base operating system environment.
---

**2. Why should Nginx installation not be placed inside the `common` role?**

To maintain modularity; Nginx has a specialized configuration lifecycle as a reverse proxy, so separating it into its own role keeps responsibilities cleanly isolated.

---

**3. Why is `mysql-client` useful in this deployment?**

It provides command-line utilities to test and verify network connectivity against the remote Azure managed MySQL database.

---

# Task 7 — Create the `nginx` Role

## Goal

Create the `nginx` role to install Nginx and configure it as a reverse proxy for the EpicBook application.

Nginx will receive browser traffic on port `80` and forward it to the EpicBook Node.js application running on the VM.

### Evidence

#### Screenshot 13 — `roles/nginx/tasks/main.yml` showing Nginx installation and site configuration tasks

![alt text](<screenshots/week 09-assignment 5-task7-screenshot13.JPG>)

---

#### Screenshot 14 — `roles/nginx/templates/epicbook.conf.j2` showing the reverse proxy configuration

![alt text](<screenshots/week 09-assignment 5-task7-screenshot14.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the responsibility of the `nginx` role?**

To install the Nginx web server, deploy custom virtual host configuration templates, and ensure the service is enabled and running.

---

**2. Why is Nginx configured as a reverse proxy in this deployment?**

To securely receive client HTTP traffic on port 80 and forward requests safely to the backend Node.js application running internally on port 8080.
---

**3. Why should the application port come from `group_vars/web.yml` instead of being hard-coded?**

It centralizes configuration parameters, making it easier to change application ports across templates and tasks without modifying role logic.

---

# Task 8 — Create the `epicbook` Role

## Goal

Create the `epicbook` role to deploy the EpicBook application, connect it to the managed MySQL database, and run the application on port `8080` using PM2.

### Evidence

#### Screenshot 15 — `roles/epicbook/tasks/main.yml` showing application deployment tasks

![alt text](<screenshots/week 09-assignment 5-task8-screenshot15.JPG>)

---

#### Screenshot 16 — Task or file showing how the database connection is configured, with secrets hidden

![alt text](<screenshots/week 09-assignment 5-task8-screenshot16.JPG>)

---

#### Screenshot 17 — Task or output showing the EpicBook application managed by PM2

![alt text](<screenshots/week 09-assignment 5-task8-screenshot17.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the responsibility of the `epicbook` role?**

To clone or copy the application code, install Node.js dependencies, configure database environment variables, and manage the process using PM2.

---

**2. Why is PM2 used for the EpicBook Node.js application?**

It functions as a production process manager that restarts the application automatically on crashes, handles background execution, and maintains system logs.
---

**3. Why should database passwords not be hard-coded in public files?**

Hard-coding plaintext credentials in shared or public repositories risks unauthorized database access and data compromise.

---

**4. What does it mean for the application to run on port `8080` while Nginx listens on port `80`?**

Clients connect to Nginx publicly on standard HTTP port 80, while Nginx internally proxies traffic to the Node.js application listening locally on port 8080.

---

# Task 9 — Create Group Variables

## Goal

Create reusable variables for the EpicBook deployment.

The `group_vars/web.yml` file stores values that can be reused across the Ansible roles.

### Evidence

#### Screenshot 18 — `group_vars/web.yml` showing the application, PM2, and database variables, with passwords hidden or masked

![alt text](<screenshots/week 09-assignment 5-task9-screenshot18.JPG>)

---

### Notes

Answer the following in your own words:

**1. What is the purpose of `group_vars/web.yml`?**

To store global variables, application settings, and database connection parameters mapped specifically to the web inventory group

---

**2. Which values did you store in `group_vars/web.yml`?**

Application port, node environment settings, database host endpoint, database username, database name, and database password secrets

---

**3. How did you handle the database password securely?**

By isolating variables within restricted group variable files and planning for encryption or secure environment variable injection.

---

# Task 10 — Run the Ansible Playbook

## Goal

Run the Ansible playbook to configure the VM and deploy the EpicBook application.

The playbook should run the roles in this order:

1. `common`
2. `nginx`
3. `epicbook`

### Evidence

#### Screenshot 19 — Ansible playbook output showing the roles running

![alt text](<screenshots/week 09-assignment 5-task10-screenshot19.JPG>)

---

#### Screenshot 20 — Final Ansible recap showing `failed=0`

![alt text](<screenshots/week 09-assignment 5-task10-screenshot20.JPG>)
---

#### Screenshot 21 — Output of `ansible web -i inventory.ini -m command -a "systemctl is-active nginx" --become`

![alt text](<screenshots/week 09-assignment 5-task10-screenshot21.JPG>)

---

#### Screenshot 22 — Output of `ansible web -i inventory.ini -m command -a "pm2 status"`

![alt text](<screenshots/week 09-assignment 5-task10-screenshot22.JPG>)

---

#### Screenshot 23 — Output of `ansible web -i inventory.ini -m command -a "curl -I http://localhost:8080"`

![alt text](<screenshots/week 09-assignment 5-task10-screenshot23.JPG>)

---

### Notes

Answer the following in your own words:

**1. What command did you run to execute the Ansible playbook?**

ansible-playbook -i inventory.ini site.yml

---

**2. How do you know all roles completed successfully?**

The final execution summary output reported zero failed tasks across all applied roles.

---

**3. What proves that Nginx is active?**

The systemctl is-active nginx command returned an active status.

---

**4. What proves that PM2 is managing the EpicBook application?**

The pm2 status command showed the epicbook process running with an online status

---

**5. What proves that the EpicBook application responds on port `8080`?**

Running curl -I http://localhost:8080 returned a valid HTTP response from the application server.


---

# Task 11 — Verify the EpicBook Deployment

## Goal

Verify that the EpicBook application is running, accessible in the browser, and connected to the managed MySQL database.

### Evidence

#### Screenshot 24 — Output of `curl -I http://<public_ip>`

![alt text](<screenshots/week 09-assignment 5-task11-screenshot24.JPG>)

---

#### Screenshot 25 — Output of the cart API test command



---

#### Screenshot 26 — Output of the `/cart` HTTP status check



---

#### Screenshot 27 — Browser showing the EpicBook application loaded from `http://<public_ip>`



---

### Notes

Answer the following in your own words:

**1. What HTTP response did you receive from the public application URL?**

An HTTP/1.1 200 OK response.

---

**2. What did the cart API test prove?**

It proved that backend route handlers and API endpoints were fully operational.

---

**3. What did the `/cart` status check return?**

An HTTP 200 OK status code.

---

**4. What issue did you face during verification, and how did you fix it?**

PM2 initially started the application without loading database environment variables, causing Sequelize to crash with a connection refused error on port 3306. This was fixed by creating a PM2 ecosystem configuration file (ecosystem.config.js) to explicitly inject the correct Azure MySQL credentials and port settings.

---

# LinkedIn Post Required

## Evidence

#### LinkedIn Post URL

Paste your LinkedIn post URL here:



---

#### Screenshot — Published LinkedIn post



---

# Assignment Questions

Answer the following in your own words:

**1. Why is Terraform used for infrastructure provisioning?**

It provides declarative Infrastructure as Code to deploy cloud resources consistently and repeatably.

---

**2. Why are Ansible roles useful for production-style deployments?**

They establish an organized directory structure that cleanly modularizes tasks, templates, and handlers for scalability

---

**3. What is the purpose of `group_vars/web.yml`?**

To centralize host-group specific configuration variables and maintain separation from playbook logic.

---

**4. Why should database passwords not be committed to GitHub?**

To prevent sensitive security credentials from being exposed publicly in version history.

---

**5. What is the purpose of Nginx in this deployment?**

To act as a reverse proxy handling client web traffic on port 80 and forwarding requests to the application.

---

**6. Why should the managed MySQL database not be publicly accessible?**

To protect backend data storage from unauthorized external exposure and network attacks.

---

**7. Why is PM2 used for the EpicBook Node.js application?**

To guarantee application uptime, handle process restarts automatically, and manage background logging.

---

**8. What does idempotency mean in Ansible?**

The ability to run playbooks multiple times safely so that changes are applied only when differences exist.

---

**9. What issue did you face during the deployment, and how did you fix it?**

Environment variables weren't picked up automatically by PM2 during startup, which was resolved by implementing an explicit ecosystem configuration file (ecosystem.config.js).

---

**10. What security improvement would you make before using this setup in production?**

I would integrate Ansible Vault for credential encryption, configure HTTPS using SSL/TLS certificates, and strictly restrict cloud firewall security rules.

---

# Required Files

Confirm that the following files are included in your GitHub repository or assignment folder:

- [ ] `README.md`
- [ ] Terraform files under either `terraform/azure/` or `terraform/aws/`
- [ ] `ansible/ansible.cfg`
- [ ] `ansible/inventory.ini`
- [ ] `ansible/site.yml`
- [ ] `ansible/group_vars/web.yml`
- [ ] `ansible/roles/common/tasks/main.yml`
- [ ] `ansible/roles/nginx/tasks/main.yml`
- [ ] `ansible/roles/nginx/templates/epicbook.conf.j2`
- [ ] `ansible/roles/epicbook/tasks/main.yml`

---

# Submission Instructions

- Add all required screenshots in your submission.
- Full Name must be visible in required screenshots.
- Mention the cloud provider used: Azure or AWS.
- Add the VM public IP address.
- Add the final application URL.
- Add Terraform output proof.
- Add Ansible role tree proof.
- Add all required notes and assignment question answers.
- Add your LinkedIn post URL.
- Do not expose SSH private keys, passwords, cloud credentials, database credentials, Terraform state files, subscription IDs, or account IDs.

---

# Completion Checklist

- [ ] Task 1: Project folder layout created
- [ ] Task 2: Terraform infrastructure provisioned
- [ ] Task 3: SSH key-based access verified
- [ ] Task 4: Ansible inventory and configuration created
- [ ] Task 5: Main Ansible playbook created
- [ ] Task 6: `common` role created
- [ ] Task 7: `nginx` role created
- [ ] Task 8: `epicbook` role created
- [ ] Task 9: Group variables created
- [ ] Task 10: Ansible playbook run completed
- [ ] Task 11: EpicBook deployment verified
- [ ] Terraform files created under only one cloud provider folder
- [ ] One Ubuntu VM was created
- [ ] One managed MySQL database was created
- [ ] SSH port `22` is restricted to the controller public IP
- [ ] HTTP port `80` is accessible
- [ ] MySQL port `3306` is not publicly open
- [ ] `ansible web -i inventory.ini -m ping` returns `SUCCESS`
- [ ] `site.yml` calls the roles in the correct order
- [ ] Database secrets are hidden or handled securely
- [ ] Nginx is active
- [ ] PM2 shows the EpicBook application running
- [ ] EpicBook responds on port `8080`
- [ ] Public URL loads in the browser
- [ ] Cart API verification works
- [ ] Playbook completes with `failed=0`
- [ ] Screenshots 1–27 are included
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

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*