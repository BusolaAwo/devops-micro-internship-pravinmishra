# Assignment 04 — Deploy Mini Finance on Azure Using Terraform and Ansible

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will provision Azure infrastructure using Terraform and deploy the Mini Finance website using an Ansible multi-play playbook.

Terraform will create the Azure Virtual Machine and networking resources. Ansible will install Nginx, clone the Mini Finance repository, deploy the website, and verify the deployment.

---

# Task 1 — Create the Project Structure

## Goal

Create separate directories and files for the Terraform infrastructure and Ansible configuration.

### Evidence

#### Screenshot 1 — Terminal or VS Code showing the complete `mini-finance` project structure

![alt text](<screenshots/week 09-assignment 4-task1-screenshot1.JPG>)

---

### Notes



---

# Task 2 — Create the Azure Infrastructure Using Terraform

## Goal

Use Terraform to provision an Ubuntu Virtual Machine with the required Azure networking and security resources.

### Evidence

#### Screenshot 2 — Terraform code showing the `Allow-SSH` rule for port `22` and the `Allow-HTTP` rule for port `80`

![alt text](<screenshots/week 09-assignment 4-task2-screenshot2.JPG>)
---

#### Screenshot 3 — Terraform code showing the association between `nsg-mini-finance` and `nic-mini-finance`

![alt text](<screenshots/week 09-assignment 4-task2-screenshot3.JPG>)

---

### Notes



---

# Task 3 — Initialize and Apply the Terraform Configuration

## Goal

Format and validate the Terraform configuration, review the execution plan, and provision the Azure infrastructure.

### Evidence

#### Screenshot 4 — End of the `terraform apply` output showing `Apply complete!` with no errors

![alt text](<screenshots/week 09-assignment 4-task3-screenshot4.JPG>)

---

#### Screenshot 5 — Output of `terraform output public_ip` showing the VM’s public IP address

![alt text](<screenshots/week 09-assignment 4-task3-screenshot5.JPG>)

---

### Notes


---

# Task 4 — Verify Passwordless SSH Access

## Goal

Confirm that the Ansible controller can connect to the Terraform-provisioned Azure VM using SSH key authentication.

### Evidence

#### Screenshot 6 — Passwordless SSH command and the returned `mini-finance` hostname


![alt text](<screenshots/week 09-assignment 4-task4-screenshot6.JPG>)
---

### Notes



---

# Task 5 — Create the Ansible Inventory and Verify Connectivity

## Goal

Add the Terraform-provisioned Azure VM to the Ansible inventory and confirm that Ansible can connect to it.

### Evidence

#### Screenshot 7 — Ansible ping output showing `SUCCESS` and `pong` from the Azure VM


![alt text](<screenshots/week 09-assignment 4-task5-screenshot7.JPG>)

---

### Configuration File

Copy and paste the complete contents of your `ansible/inventory.ini` file below:

```ini
```
[web]
mini-finance ansible_host=40.89.199.106 ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa

---

# Task 6 — Create the Multi-Play Ansible Playbook

## Goal

Create one Ansible playbook containing separate plays to install Nginx, deploy the Mini Finance website, and verify the deployment.

### Evidence

#### Screenshot 8 — `site.yml` showing Play 1 and the beginning of Play 2

Screenshot must show:

- Play 1 targeting the `web` group
- Installation of `nginx`, `git`, and `rsync`
- Nginx service configured as started and enabled
- Beginning of Play 2 with the Git repository URL and synchronization task

![alt text](<screenshots/week 09-assignment 4-task6-screenshot8.JPG>)

---

#### Screenshot 9 — `site.yml` showing the deployment destination, handler, and Play 3 verification

Screenshot must show:

- Website destination `/var/www/html/`
- Ownership set to `www-data:www-data`
- Nginx reload handler
- Play 3 targeting `localhost`
- The `uri` verification and `assert` condition

![alt text](<screenshots/week 09-assignment 4-task6-screenshot9.JPG>)
---

### Configuration File

Copy and paste the complete contents of your `ansible/site.yml` file below:

```yaml

```
---
- name: Play 1 - Install Web Server and Dependencies
  hosts: web
  become: true
  tasks:
    - name: Update apt cache and install dependencies
      apt:
        update_cache: yes
        name:
          - nginx
          - git
          - rsync
        state: present

    - name: Start and enable Nginx service
      service:
        name: nginx
        state: started
        enabled: true

- name: Play 2 - Deploy Mini Finance Website
  hosts: web
  become: true
  tasks:
    - name: Clone repository to destination directory
      ansible.builtin.git:
        repo: 'https://github.com/pravinmishraaws/mini_finance'
        dest: /opt/mini-finance
        version: main
        force: yes

    - name: Copy website files to web root
      ansible.builtin.command: cp -r /opt/mini-finance/. /var/www/html/
      notify: Reload Nginx

    - name: Set permissions on web root
      file:
        path: /var/www/html
        state: directory
        recurse: yes
        owner: www-data
        group: www-data

  handlers:
    - name: Reload Nginx
      service:
        name: nginx
        state: reloaded

