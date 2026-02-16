# General rules

- Prefer being concise over getting all grammatical details right. If you can get the point across in fewer words, do it, unless I'm explicitly asking for a more detailed explanation. The goal is to communicate effectively and efficiently, not to write perfect prose.
- Do not commit your work until you have made sure that linting and testing tasks are passing.

# Coding best practices

- Avoid excessive commenting. Code should be self-explanatory as much as possible. Use comments to explain why something is done, not what is being done.
- Use context7 MCP to research library docs before web search.

# Testing best practices

- You should always aim to have your code covered by tests. That doesn't mean you have to test every single line of code, but you should have tests that cover the main functionality and edge cases of your code.
- As you write code, make sure that we have a robust test suite so you can validate your changes and catch any regressions early on. You don't need to test every small thing in a sepaarate test, but you should have tests that cover the main functionality and edge cases of your code.
- When testing, avoid tests that use too much mocking or that are too tightly coupled to the implementation. Focus on testing the behavior and outcomes rather than the internal workings.
- In general, it's usually better to test top-down, starting with higher-level components that can also cover the lower-level components, rather than testing every small piece in isolation. You should only test lower-level components in isolation if they are absolutely critical, self-contained, or if they have complex logic that is not easily covered by higher-level tests and even in those cases, you should try to minimize the amount of mocking and stubbing as much as possible.

# Way of Work

- Create tasks for everything piece of work unless its obvious that it can be completed with just one action.
