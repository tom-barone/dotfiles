# Development Guidelines for Claude

## Core Philosophy

**TEST-DRIVEN DEVELOPMENT IS NON-NEGOTIABLE.** Every single line of production
code must be written in response to a failing test. No exceptions. This is not a
suggestion or a preference - it is the fundamental practice that enables all
other principles in this document.

I follow Test-Driven Development (TDD) with a strong emphasis on behavior-driven
testing and functional programming principles. All work should be done in small,
incremental changes that maintain a working state throughout development.

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

- **No "unit tests"** - this term is not helpful. Tests should verify expected
  behavior, treating implementation as a black box
- Test through the public API exclusively - internals should be invisible to
  tests
- No 1:1 mapping between test files and implementation files
- Tests that examine internal implementation details are wasteful and should be
  avoided
- **Coverage targets**: 100% coverage should be expected at all times, but these
  tests must ALWAYS be based on business behaviour, not implementation details
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
- Avoid heavy FP abstractions (no need for complex monads or pipe/compose
  patterns) unless there is a clear advantage to using them
- Use collection methods (`map`, `filter`, `reduce`) over imperative loops, or
  best practices for the specific language

#### Examples of Functional Patterns

```
// Good - Pure function with immutable updates
function applyDiscount(order, discountPercent) {
  return {
    ...order,
    items: order.items.map(item => ({
      ...item,
      price: item.price * (1 - discountPercent / 100)
    })),
    totalPrice: order.items.reduce(
      (sum, item) => sum + item.price * (1 - discountPercent / 100),
      0
    )
  }
}

// Good - Composition over complex logic
function processOrder(order) {
  return pipe(
    order,
    validateOrder,
    applyPromotions,
    calculateTax,
    assignWarehouse
  )
}

// When heavy FP abstractions ARE appropriate:
// - Complex async flows that benefit from Result/Either types
// - Error handling chains that benefit from monadic composition
// Example with Result type for complex error handling:
function chainPaymentOperations(payment) {
  return pipe(
    validatePayment(payment),
    chain(authorizePayment),
    chain(capturePayment),
    map(generateReceipt)
  )
}
```

### Code Structure

- **No nested if/else statements** - use early returns, guard clauses, or
  composition
- **Avoid deep nesting** in general (max 2 levels)
- Keep functions small and focused on a single responsibility
- Prefer flat, readable code over clever abstractions

### No Comments in Code

Code should be self-documenting through clear naming and structure. Comments
indicate that the code itself is not clear enough.

```
// Avoid: Comments explaining what the code does
function calculateDiscount(price, customer) {
  // Check if customer is premium
  if (customer.tier === "premium") {
    // Apply 20% discount for premium customers
    return price * 0.8
  }
  // Regular customers get 10% discount
  return price * 0.9
}

// Good: Self-documenting code with clear names
const PREMIUM_DISCOUNT_MULTIPLIER = 0.8
const STANDARD_DISCOUNT_MULTIPLIER = 0.9

function isPremiumCustomer(customer) {
  return customer.tier === "premium"
}

function calculateDiscount(price, customer) {
  const discountMultiplier = isPremiumCustomer(customer)
    ? PREMIUM_DISCOUNT_MULTIPLIER
    : STANDARD_DISCOUNT_MULTIPLIER

  return price * discountMultiplier
}

// Avoid: Complex logic with comments
function processPayment(payment) {
  // First validate the payment
  if (!validatePayment(payment)) {
    throw new Error("Invalid payment")
  }

  // Check if we need to apply 3D secure
  if (payment.amount > 100 && payment.card.type === "credit") {
    // Apply 3D secure for credit cards over £100
    const securePayment = apply3DSecure(payment)
    // Process the secure payment
    return executePayment(securePayment)
  }

  // Process the payment
  return executePayment(payment)
}

// Good: Extract to well-named functions
function requires3DSecure(payment) {
  const SECURE_PAYMENT_THRESHOLD = 100
  return (
    payment.amount > SECURE_PAYMENT_THRESHOLD &&
    payment.card.type === "credit"
  )
}

function processPayment(payment) {
  if (!validatePayment(payment)) {
    throw new PaymentValidationError("Invalid payment")
  }

  const securedPayment = requires3DSecure(payment)
    ? apply3DSecure(payment)
    : payment

  return executePayment(securedPayment)
}
```

**Exception**: documentation comments for public APIs are acceptable when
generating documentation, but the code should still be self-explanatory without
them.

## Development Workflow

### TDD Process - THE FUNDAMENTAL PRACTICE

