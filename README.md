# AWS Elastic Beanstalk Deployment for Todo-App

This README outlines the steps for deploying the `todo-app`, a Python Flask application, to AWS Elastic Beanstalk. It includes setting up the environment, deploying the app, and basic management commands.

## Prerequisites

- Python 3.9
- AWS CLI installed and configured with necessary AWS credentials.
- AWS Elastic Beanstalk CLI (EB CLI)

## Setup Manually (Recommended for applications without Database)

### Step 1: Install AWS Elastic Beanstalk CLI

```bash
pip3 install awsebcli
```

### Step 2: Initialize Your Elastic Beanstalk Application

```bash
eb init -p "Python 3.9" todo-app
```

This command initializes your EB application and sets Python 3.9 as the platform.

### Step 3: Create an Elastic Beanstalk Environment

```bash
eb create todo-app
```

This command creates an EB environment named `todo-app`.

### Step 4: Set Environment Variables

```bash
eb setenv DATABASE_URL=mysql://username:password@hostname:port/dbname
```

Replace `username`, `password`, `hostname`, `port`, and `dbname` with your actual MySQL RDS credentials and database details.

### Step 5: Deploy Your Application

```bash
eb deploy
```

This command deploys your application to the EB environment.

### Step 6: Open Your Application in a Browser

```bash
eb open
```

This command opens your deployed application in the default web browser.

## Management Commands

### Listing Environments

```bash
eb list
```

Lists all the environments in your EB application.

### Deleting an Application

```bash
eb delete app-name
```

Replace `app-name` with the name of your application. This command deletes the specified EB application.

### Terminating an Environment

```bash
eb terminate environment-name
```

Replace `environment-name` with the name of your environment. This command terminates the specified EB environment.

### Viewing Environment Events

```bash
eb events
```

This command shows recent events for your EB environment.
