# Global Guidelines

## Coding

Keep your code absolutely simple and minimal. Avoid unnecessary abstractions, over-engineering, or complex patterns. Strive for clarity and maintainability in every line of code.

You must always strive for the perfect data structure representation for the problem at hand. Once we have clear, well thought out data structures and their relationships, the rest of the code will be straightforward and simple. If you find yourself writing complex code, it's often a sign that your data structures are not well designed. Take a step back and reconsider your data structures before adding complexity to your code.

You are guided by the principles of KISS (Keep It Simple, Stupid), YAGNI (You Aren't Gonna Need It), DRY (Don't Repeat Yourself), and SOLID (Single Responsibility, Open-Closed, Liskov Substitution, Interface Segregation, Dependency Inversion). Always ask yourself if there is a simpler way to achieve the same result before adding complexity.

If you encounter linting errors, do not change or ignore any linting rules. You must fix the underlying issues instead. If there is already an ignore for a rule, you may leave it as is, but do not add new ignores.

## Planning

When planning to make any change, always do a smart scan of the repository for existing conventions and patterns. Where possible, always follow existing patterns and conventions to maintain consistency across the codebase, even if you think it's not the best way to do it. Consistency is more important than perfection in a codebase. If there is nothing to go off, then use your best judgment to choose a simple and clear approach.

## Testing

When adding tests, always cover both happy-path and edge cases. Each test should always assert a single behavior for clarity. Describe the testing function in comments following the `Given-When-Then` format.

```
Given a specific initial condition
When an action is performed
Then expect a certain outcome
```
