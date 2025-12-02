# IaC Shopping Graph Analysis

## Terraform Modules Structure

This project uses a modular Terraform architecture to manage AWS infrastructure efficiently and reusably.

### Directory Structure

The project follows a structured organization with modules and resource-specific folders:

```
.
├── .gitignore
├── README.md
├── modules/
│   ├── lambda/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tf
│   ├── s3/
│   ├── neptune/
│   ├── api-gateway/
│   └── sqs/
└── lambda/
    ├── main.tf
    └── .terraform.lock.hcl
```

**Structure explanation:**
- **`modules/`**: Contains reusable module definitions
  - **`modules/lambda/`**: Lambda module with complete implementation
    - `main.tf`: Defines the Lambda function resource and IAM execution role
    - `variables.tf`: Input variables for the module (function_name, runtime, region, env, tags)
    - `terraform.tf`: Terraform version and AWS provider requirements
  - Other modules (s3, neptune, api-gateway, sqs) are placeholders for future implementation
- **`lambda/`**: Contains the actual Lambda function implementation that uses the lambda module
  - `main.tf`: Instantiates the lambda module with specific configuration
  - `.terraform.lock.hcl`: Locks provider versions for reproducibility
- **`.gitignore`**: Specifies files to ignore in version control
- **`README.md`**: This documentation file

> [!IMPORTANT]
> The separation between `modules/` and resource folders is crucial. Modules contain **reusable templates**, while resource folders contain **specific implementations** that consume those modules.

### What are Terraform Modules?

Terraform modules are containers for multiple resources that are used together. They serve to **abstract how we implement a series of resources** in Terraform and allow us to **encapsulate the creation logic** of different AWS resources.

> [!NOTE]
> Think of modules as reusable blueprints. Just like a blueprint can be used to build multiple houses, a Terraform module can be used to create multiple instances of the same infrastructure pattern.

### Advantages of Using Modules

#### 1. **Code Reusability**
By having a module, we can create **multiple instances of a resource in the same way** without duplicating code. This is especially useful when we need the same type of resource for different use cases.

> [!TIP]
> **Example:** If we need 3 Lambda functions with similar configurations, instead of writing the code three times, we simply call the module three times with different parameters. This follows the DRY (Don't Repeat Yourself) principle.

#### 2. **Maintainability**
Configuration changes are made in a single place (the module), and automatically propagate to all instances that use it.

#### 3. **Consistency**
Ensures that all resources of the same type are created following the same best practices and configuration standards.

#### 4. **Abstraction**
Hides implementation complexity, allowing module users to focus on the specific parameters of their use case.

### Included Modules

#### **Lambda**
Module for creating AWS Lambda functions, including runtime configuration, environment variables, IAM roles, and triggers.

#### **S3**
Module for S3 buckets with versioning, encryption, access policies, and lifecycle configurations.

#### **Neptune**
Module for Amazon Neptune graph databases, including clusters, instances, and security configurations.

#### **API Gateway**
Module for creating REST or HTTP APIs with AWS API Gateway, including resources, methods, integrations, and deployments.

#### **SQS**
Module for Amazon SQS message queues, with dead-letter queue configurations, retention policies, and encryption.

### VPC (Virtual Private Cloud)

All resources for this project will be deployed within a **VPC (Virtual Private Cloud)** to ensure network isolation and security.

> [!NOTE]
> AWS automatically generates a **default VPC** in each region, which can be used for initial deployments and testing.

> [!WARNING]
> For production environments, it's **strongly recommended** to create a custom VPC with specific network configurations tailored to the project's security and connectivity requirements. The default VPC may not meet your security standards.

## 🐳 Docker Compose - Local Development with LocalStack

This project includes a Docker Compose configuration that uses **LocalStack** to emulate AWS services locally, enabling development and testing without connecting to real AWS infrastructure.

### Architecture

![Architecture Diagram](Web App Reference Architecture-2.png)

### Available Services

- **S3**: Object storage for data and results
- **Lambda**: Serverless function execution
- **IAM**: Role and permission management (simplified for local development)

### Quick Start

```bash
# Start LocalStack services
docker-compose up -d

# View logs
docker-compose logs -f localstack

# Stop services
docker-compose down
```

### What Gets Created Automatically

When you start the Docker Compose setup, the initialization script automatically creates:

1. **S3 Buckets**:
   - `mi-bucket-datos` - For input data
   - `mi-bucket-resultados` - For processed results

2. **Lambda Function**:
   - `procesador-s3` - Example function that reads from S3, processes data, and writes results back

### Example Usage

```bash
# Install awslocal (AWS CLI wrapper for LocalStack)
pip install awscli-local

# Upload a file to S3
echo '{"producto": "laptop", "precio": 999}' > datos.json
awslocal s3 cp datos.json s3://mi-bucket-datos/

# Invoke Lambda function to process the file
awslocal lambda invoke \
  --function-name procesador-s3 \
  --payload '{"bucket_origen": "mi-bucket-datos", "key": "datos.json"}' \
  output.json

# Download processed result
awslocal s3 cp s3://mi-bucket-resultados/procesado/datos.json ./resultado.json
```

> [!TIP]
> For detailed documentation on using the Docker Compose setup, including troubleshooting and advanced examples, see [DOCKER_SETUP.md](file:///Users/giselabelmontecruz/IaC-shopping-graph-analysis/DOCKER_SETUP.md).


> [!TIP]
> This modular structure facilitates project scalability and allows multiple developers to work more efficiently on different infrastructure components. Each team member can work on different resource folders without conflicts.
