[
  {
    name: 'apps',
    projects: [],
    meta: {
      description: 'Standalone applications (UI, backend, demos).',
      keywords: ['ui', 'backend', 'service', 'demo', 'application'],
    },
    nx: {
      tags: ['type:app', 'domain:apps'],
      type: 'application',
    },
  },
  {
    name: 'devkit',
    projects: [],
    meta: {
      description: 'Developer toolkits & extensions (Nx plugins, generators).',
      keywords: [
        'developer-experience',
        'dx',
        'plugin',
        'generator',
        'scaffolding',
      ],
    },
    nx: {
      tags: ['type:lib', 'domain:devkit'],
      type: 'library',
    },
  },
  {
    name: 'docs',
    projects: [],
    meta: {
      description: 'Documentation: packages & source files (sites, Markdown).',
      keywords: ['documentation', 'guides', 'markdown', 'website', 'help'],
    },
    nx: {
      tags: ['type:lib', 'domain:docs'],
      type: 'library',
    },
  },
  {
    name: 'libs',
    projects: [],
    meta: {
      description: 'General-purpose shared libraries (UI, utilities).',
      keywords: ['shared', 'reusable', 'ui-components', 'utils', 'common'],
    },
    nx: {
      tags: ['type:lib', 'domain:libs'],
      type: 'library',
    },
  },
  {
    name: 'scripts',
    projects: [],
    meta: {
      description: 'Internal scripts for various operational tasks.',
      keywords: ['automation', 'cli', 'tasks', 'operations', 'internal'],
    },
    nx: {
      tags: ['type:lib', 'domain:scripts'],
      type: 'library',
    },
  },
  {
    name: 'sdk',
    projects: [],
    meta: {
      description: 'Software Development Kits (SDKs) for core ecosystem APIs.',
      keywords: ['api-client', 'integration', 'core-api', 'client-library'],
    },
    nx: {
      tags: ['type:lib', 'domain:sdk'],
      type: 'library',
    },
  },
  {
    name: 'toolkits',
    projects: [],
    meta: {
      description:
        'Specialized toolkits (CLIs, bootstrapping, operational utils).',
      keywords: [
        'cli-tools',
        'bootstrapper',
        'utilities',
        'specialized',
        'operations-kit',
      ],
    },
    nx: {
      tags: ['type:lib', 'domain:toolkits'],
      type: 'library',
    },
  },
  {
    name: 'tools',
    projects: ['*'],
    meta: {
      description: 'Internal workspace tools & configs (build, CI/CD).',
      keywords: [
        'build-system',
        'ci-cd',
        'workspace',
        'configuration',
        'devops',
      ],
    },
    nx: {
      tags: ['type:lib', 'domain:tools'],
      type: 'library',
    },
  },
];
