# Codebase Architecture Design Conventions

This document outlines the high-level folder structure of the `@webnodex/ecosystem` monorepo. Our goal is to organize projects into domain-specific, root-level areas, providing a "sub-monorepo" feel for each major concern of the Webnode ecosystem. This approach enhances clarity, maintainability, and scalability.

## Top-Level Domain Folders

The root of the workspace is organized into the following primary directories:

### `sdk/`

This domain houses the core Software Development Kits (SDKs) that form the backbone of the Webnode platform.
_(Example: `@ecosystem/core-sdk-webnode`)_

### `devkit/`

This domain is dedicated to developer experience tools, including scaffolding utilities, Nx plugins, and bootstrapping toolkits.

### `standards/`

This domain contains shareable configuration packages that enforce coding standards and conventions across the monorepo.

### `docs/`

**(This directory)** This domain contains internal, project-level documentation written in Markdown. It includes architecture decision records (ADRs), design documents, convention guides, and explanations like this `repository-structure.md` file. These documents support the development team and maintain a shared understanding of the ecosystem's design and evolution.

### `tools/`

This directory holds workspace-specific tooling and local Nx plugin generator and executors, configurations that are not meant to be published as packages but are essential for the development workflow within this monorepo.

## Nx Projects Organization (Apps and Libs)

While the top-level folders define broad domains, individual Nx projects (applications and libraries) are typically nested within these domains.

- **Applications (`apps/`)**: If you have standalone applications that don't fit neatly into the specialized root domains (e.g., a demo application), they might reside in a more traditional `apps/` directory at the root, or within a relevant domain folder if appropriate (e.g., `apps/docs/webnode-service` is an app within the `docs` domain).
- **Libraries (`libs/`)**: Similarly, general-purpose libraries consumed bt the applicastions. They are scoped by their domain (e.g. `docs`) followed by their `{name}-{feature}`
- - A UI component library for the `apps/docs/webnode-service` might be `libs/docs/webnode/ui-components/`.
  - A utility library specifically for the `devkit/nx-plugin` might be `devkit/nx-plugin-utils/`.

When generating new Nx projects, use the `{workspaceRoot}/libs/@{domain}/{name}-{feature}` convention to define its domain and scope.

_This document reflects the current standard for organizing the Webnode ecosystem monorepo._