- name: Play 3 - Verify Deployment
  hosts: localhost
  connection: local
  gather_facts: no
  tasks:
    - name: Check HTTP response from web server
      uri:
        url: "http://40.89.199.106"
        return_content: yes
        status_code: 200
      register: web_check

    - name: Assert website is active
      assert:
        that:
          - web_check.status == 200
---

# Task 7 — Validate and Run the Ansible Playbook

## Goal

Validate the syntax of the multi-play Ansible playbook and run it to install Nginx, deploy the Mini Finance website, and verify the deployment.

### Evidence

#### Screenshot 10 — Successful playbook syntax check showing `playbook: site.yml`

![alt text](<screenshots/week 09-assignment 4-task7-screenshot10.JPG>)

---

#### Screenshot 11 — Play 3 output showing the successful HTTP verification and assertion

![alt text](<screenshots/week 09-assignment 4-task7-screenshot11.JPG>)
---

#### Screenshot 12 — Final `PLAY RECAP` showing `failed=0` and `unreachable=0`

![alt text](<screenshots/week 09-assignment 4-task7-screenshot12.JPG>)

---

### Notes



---

# Task 8 — Test the Mini Finance Website in a Browser

## Goal

Confirm that the Mini Finance website is publicly accessible through the Azure VM’s public IP address.

### Evidence

#### Screenshot 13 — Mini Finance website successfully loading in the browser, with the Azure VM’s public IP address visible in the address bar

![alt text](<screenshots/week 09-assignment 4-task8-screenshot13.JPG>)

---

### Website URL

Add your deployed website URL below:

```text

```
http://40.89.199.106
---

# Task 9 — Create the Project README

## Goal

Create a `README.md` file to document the Mini Finance infrastructure and deployment project.

### Evidence

#### Screenshot 14 — Completed `README.md` displayed in the VS Code Markdown preview or terminal

![alt text](<screenshots/week 09-assignment 4-task8-screenshot14.JPG>)

---

### README Content

Copy and paste the complete contents of your `README.md` file below:

```markdown

```
README

# Mini Finance Deployment with Ansible

## Project Overview
This project automates the deployment of the Mini Finance web application onto an Azure virtual machine using Ansible. It handles installing Nginx and dependencies, cloning the repository, synchronizing web files, and validating the deployment via automated assertions.

## Infrastructure & Tooling
* **Cloud Provider:** Microsoft Azure (Ubuntu 22.04 LTS VM)
* **Configuration Management:** Ansible
* **Web Server:** Nginx
* **Version Control:** Git

## Playbook Structure (`site.yml`)
1. **Play 1:** Targets the web server, updates apt cache, installs `nginx`, `git`, and `rsync`, and enables the Nginx service.
2. **Play 2:** Clones the repository to `/opt/mini-finance` and synchronizes the website files to the Nginx web root (`/var/www/html`).
3. **Play 3:** Verifies HTTP availability against the target server IP and asserts a successful `200 OK` response.

