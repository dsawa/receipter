# Receipter

Simple Ruby application that simulates receipts printing based on inputs of shopping baskets represented as text files. See example inputs in [inputs directory](./inputs).

Rules that it applies to calculations:

- Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt.
- Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.

## Development

### Requirements

- Ruby 3.4.1
- Bundler

### Setup

1. Install required Ruby version (3.4.1)
2. Install dependencies:

```bash
bundle install
```

### Code Quality

Project uses pre-commit hooks for ensuring code quality, safety and proper conventional commits.

Install `pre-commit` (MacOS: `brew install pre-commit`) and then in project run `pre-commit install`.

To run hook manually: `pre-commit run --all-files`