**CRITICAL**: TDD is not optional. Every feature, every bug fix, every change
MUST follow this process:

Follow Red-Green-Refactor strictly:

1. **Red**: Write a failing test for the desired behavior. NO PRODUCTION CODE
   until you have a failing test.
2. **Green**: Write the MINIMUM code to make the test pass. Resist the urge to
   write more than needed.
3. **Refactor**: Assess the code for improvement opportunities. If refactoring
   would add value, clean up the code while keeping tests green. If the code is
   already clean and expressive, move on.

**Common TDD Violations to Avoid:**

- Writing production code without a failing test first
- Writing multiple tests before making the first one pass
- Writing more production code than needed to pass the current test
- Skipping the refactor assessment step when code could be improved
- Adding functionality "while you're there" without a test driving it

**Remember**: If you're typing production code and there isn't a failing test
demanding that code, you're not doing TDD.

### Refactoring - The Critical Third Step

Evaluating refactoring opportunities is not optional - it's the third step in
the TDD cycle. After achieving a green state and committing your work, you MUST
assess whether the code can be improved. However, only refactor if there's clear
value - if the code is already clean and expresses intent well, move on to the
next test.

#### What is Refactoring?

Refactoring means changing the internal structure of code without changing its
external behavior. The public API remains unchanged, all tests continue to pass,
but the code becomes cleaner, more maintainable, or more efficient. Remember:
only refactor when it genuinely improves the code - not all code needs
refactoring.

#### When to Refactor

- **Always assess after green**: Once tests pass, before moving to the next
  test, evaluate if refactoring would add value
- **When you see duplication**: But understand what duplication really means
  (see DRY below)
- **When names could be clearer**: Variable names, function names, or type names
  that don't clearly express intent
- **When structure could be simpler**: Complex conditional logic, deeply nested
  code, or long functions
- **When patterns emerge**: After implementing several similar features, useful
  abstractions may become apparent

**Remember**: Not all code needs refactoring. If the code is already clean,
expressive, and well-structured, commit and move on. Refactoring should improve
the code - don't change things just for the sake of change.

#### Refactoring Guidelines

##### 1. Commit Before Refactoring

Always commit your working code before starting any refactoring. This gives you
a safe point to return to:

```bash
git add .
git commit -m "Add payment validation"
# Now safe to refactor
```

**Questions to ask before abstracting:**

- Do these code blocks represent the same concept or different concepts that
  happen to look similar?
- If the business rules for one change, should the others change too?
- Would a developer reading this abstraction understand why these things are
  grouped together?
- Am I abstracting based on what the code IS (structure) or what it MEANS
  (semantics)?

**Remember**: It's much easier to create an abstraction later when the semantic
relationship becomes clear than to undo a bad abstraction that couples unrelated
concepts.

##### 3. Understanding DRY - It's About Knowledge, Not Code

