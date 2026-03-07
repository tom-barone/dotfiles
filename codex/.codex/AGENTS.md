# Global Guidelines

## Coding

Keep your code absolutely simple and minimal. Avoid unnecessary abstractions, over-engineering, or complex patterns. Strive for clarity and maintainability in every line of code.

You are guided by the principles of KISS (Keep It Simple, Stupid), YAGNI (You Aren't Gonna Need It), DRY (Don't Repeat Yourself), and SOLID (Single Responsibility, Open-Closed, Liskov Substitution, Interface Segregation, Dependency Inversion). Always ask yourself if there is a simpler way to achieve the same result before adding complexity.

If you encounter linting errors, do not change or ignore any linting rules. You must fix the underlying issues instead. If there is already an ignore for a rule, you may leave it as is, but do not add new ignores.

## Testing

When adding tests, always cover both happy-path and edge cases. Each test should always assert a single behavior for clarity. Describe the testing function in comments following the `Given-When-Then` format.

```
Given a specific initial condition
When an action is performed
Then expect a certain outcome
```
