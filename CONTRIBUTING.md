# Contributing to cardano-plutus-vm-benchmark

Thank you for your interest in contributing! This document provides guidelines and processes for contributing to the project.

## Code of Conduct

Please be respectful and constructive in all interactions. We're building tools for the Cardano community and value collaboration.

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Git
- Python 3.10+ (for running parsers locally)

### Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/cardano-plutus-vm-benchmark.git
   cd cardano-plutus-vm-benchmark
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/saib-inc/cardano-plutus-vm-benchmark.git
   ```

### Running Locally

```bash
docker compose build
docker compose run --rm benchmark
```

## Development Workflow

1. Create a feature branch from `main`:
   ```bash
   git checkout main
   git pull upstream main
   git checkout -b feature/your-feature-name
   ```

2. Make your changes

3. Test the full pipeline:
   ```bash
   docker compose build
   docker compose run --rm benchmark
   ```

4. Commit your changes following the [commit conventions](#commit-conventions)

5. Push to your fork and create a Pull Request

## Commit Conventions

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear and consistent commit history.

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | A new feature (new VM, new parser, new report format) |
| `fix` | A bug fix |
| `docs` | Documentation changes |
| `style` | Code style changes (formatting, etc.) |
| `refactor` | Code refactoring without feature changes |
| `perf` | Performance improvements to the benchmark infrastructure |
| `test` | Adding or updating tests |
| `chore` | Maintenance tasks (dependencies, CI, version bumps) |
| `bench` | Benchmark version updates or result commits |

### Scopes

| Scope | Description |
|-------|-------------|
| `docker` | Dockerfile or docker-compose changes |
| `parsers` | Output parser changes |
| `scripts` | Runner script changes |
| `report` | Report generator changes |
| `data` | Benchmark data changes |
| `ci` | GitHub Actions workflow changes |
| `chrysalis` | Chrysalis VM-specific changes |
| `uplc-turbo` | uplc-turbo VM-specific changes |
| `plutigo` | Plutigo VM-specific changes |
| `blaze` | blaze-plutus VM-specific changes |
| `plutuz` | Plutuz VM-specific changes |
| `opshin` | opshin VM-specific changes |

### Examples

```
feat(docker): add Haskell plutus-core as 7th VM
fix(parsers): handle missing stddev in Go bench output
chore: update pinned SHAs in .env
bench: results 2026-03-15
docs: add methodology section on geometric mean
```

## Pull Request Process

1. **Create a descriptive PR title** following commit conventions
2. **Fill out the PR description** with:
   - Description of changes
   - Related issues
   - Testing performed
3. **Ensure the Docker build succeeds**
4. **Request review** from maintainers
5. **Address feedback** promptly
6. **Squash and merge** when approved

### PR Requirements

- Docker build must succeed
- Parsers must handle edge cases (missing data, empty output)
- Follow existing code style and patterns
- Update METHODOLOGY.md if changing benchmark methodology
- Update README.md if adding new VMs or changing usage

## Adding a New VM

To add a new Plutus VM implementation:

1. Add a build stage to `Dockerfile`
2. Add a runner script in `scripts/run-<vm-name>.sh`
3. Add an output parser in `parsers/parse_<vm_name>.py`
4. Add the VM's CSV filename to `parsers/normalize.py`
5. Add the VM to `VM_ORDER` and `VM_LABELS` in `report/generate_report.py`
6. Add pinned SHA to `.env`
7. Update `README.md` and `METHODOLOGY.md`

## Updating VM Versions

1. Update the relevant `*_SHA` in `.env`
2. Test with `docker compose build --no-cache && docker compose run --rm benchmark`
3. Submit PR with commit message: `chore: update <vm-name> to <commit/tag>`

### What NOT to Do

- **Never push directly to `main`** - Always use Pull Requests
- **Never force push to `main`** - This destroys history
- **Never modify benchmark data** without consensus from maintainers
- **Never add custom harnesses** - Use each VM's native benchmark

## Questions?

If you have questions about contributing, please open an issue or reach out to the maintainers.

---

Thank you for contributing to cardano-plutus-vm-benchmark!