## Execution
Run the playbook from your control machine using:
```bash
ansible-playbook -i inventory.ini site.yml


---

# LinkedIn Post Required

## Evidence

#### Screenshot 15 — Published LinkedIn post showing the text and at least one deployment screenshot

week-09-ansible/screenshots/linkedin week09.JPG

---

#### LinkedIn Post URL

Paste your LinkedIn post URL here:

https://www.linkedin.com/posts/busola-helen-awotimide_i-could-have-used-one-tool-i-chose-not-to-activity-7505487027392483329-5wGD?

---

### LinkedIn Submission Notes

**One challenge you faced and how you fixed it:**

Challenge: The Ansible playbook hung indefinitely during the git clone task when using the repository URL provided in the base instructions (mini-finance-project), because the actual repository name on GitHub used an underscore (mini_finance), causing GitHub to prompt for credentials in a headless environment. Additionally, the initial synchronize module failed because it looked locally on the control node instead of the remote Azure VM

Fix: Corrected the repository URL to [https://github.com/pravinmishraaws/mini_finance](https://github.com/pravinmishraaws/mini_finance) in site.yml and replaced the synchronization task with a remote shell command (cp -r) to cleanly copy the cloned files directly to the Nginx web root (/var/www/html/).

---

**One real-world example where you can use this learning:**

Deploying a production multi-tier web application or client microservices portal on cloud infrastructure (like Azure or AWS). You can use Terraform to provision the underlying networks, security groups, and virtual machines, followed by Ansible to automatically install web servers, deploy code, and verify HTTP health checks in a repeatable, automated CI/CD workflow

---

# Assignment Questions

Answer the following in your own words:

**1. What did you provision using Terraform in this assignment?**

Provisioned core Azure cloud infrastructure including a Resource Group (Busola-rg-mini-finance), a Virtual Network (VNet), Subnets, a Public IP address, Network Security Groups (NSGs) with inbound rules for SSH and HTTP, and an Azure Linux Virtual Machine to host the application.

---

**2. What did Ansible configure and deploy in this assignment?**

Updated the system package cache, installed Nginx, Git, and synchronization tools, enabled and started the Nginx service, cloned the Mini Finance repository to the remote server, and copied the web assets into the Nginx web root (/var/www/html/).

---

**3. Why is SSH access on port `22` restricted to your public IP address?**

To enforce security best practices (least privilege access), ensuring that only authorized administrators connecting from a trusted IP address can access the server via SSH, preventing unauthorized brute-force or malicious login attempts from the public internet.

---

**4. Why is HTTP port `80` open to the internet?**

To allow public web traffic to reach the Nginx web server so that users can load and interact with the deployed Mini Finance website via standard web browsers.

---

**5. What is the purpose of the Ansible inventory file?**

To define the target hosts, group them logically (such as under the web group), and specify connection variables (like remote user names, SSH keys, and IP addresses) so Ansible knows exactly where and how to run playbook commands.

---

**6. Why does the playbook use separate plays for install, deploy, and verify?**

It implements modularity and separation of concerns ensuring that infrastructure packages are fully installed and services are running before application code is deployed, and that deployment is verified only after everything is fully set up.

---

**7. Why is `rsync` useful when deploying website files?**

It efficiently transfers only new or modified files rather than re-copying the entire directory, preserves file permissions, and minimizes network overhead during updates.
---

**8. What does the Ansible `uri` module verify in this assignment?**

It sends an automated HTTP request to the target server's IP address to verify that the web server responds with a successful status code (e.g., HTTP 200 OK), confirming the website is live and functioning correctly.

---

**9. What issue did you face during this assignment, and how did you fix it?**

Faced a headless hang during the git clone due to a repository URL mismatch (-project vs _finance), which was resolved by updating the repository link to point to the correct public repository URL

---

**10. What did you learn from using Terraform and Ansible together?**

Learned how to combine Infrastructure as Code (Terraform) for provisioning immutable cloud resources with Configuration Management (Ansible) for software installation and deployment, establishing a complete and repeatable automation workflow.
---

# Required Files

Confirm that the following files are included in your assignment folder:

- [ ] `.gitignore`
- [ ] `README.md`
- [ ] `terraform/providers.tf`
- [ ] `terraform/main.tf`
- [ ] `terraform/variables.tf`
- [ ] `terraform/outputs.tf`
- [ ] `ansible/inventory.ini`
- [ ] `ansible/site.yml`

---

# Submission Instructions

- Add all required screenshots in the correct order.
- Full Name must be visible in required screenshots.
- Add the Azure VM public IP address.
- Add the final Mini Finance website URL.
- Paste `inventory.ini`, `site.yml`, and `README.md` as editable text.
- Answer all assignment questions clearly in your own words.
- Add your LinkedIn post URL.
- Do not expose SSH private keys, passwords, Azure credentials, subscription IDs, Terraform state contents, or other sensitive information.

---

# Completion Checklist

- [ ] Task 1: `mini-finance` project structure created
- [ ] Task 1: `.gitignore` created
- [ ] Task 2: Terraform Azure infrastructure code created
- [ ] Task 2: `Allow-SSH` rule configured for port `22`
- [ ] Task 2: `Allow-HTTP` rule configured for port `80`
- [ ] Task 2: NSG associated with the Network Interface
- [ ] Task 3: `terraform fmt` completed
- [ ] Task 3: `terraform init` completed
- [ ] Task 3: `terraform validate` completed successfully
- [ ] Task 3: `terraform apply` completed successfully
- [ ] Task 3: `terraform output public_ip` displayed the VM public IP
- [ ] Task 4: Passwordless SSH works from the Ansible controller
- [ ] Task 5: `inventory.ini` created
- [ ] Task 5: Ansible ping returns `SUCCESS` and `pong`
- [ ] Task 6: `site.yml` contains three separate plays
- [ ] Task 6: Play 1 installs Nginx, Git, and rsync
- [ ] Task 6: Play 2 clones and deploys the Mini Finance website
- [ ] Task 6: Play 3 verifies HTTP status code `200`
- [ ] Task 7: Playbook syntax check passes
- [ ] Task 7: Ansible playbook completes successfully
- [ ] Task 7: Final recap shows `failed=0` and `unreachable=0`
- [ ] Task 8: Mini Finance website loads in the browser
- [ ] Task 8: Azure VM public IP is visible in the browser screenshot
- [ ] Task 9: `README.md` completed
- [ ] Screenshots 1–15 are included
- [ ] `inventory.ini`, `site.yml`, and `README.md` are pasted as editable text
- [ ] Assignment questions are answered
- [ ] LinkedIn post published with Anyone visibility
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