# Development Guidelines for Claude

## Core Philosophy

**TEST-DRIVEN DEVELOPMENT IS NON-NEGOTIABLE.** Every single line of production code must be written in response to a failing test. No exceptions. This is not a suggestion or a preference - it is the fundamental practice that enables all other principles in this document.

I follow Test-Driven Development (TDD) with a strong emphasis on behavior-driven testing and functional programming principles. All work should be done in small, incremental changes that maintain a working state throughout development.

## Quick Reference

**Key Principles:**

- Write tests first (TDD).
- Test behavior, not implementation.
- Use strong typing when available (avoid dynamic/weak typing).
- Immutable data only.
- Small, pure functions.
- Use strict compiler/interpreter settings when available.
- Use real schemas/types in tests, never redefine them.

## Testing Principles

### Behavior-Driven Testing

- **No "unit tests"** - this term is not helpful. Tests should verify expected behavior, treating implementation as a black box
- Test through the public API exclusively - internals should be invisible to tests
- No 1:1 mapping between test files and implementation files
- Tests that examine internal implementation details are wasteful and should be avoided
- **Coverage targets**: 100% coverage should be expected at all times, but these tests must ALWAYS be based on business behaviour, not implementation details
- Tests must document expected business behaviour
- All tests must follow the "Arrange-Act-Assert" pattern:
  - **Arrange**: Set up the test environment
  - **Act**: Execute the code under test
  - **Assert**: Verify the expected outcome

## Code Style

### Functional Programming

I follow a "functional light" approach:

- **No data mutation** - work with immutable data structures
- **Pure functions** wherever possible
- **Composition** as the primary mechanism for code reuse
- Avoid heavy FP abstractions (no need for complex monads or pipe/compose patterns) unless there is a clear advantage to using them
- Use collection methods (`map`, `filter`, `reduce`) over imperative loops, or best practices for the specific language

### Code Structure

- **No nested if/else statements** - use early returns, guard clauses, or composition
- **Avoid deep nesting** in general (max 2 levels)
- Keep functions small and focused on a single responsibility
- Prefer flat, readable code over clever abstractions

## Development Workflow

### TDD Process - THE FUNDAMENTAL PRACTICE

**CRITICAL**: TDD is not optional. Every feature, every bug fix, every change MUST follow this process:

Follow Red-Green-Refactor strictly:

1. **Red**: Write a failing test for the desired behavior. NO PRODUCTION CODE until you have a failing test.
2. **Green**: Write the MINIMUM code to make the test pass. Resist the urge to write more than needed.
3. **Refactor**: Assess the code for improvement opportunities. If refactoring would add value, clean up the code while keeping tests green. If the code is already clean and expressive, move on.

**Common TDD Violations to Avoid:**

- Writing production code without a failing test first
- Writing multiple tests before making the first one pass
- Writing more production code than needed to pass the current test
- Skipping the refactor assessment step when code could be improved
- Adding functionality "while you're there" without a test driving it

**Remember**: If you're typing production code and there isn't a failing test demanding that code, you're not doing TDD.

### Refactoring - The Critical Third Step

Evaluating refactoring opportunities is not optional - it's the third step in the TDD cycle. After achieving a green state and committing your work, you MUST assess whether the code can be improved. However, only refactor if there's clear value - if the code is already clean and expresses intent well, move on to the next test.

#### What is Refactoring?

Refactoring means changing the internal structure of code without changing its external behavior. The public API remains unchanged, all tests continue to pass, but the code becomes cleaner, more maintainable, or more efficient. Remember: only refactor when it genuinely improves the code - not all code needs refactoring.

#### When to Refactor

- **Always assess after green**: Once tests pass, before moving to the next test, evaluate if refactoring would add value
- **When you see duplication**: But understand what duplication really means (see DRY below)
- **When names could be clearer**: Variable names, function names, or type names that don't clearly express intent
- **When structure could be simpler**: Complex conditional logic, deeply nested code, or long functions
- **When patterns emerge**: After implementing several similar features, useful abstractions may become apparent

**Remember**: Not all code needs refactoring. If the code is already clean, expressive, and well-structured, commit and move on. Refactoring should improve the code - don't change things just for the sake of change.

#### Refactoring Guidelines

**Questions to ask before abstracting:**

- Do these code blocks represent the same concept or different concepts that happen to look similar?
- If the business rules for one change, should the others change too?
- Would a developer reading this abstraction understand why these things are grouped together?
- Am I abstracting based on what the code IS (structure) or what it MEANS (semantics)?

**Remember**: It's much easier to create an abstraction later when the semantic relationship becomes clear than to undo a bad abstraction that couples unrelated concepts.

Understanding DRY - It's About Knowledge, Not Code

DRY (Don't Repeat Yourself) is about not duplicating **knowledge** in the system, not about eliminating all code that looks similar.

**CRITICAL**: After every refactoring:

1. Run all tests - they must pass without modification
2. Run static analysis (linting, type checking when available) - must pass

#### Refactoring Checklist

Before considering refactoring complete, verify:

- [ ] The refactoring actually improves the code (if not, don't refactor)
- [ ] All tests still pass without modification
- [ ] All static analysis tools pass (linting, type checking when available)
- [ ] No new public APIs were added (only internal ones)
- [ ] Code is more readable than before
- [ ] Any duplication removed was duplication of knowledge, not just code
- [ ] No speculative abstractions were created
- [ ] The refactoring is committed separately from feature changes

## Working with Claude

### Expectations

When working with my code:

1. **ALWAYS FOLLOW TDD** - No production code without a failing test. This is not negotiable.
2. **Think deeply** before making any edits
3. **Understand the full context** of the code and requirements
4. **Ask clarifying questions** when requirements are ambiguous
5. **Think from first principles** - don't make assumptions
6. **Assess refactoring after every green** - Look for opportunities to improve code structure, but only refactor if it adds value
7. **Keep project docs current** - update them whenever you introduce meaningful changes

### Code Changes

When suggesting or making changes:

- **Start with a failing test** - always. No exceptions.
- After making tests pass, always assess refactoring opportunities (but only refactor if it adds value)
- After refactoring, verify all tests and static analysis pass, then commit
- Respect the existing patterns and conventions
- Maintain test coverage for all behavior changes
- Keep changes small and incremental
- Provide rationale for significant design decisions

**If you find yourself writing production code without a failing test, STOP immediately and write the test first.**

### Communication

- Be explicit about trade-offs in different approaches
- Explain the reasoning behind significant design decisions
- Flag any deviations from these guidelines with justification
- Suggest improvements that align with these principles
- When unsure, ask for clarification rather than assuming

## Summary

The key is to write clean, testable, functional code that evolves through small, safe increments. Every change should be driven by a test that describes the desired behavior, and the implementation should be the simplest thing that makes that test pass. When in doubt, favor simplicity and readability over cleverness.

## Documentation Philosophy

Follow the documentation style of the project. Documentation should be as clear and concise as possible.

When writing Markdown documentation:

- Avoid excessive headers and subheaders.
- Avoid nested bullet lists.
- Avoid unnecessary formatting (bold, italics) unless it adds clarity.
- Always end bullet points with a period.
