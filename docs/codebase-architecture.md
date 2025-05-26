# Codebase Architecture & Package Domains

This document outlines the primary package domains within our monorepo. These domains are explicitly defined in the `pnpm-workspace.yaml` file, which guides `pnpm` in discovering and managing workspace packages. Adhering to this structure ensures consistency and clarity across the ecosystem.

## Package Domains from `pnpm-workspace.yaml`

The `pnpm-workspace.yaml` file specifies the following glob patterns for package discovery:

```yaml
packages:
  - apps/*
  - devkits/*
  - docs/*
  - libs/*
  - sdk/*
  - toolkits/*
  - tools/*
```

This configuration translates to the following top-level domains where our packages are organized:

1. **`apps/`**

   - **Purpose**: Houses standalone applications. These are typically user-facing applications, backend services, or demonstration projects.
   - _Example Nx projects: `apps/website`, `apps/api-service`_

2. **`devkits/`**

   - **Purpose**: Contains developer toolkits and extensions designed to enhance the development experience within this monorepo. This can include Nx plugins, code generators, or utility scripts for developers.
   - _Example Nx projects: `devkits/nx-ecosystem-plugin`, `devkits/code-scaffolder`_

3. **`docs/`**

   - **Purpose**: Dedicated to documentation-related packages and source files. This includes the source for any public-facing documentation websites, as well as internal project documentation written in Markdown (like this file).
   - _Example Nx projects: `docs/public-docs-site` (an app), `docs/internal-guides` (Markdown files)_

4. **`libs/`**

   - **Purpose**: A general-purpose location for shared libraries. These libraries can be consumed by applications, SDKs, or other libraries within the monorepo. This domain is suitable for UI component libraries, utility functions, or any reusable code that doesn't fit a more specific domain like `sdk/`.
   - _Example Nx projects: `libs/shared/ui-components`, `libs/api-service/utils`_

5. **`sdk/`**

   - **Purpose**: Contains Software Development Kits (SDKs). These packages provide well-defined APIs and functionalities for interacting with core parts of the WebNode ecosystem.
   - _Example Nx projects: `sdk/webnode`_

6. **`toolkits/`**

   - **Purpose**: Houses various toolkits that provide specific functionalities, bootstrapping capabilities, or operational utilities. These might be CLI tools or libraries that serve a more specialized purpose than general `libs/` or developer-focused `devkits/`.
   - _Example Nx projects: `toolkits/infra-bootstrapper`, `toolkits/data-migration-cli`_

7. **`tools/`**
   - **Purpose**: Contains internal workspace tools, scripts, and configurations that support the monorepo's development, build, and CI/CD processes. These are typically not published packages but are essential for the health and operation of the monorepo itself.
   - _Example: `tools/scripts/ci-validate.sh`, `tools/local-nx-generators`_

## Adherence to Structure

All new packages (applications or libraries managed by Nx) should be created within one of these top-level domain directories. This practice helps maintain an organized, discoverable, and scalable codebase.

For instance, when generating a new library with Nx, you would use the `--directory` flag:
`nx g @nx/js:library my-new-feature --directory=libs/my-new-feature`

This structured approach is fundamental to the Webnode ecosystem's architecture.
