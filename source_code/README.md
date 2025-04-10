# Hanko Next.js example

This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Prerequisites:

### If using Hanko Cloud

- Create and configure your Hanko Cloud profile (see the instructions on how to get started with [Hanko Cloud](https://cloud.hanko.io/login) in [Hanko Docs](https://docs.hanko.io/))
- Create a new project to get the Hanko API running.

### If using Hanko Backend

- A running Hanko API (see the instructions on how to run the API from the[ Hanko backend](https://github.com/teamhanko/hanko/blob/main/backend/README.md#from-source)).

### Set up environment variables

Create the `.env` file in the root directory, set up the correct environment variables:

- `DATABASE_URL="file:./dev.db"`: this is the URL to the SQLite database file that will be created inside the `prisma` directory with the name `dev.db`
- `NEXT_PUBLIC_HANKO_API_URL`: this is the URL of the Hanko API, you can find it in your [Hanko Cloud](https://cloud.hanko.io/login) dashboard.

## Getting Started

### 1.Install dependencies

Run `npm install` to install dependencies.

```shell
npm install
```

### 2. Create and seed the database

Run the following command to create your SQLite database file. This also creates the Todo table that is defined in `prisma/schema.prisma`:

```shell
npx prisma migrate dev --name init
```

### 3. Start the app

Run `npm run dev` for a development server.

```shell
npm run dev
```

Now the app is running, navigate to `http://localhost:8888/`. The application will automatically reload if you change any of the source files.

## 🧰 Jenkins Setup Guide

This project includes a pre-configured `Jenkinsfile` to automate the following steps:

- Build and push Docker image to AWS ECR
- Deploy the image to AWS ECS Fargate

To run this pipeline, follow the instructions below.

---

## ⚙️ 1. Install Jenkins and Required Plugins

Make sure Jenkins is installed and running. Install the following plugins:

- **Docker Pipeline**
- **Pipeline**
- **AWS Credentials**
- **Amazon ECR**
- **Pipeline: AWS Steps**
- **Blue Ocean** (optional, for a nice UI)

---

## 🔐 2. Configure Jenkins Credentials

Go to **Jenkins Dashboard → Manage Jenkins → Credentials → (global)** and add the following credentials:

| ID                                 | Type        | Description                         |
|------------------------------------|-------------|-------------------------------------|
| `HCMUS_SEMINAR_AWS_ACCOUNT_ID`     | Secret Text | Your AWS account ID                 |
| `HCMUS_SEMINAR_AWS_ACCESS_KEY`     | Secret Text | AWS Access Key ID                   |
| `HCMUS_SEMINAR_AWS_SECRET_ACCESS_KEY` | Secret Text | AWS Secret Access Key               |
| `HCMUS_SEMINAR_ECR_REPOSITORY`     | Secret Text | Name of your ECR repository         |
| `HCMUS_SEMINAR_ECS_CLUSTER`        | Secret Text | Name of the ECS cluster             |
| `HCMUS_SEMINAR_ECS_SERVICE`        | Secret Text | Name of the ECS service             |

These credentials will be used securely within the `environment {}` block of the `Jenkinsfile`.

---

## 🧪 3. Create a Pipeline Job

1. Go to **Jenkins Dashboard → New Item**
2. Select **Pipeline**, and name it (e.g., `hcmus-seminar-pipeline`)
3. Under **Pipeline → Definition**, choose `Pipeline script from SCM`
4. Set:
   - **SCM**: Git
   - **Repository URL**: your GitHub repo URL
   - **Credentials**: GitHub token (if private)
   - **Script Path**: `source_code/Jenkinsfile`
5. Click **Save**, then **Build Now**

---

## 🐳 4. What the Jenkinsfile Does

The Jenkins pipeline:

1. Authenticates to AWS and ECR
2. Builds a Docker image using the `Dockerfile`
3. Pushes the image to Amazon ECR with the current build number as the tag
4. Updates the ECS service with the new image version

---