DRY (Don't Repeat Yourself) is about not duplicating **knowledge** in the
system, not about eliminating all code that looks similar.

```
// This is NOT a DRY violation - different knowledge despite similar code
function validateUserAge(age) {
  return age >= 18 && age <= 100
}

function validateProductRating(rating) {
  return rating >= 1 && rating <= 5
}

function validateYearsOfExperience(years) {
  return years >= 0 && years <= 50
}

// These functions have similar structure (checking numeric ranges), but they
// represent completely different business rules:
// - User age has legal requirements (18+) and practical limits (100)
// - Product ratings follow a 1-5 star system
// - Years of experience starts at 0 with a reasonable upper bound
// Abstracting them would couple unrelated business concepts and make future
// changes harder. What if ratings change to 1-10? What if legal age changes?

// Another example of code that looks similar but represents different knowledge:
function formatUserDisplayName(user) {
  return `${user.firstName} ${user.lastName}`.trim()
}

function formatAddressLine(address) {
  return `${address.street} ${address.number}`.trim()
}

function formatCreditCardLabel(card) {
  return `${card.type} ${card.lastFourDigits}`.trim()
}

// Despite the pattern "combine two strings with space and trim", these represent
// different domain concepts with different future evolution paths

// This IS a DRY violation - same knowledge in multiple places
class Order {
  calculateTotal() {
    const itemsTotal = this.items.reduce((sum, item) => sum + item.price, 0)
    const shippingCost = itemsTotal > 50 ? 0 : 5.99 // Knowledge duplicated!
    return itemsTotal + shippingCost
  }
}

class OrderSummary {
  getShippingCost(itemsTotal) {
    return itemsTotal > 50 ? 0 : 5.99 // Same knowledge!
  }
}

class ShippingCalculator {
  calculate(orderAmount) {
    if (orderAmount > 50) return 0 // Same knowledge again!
    return 5.99
  }
}

// Refactored - knowledge in one place
const FREE_SHIPPING_THRESHOLD = 50
const STANDARD_SHIPPING_COST = 5.99

function calculateShippingCost(itemsTotal) {
  return itemsTotal > FREE_SHIPPING_THRESHOLD ? 0 : STANDARD_SHIPPING_COST
}

// Now all classes use the single source of truth
class Order {
  calculateTotal() {
    const itemsTotal = this.items.reduce((sum, item) => sum + item.price, 0)
    return itemsTotal + calculateShippingCost(itemsTotal)
  }
}
```

##### 4. Maintain External APIs During Refactoring

Refactoring must never break existing consumers of your code:

```
// Original implementation
function processPayment(payment) {
  // Complex logic all in one function
  if (payment.amount <= 0) {
    throw new Error("Invalid amount")
  }

  if (payment.amount > 10000) {
    throw new Error("Amount too large")
  }

  // ... 50 more lines of validation and processing

  return result
}

// Refactored - external API unchanged, internals improved
function processPayment(payment) {
  validatePaymentAmount(payment.amount)
  validatePaymentMethod(payment.method)

  const authorizedPayment = authorizePayment(payment)
  const capturedPayment = capturePayment(authorizedPayment)

  return generateReceipt(capturedPayment)
}

// New internal functions - not exported
function validatePaymentAmount(amount) {
  if (amount <= 0) {
    throw new Error("Invalid amount")
  }

  if (amount > 10000) {
    throw new Error("Amount too large")
  }
}

// Tests continue to pass without modification because external API unchanged
```

##### 5. Verify and Commit After Refactoring

**CRITICAL**: After every refactoring:

1. Run all tests - they must pass without modification
2. Run static analysis (linting, type checking when available) - must pass
3. Commit the refactoring separately from feature changes

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

1. **ALWAYS FOLLOW TDD** - No production code without a failing test. This is
   not negotiable.
2. **Think deeply** before making any edits
3. **Understand the full context** of the code and requirements
4. **Ask clarifying questions** when requirements are ambiguous
5. **Think from first principles** - don't make assumptions
6. **Assess refactoring after every green** - Look for opportunities to improve
   code structure, but only refactor if it adds value
7. **Keep project docs current** - update them whenever you introduce meaningful
   changes

### Code Changes

When suggesting or making changes:

- **Start with a failing test** - always. No exceptions.
- After making tests pass, always assess refactoring opportunities (but only
  refactor if it adds value)
- After refactoring, verify all tests and static analysis pass, then commit
- Respect the existing patterns and conventions
- Maintain test coverage for all behavior changes
- Keep changes small and incremental
- Provide rationale for significant design decisions

**If you find yourself writing production code without a failing test, STOP
immediately and write the test first.**

### Communication

- Be explicit about trade-offs in different approaches
- Explain the reasoning behind significant design decisions
- Flag any deviations from these guidelines with justification
- Suggest improvements that align with these principles
- When unsure, ask for clarification rather than assuming

## Common Patterns to Avoid

### Anti-patterns

```
// Avoid: Mutation
function addItem(items, newItem) {
  items.push(newItem) // Mutates array
  return items
}

// Prefer: Immutable update
function addItem(items, newItem) {
  return [...items, newItem]
}

// Avoid: Nested conditionals
if (user) {
  if (user.isActive) {
    if (user.hasPermission) {
      // do something
    }
  }
}

// Prefer: Early returns
if (!user || !user.isActive || !user.hasPermission) {
  return
}
// do something

// Avoid: Large functions
function processOrder(order) {
  // 100+ lines of code
}

// Prefer: Composed small functions
function processOrder(order) {
  const validatedOrder = validateOrder(order)
  const pricedOrder = calculatePricing(validatedOrder)
  const finalOrder = applyDiscounts(pricedOrder)
  return submitOrder(finalOrder)
}
```

## Summary

The key is to write clean, testable, functional code that evolves through small,
safe increments. Every change should be driven by a test that describes the
desired behavior, and the implementation should be the simplest thing that makes
that test pass. When in doubt, favor simplicity and readability over cleverness.

## Documentation Philosophy

Follow the documentation style of the project. Documentation should be as clear
and concise as possible.

When writing Markdown documentation:

- Avoid excessive headers and subheaders.
- Avoid nested bullet lists.
- Avoid unnecessary formatting (bold, italics) unless it adds clarity.
- Always end bullet points with a period.
