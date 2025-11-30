# IaC Shopping Graph Analysis

## Terraform Modules Structure

This project uses a modular Terraform architecture to manage AWS infrastructure efficiently and reusably.

### 📁 Directory Structure

The project requires creating a `modules/` directory at the root, which will contain subdirectories organized by AWS resource type:

```
modules/
├── lambda/
├── s3/
├── neptune/
├── api-gateway/
└── sqs/
```

### 🎯 What are Terraform Modules?

Terraform modules are containers for multiple resources that are used together. They serve to **abstract how we implement a series of resources** in Terraform and allow us to **encapsulate the creation logic** of different AWS resources.

### ✨ Advantages of Using Modules

#### 1. **Code Reusability**
By having a module, we can create **multiple instances of a resource in the same way** without duplicating code. This is especially useful when we need the same type of resource for different use cases.

**Example:** If we need 3 Lambda functions with similar configurations, instead of writing the code three times, we simply call the module three times with different parameters.

#### 2. **Maintainability**
Configuration changes are made in a single place (the module), and automatically propagate to all instances that use it.

#### 3. **Consistency**
Ensures that all resources of the same type are created following the same best practices and configuration standards.

#### 4. **Abstraction**
Hides implementation complexity, allowing module users to focus on the specific parameters of their use case.

### 📦 Included Modules

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

### 🚀 Usage Example

Without modules (duplicated code):
```hcl
# First Lambda
resource "aws_lambda_function" "lambda1" {
  function_name = "function-1"
  runtime       = "python3.9"
  handler       = "index.handler"
  # ... many more configuration lines
}

# Second Lambda (duplicated code)
resource "aws_lambda_function" "lambda2" {
  function_name = "function-2"
  runtime       = "python3.9"
  handler       = "index.handler"
  # ... the same configuration lines
}
```

With modules (reusable code):
```hcl
module "lambda1" {
  source        = "./modules/lambda"
  function_name = "function-1"
  handler       = "index.handler"
}

module "lambda2" {
  source        = "./modules/lambda"
  function_name = "function-2"
  handler       = "index.handler"
}
```

### 📝 Next Steps

1. Create the `modules/` directory at the project root
2. Implement each module with its respective files:
   - `main.tf` - Resource definitions
   - `variables.tf` - Input variables
   - `outputs.tf` - Output values
   - `README.md` - Module documentation
3. Use the modules in the main Terraform configuration

---

**Note:** This modular structure facilitates project scalability and allows multiple developers to work more efficiently on different infrastructure components.
