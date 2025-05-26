# Conventional Commits

This guide outlines how we use Conventional Commits in our projects. Adhering to this specification makes commit messages more readable and enables automation for changelog generation and versioning.

We follow the [Conventional Commits specification v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

## Format

Each commit message consists of a **header**, an optional **body**, and an optional **footer**.

```bash
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Header

The header is mandatory and has a specific format: `<type>(<scope>): <subject>`

#### Type

Must be one of the following common types:

- **feat**: A new feature for the user.
- **fix**: A bug fix for the user.
- **docs**: Changes to documentation only.
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
- **refactor**: A code change that neither fixes a bug nor adds a feature.
- **perf**: A code change that improves performance.
- **test**: Adding missing tests or correcting existing tests.
- **chore**: Changes to the build process or auxiliary tools and libraries such as documentation generation. Does not modify `src` or `test` files.
- **build**: Changes that affect the build system or external dependencies (e.g., gulp, npm).
- **ci**: Changes to CI configuration files and scripts (e.g., Travis, Circle).
- **revert**: Reverts a previous commit.

#### Scope (Optional)

// TODO: enforce usage of webnodex domains

The scope provides contextual information. It's an optional part of the format and can be a noun describing a section of the codebase affected by the change (e.g., `feat(parser): add ability to parse arrays`).

#### Subject

The subject contains a succinct description of the change:

- Use the imperative, present tense: "change" not "changed" nor "changes".
- Don't capitalize the first letter (unless the scope dictates it, e.g., a component name).
- No dot (.) at the end.

### Body (Optional)

The body should be used to provide additional contextual information about the code changes. Use the imperative, present tense. Explain _what_ and _why_ vs. _how_.

### Footer (Optional)

Footers are used for two main purposes:

- **Breaking Changes**: Start with `BREAKING CHANGE:` (or `BREAKING-CHANGE:`) followed by a description of the change, justification, and migration notes.
- **Referencing Issues**: For example, `Closes #123`, `Fixes #456`.

## Tools

To help enforce and simplify writing conventional commit messages, we utilize:

- **Commitizen**: A command-line utility that prompts you to fill out required commit fields at commit time. This helps ensure your commits are formatted correctly.
- **Commitlint**: Lints commit messages to ensure they adhere to the conventional commit format. This is typically integrated into pre-commit hooks.

## Examples

```bash
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

```bash
fix(api): correct minor typos in docs

see the issue for details on the typos fixed

Reviewed-by: Z
Refs #133
```

```bash
chore(deps): update dependency_x to v1.2.3
```
