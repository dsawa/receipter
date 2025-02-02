# Receipter

Simple Ruby application that simulates receipts printing based on inputs of shopping baskets represented as text files. See example inputs in [inputs directory](./inputs).

Rules that it applies to calculations:

- Assumption: items category is recognized by their product name match with basic set of rules (for example: 'sweet cake' is going to be categorized to 'food' because of 'cake' in it). Rules here inside [Item class](./app/models/item.rb)
- Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt.
- Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.
- The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

## Running app (Printing receipts)

### Shopping basket input format

Shopping basket file is valid with format rules: it must contain line items for a product, separated by white space. Price for that item should be placed after "at".

```
[:quantity] [:product_name] at [:product_price]
```

Example:

```text
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

### Running

Assuming you have txt file that represents you shopping basket, pass it as an argument (relative path from where main.rb is placed). Like this: `ruby main.rb 'path/to/basket.txt'

If you have more shopping baskets you can pass multiple paths to file. Example below
for [inputs directory](./inputs).

```bash
ruby main.rb "inputs/input_1.txt" "inputs/input_2.txt" "inputs/input_3.txt"
```

Line above is going to print:

```bash
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32

1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15

1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

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

### Logging

To enable logging pass `DEBUG=1` environment variable when running app.

### Tests

App uses [rspec](https://rspec.info) for testing.
Run tests with simply: `rspec`

### Code Quality

Project uses pre-commit hooks for ensuring code quality, safety and proper conventional commits.

Install `pre-commit` (MacOS: `brew install pre-commit`) and then in project run `pre-commit install`.

To run hook manually: `pre-commit run --all-files`
