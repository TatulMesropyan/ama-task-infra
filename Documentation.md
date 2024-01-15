# Terraform Infrastructure Documentation

## Overview

This Terraform script is designed to provision and manage the infrastructure components required for the Bank Customer Statement Processor application on AWS. The infrastructure consists of the following major components:

- **API Gateway:** Manages and exposes HTTP endpoints for communication with the backend AWS Lambda function.

- **Lambda Function:** Hosts the backend logic for processing customer statement files.

- **S3 Bucket (Frontend):** Serves as a static website host for the frontend of the application.

## AWS Lambda

AWS Lambda is a serverless compute service that lets you run your code without provisioning or managing servers. You can execute code in response to various AWS events, such as changes to data in an S3 bucket or a new record in a DynamoDB table. In this project, the Lambda function acts as the backend for processing customer statement files.

## API Gateway

Amazon API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale. It allows you to create and deploy RESTful APIs, which can then be integrated with backend Lambda functions. API Gateway simplifies the process of handling HTTP requests, including the management of API versions, stages, and custom domains.

## S3 (Simple Storage Service)

Amazon S3 is an object storage service that offers industry-leading scalability, data availability, security, and performance. S3 is commonly used to store and retrieve any amount of data from anywhere on the web. In this project, S3 serves a dual purpose - it can be assumed to store and retrieve resources for Lambda, and it hosts the static frontend files of the Bank Customer Statement Processor application.

## AWS Lambda Integration with API Gateway

The API Gateway is configured to forward requests to the AWS Lambda function using the `AWS_PROXY` integration type. This integration allows for direct communication between the API Gateway and Lambda without the need for additional server-side logic. The Lambda function processes the incoming HTTP requests and returns responses to API Gateway, which then forwards them to the client.

## AWS Lambda and S3 Bucket

The Lambda function interacts with an S3 bucket to access necessary resources or store processed data. While the provided Terraform code doesn't explicitly create an S3 bucket for Lambda interaction, it assumes the existence of an S3 bucket that the Lambda function can use.

## S3 Bucket for Frontend

An S3 bucket is created to host the static frontend files for the Bank Customer Statement Processor application. The bucket is configured for website hosting, allowing users to access the frontend application via the specified S3 website endpoint.

## Terraform Backend Configuration

The Terraform script is configured to store its state remotely in an S3 bucket (`ama-test-task-terraform-state`) in the `eu-central-1` region.

## Prerequisites

Before executing this Terraform script, ensure that you have:

- AWS credentials properly configured.
- Terraform CLI installed on your machine.

## Execution

1. Clone the repository and navigate to the Terraform directory.
2. Run `terraform init` to initialize the Terraform configuration.
3. Run `terraform apply` to apply the infrastructure changes.

## Clean-Up

To destroy the provisioned infrastructure, run:

```bash
terraform destroy
```
