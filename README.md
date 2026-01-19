# Karate Framework Project

## 📋 Overview
This is an API testing automation project using the **Karate Framework**. The project is designed to test various REST APIs using Behavior-Driven Development (BDD) approach with Gherkin syntax.

## 🛠️ Technology Stack
- **Java**: Version 21
- **Karate Framework**: Version 1.4.1
- **Build Tool**: Maven
- **Test Framework**: JUnit 5

## 📁 Project Structure
```
Karate4thGroup2025/
├── pom.xml                          # Maven configuration file
├── README.md                        # Project documentation
├── src/
│   ├── main/
│   │   ├── java/                    # Main Java source files
│   │   └── resources/               # Main resources
│   └── test/
│       ├── java/
│       │   ├── DogsAPITests/        # Test runners for Dogs API
│       │   │   └── DogsTests.java
│       │   ├── NdosiApITests/       # Test runners for Ndosi API (placeholder)
│       │   └── WeatherAPITests/     # Test runners for Weather API (placeholder)
│       └── resources/
│           └── Features/            # Karate feature files
│               └── Dogs.feature
└── target/
    ├── karate-reports/              # HTML test reports
    └── test-classes/                # Compiled test classes
```

## 🚀 Getting Started

### Prerequisites
- Java Development Kit (JDK) 21 or higher
- Maven 3.6 or higher
- IDE (IntelliJ IDEA, Eclipse, or VS Code recommended)

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd Karate4thGroup2025
   ```

2. Install dependencies:
   ```bash
   mvn clean install
   ```

## ▶️ Running Tests

### Run All Tests
```bash
mvn test
```

### Run Specific Test Class
```bash
mvn test -Dtest=DogsTests
```

### Run Specific Feature File
```bash
mvn test -Dkarate.options="classpath:Features/Dogs.feature"
```

### Run Tests with Tags
```bash
mvn test -Dkarate.options="--tags @smoke"
```

## 📊 Test Reports
After running tests, HTML reports are generated in:
```
target/karate-reports/karate-summary.html
```

Open the report in your browser:
```bash
open target/karate-reports/karate-summary.html
```

## 📝 Current Test Suites

### Dogs API Tests
- **Endpoint**: https://dog.ceo/api/breeds/list/all
- **Test Runner**: `DogsTests.java`
- **Feature File**: `Dogs.feature`
- **Scenarios**:
  - Get list of all dogs (validates 200 OK response)

### Upcoming Test Suites
- **NdosiAPI Tests**: Placeholder for future API tests
- **Weather API Tests**: Placeholder for future weather API tests

## 🔧 Adding New Tests

### 1. Create a Feature File
Create a new `.feature` file in `src/test/resources/Features/`:
```gherkin
Feature: Sample API Test

  Scenario: Test endpoint
    Given url 'https://api.example.com/endpoint'
    When method GET
    Then status 200
    And match response.status == 'success'
```

### 2. Create a Test Runner
Create a new Java test runner in `src/test/java/`:
```java
package YourAPITests;

import com.intuit.karate.junit5.Karate;

public class YourTests {
    @Karate.Test
    Karate testAPI() {
        return Karate.run("classpath:Features/YourFeature.feature");
    }
}
```

## 📚 Karate Framework Key Features
- Simple and readable BDD syntax
- Built-in support for API testing (REST, SOAP, GraphQL)
- Parallel test execution
- Comprehensive HTML reports
- Data-driven testing support
- Mock server capabilities
- UI automation (via Karate UI)

## 🧪 Example Karate Syntax

### Basic GET Request
```gherkin
Given url 'https://api.example.com/users'
When method GET
Then status 200
And match response contains { id: '#number', name: '#string' }
```

### POST Request with Body
```gherkin
Given url 'https://api.example.com/users'
And request { name: 'John', email: 'john@example.com' }
When method POST
Then status 201
```

### Using Variables
```gherkin
* def baseUrl = 'https://api.example.com'
* def userId = 123

Given url baseUrl + '/users/' + userId
When method GET
Then status 200
```

## 🐛 Troubleshooting

### Common Issues
1. **Maven dependencies not downloading**: 
   ```bash
   mvn dependency:purge-local-repository
   mvn clean install
   ```

2. **Java version mismatch**: 
   - Ensure JDK 21 is installed and set in your PATH

3. **Tests not found**:
   - Verify feature files are in `src/test/resources/Features/`
   - Check test runner paths match feature file locations

## 📖 Resources
- [Karate Official Documentation](https://karatelabs.github.io/karate/)
- [Karate GitHub Repository](https://github.com/karatelabs/karate)
- [Maven Documentation](https://maven.apache.org/guides/)

## 👥 Contributors
Group 2025

## 📄 License
This project is for educational/testing purposes.

---
**Last Updated**: January 2026
