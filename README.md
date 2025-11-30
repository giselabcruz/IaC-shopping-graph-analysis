# IaC Shopping Graph Analysis

## Estructura de Módulos de Terraform

Este proyecto utiliza una arquitectura modular de Terraform para gestionar la infraestructura de AWS de manera eficiente y reutilizable.

### 📁 Estructura de Directorios

El proyecto requiere la creación de un directorio `modules/` en la raíz, que contendrá subdirectorios organizados por tipo de recurso de AWS:

```
modules/
├── lambda/
├── s3/
├── neptune/
├── api-gateway/
└── sqs/
```

### 🎯 ¿Qué son los Módulos de Terraform?

Los módulos de Terraform son contenedores para múltiples recursos que se utilizan juntos. Sirven para **abstraernos de cómo implementar una serie de recursos** en Terraform y permiten **encapsular la lógica de creación** de distintos recursos de AWS.

### ✨ Ventajas de Usar Módulos

#### 1. **Reutilización de Código**
Al tener un módulo, podemos crear **varias instancias de un recurso de la misma manera** sin duplicar código. Esto es especialmente útil cuando necesitamos el mismo tipo de recurso para diferentes casuísticas.

**Ejemplo:** Si necesitamos 3 funciones Lambda con configuraciones similares, en lugar de escribir el código tres veces, simplemente llamamos al módulo tres veces con diferentes parámetros.

#### 2. **Mantenibilidad**
Los cambios en la configuración se realizan en un solo lugar (el módulo), y se propagan automáticamente a todas las instancias que lo utilizan.

#### 3. **Consistencia**
Garantiza que todos los recursos del mismo tipo se creen siguiendo las mismas mejores prácticas y estándares de configuración.

#### 4. **Abstracción**
Oculta la complejidad de la implementación, permitiendo a los usuarios del módulo enfocarse en los parámetros específicos de su caso de uso.

### 📦 Módulos Incluidos

#### **Lambda**
Módulo para la creación de funciones AWS Lambda, incluyendo configuración de runtime, variables de entorno, roles IAM y triggers.

#### **S3**
Módulo para buckets de S3 con configuraciones de versionado, encriptación, políticas de acceso y ciclo de vida.

#### **Neptune**
Módulo para bases de datos de grafos Amazon Neptune, incluyendo clústeres, instancias y configuraciones de seguridad.

#### **API Gateway**
Módulo para la creación de APIs REST o HTTP con AWS API Gateway, incluyendo recursos, métodos, integraciones y despliegues.

#### **SQS**
Módulo para colas de mensajes Amazon SQS, con configuraciones de dead-letter queues, políticas de retención y encriptación.

### 🚀 Ejemplo de Uso

Sin módulos (código duplicado):
```hcl
# Primera Lambda
resource "aws_lambda_function" "lambda1" {
  function_name = "function-1"
  runtime       = "python3.9"
  handler       = "index.handler"
  # ... muchas más líneas de configuración
}

# Segunda Lambda (código duplicado)
resource "aws_lambda_function" "lambda2" {
  function_name = "function-2"
  runtime       = "python3.9"
  handler       = "index.handler"
  # ... las mismas líneas de configuración
}
```

Con módulos (código reutilizable):
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

### 📝 Próximos Pasos

1. Crear el directorio `modules/` en la raíz del proyecto
2. Implementar cada módulo con sus respectivos archivos:
   - `main.tf` - Definición de recursos
   - `variables.tf` - Variables de entrada
   - `outputs.tf` - Valores de salida
   - `README.md` - Documentación del módulo
3. Utilizar los módulos en la configuración principal de Terraform

---

**Nota:** Esta estructura modular facilita la escalabilidad del proyecto y permite a múltiples desarrolladores trabajar de manera más eficiente en diferentes componentes de la infraestructura.
