# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

stock_units = StockUnit.create([{ name: 'Мука', amount: 30_000, cost: '30', measure_units: 'гр' },
                                { name: 'Сахар', amount: 10_000, cost: '50', measure_units: 'гр' },
                                { name: 'Стаканчик', amount: 100, cost: '2', measure_units: 'шт' },
                                { name: 'Дрожжи', amount: 10, cost: '20', measure_units: 'шт' },
                                { name: 'Кофе', amount: 700, cost: '800', measure_units: 'грамм' },
                                { name: 'Молоко', amount: 10_000, cost: '70', measure_units: 'мл' },
                                { name: 'Чистая вода', amount: '19000', cost: '140', measure_units: 'мл' }])

products = Product.create([{ name: 'Латте', cost: 100, servings: 1 },
                           { name: 'Эспрессо', cost: 60, servings: 1 }])

Ingredient.create([{ product: products.first, stock_unit: stock_units[2], amount: 1 },
                   { product: products.first, stock_unit: stock_units[4], amount: 30 },
                   { product: products.first, stock_unit: stock_units[5], amount: 200 },
                   { product: products.first, stock_unit: stock_units[6], amount: 60 }])

FixedCost.create([{ name: 'Аренда', cost: 8000 },
                  { name: 'Амортизация кофемашины', cost: 5000, date_started:
                      Time.zone.today, date_finished: Time.zone.today + 2.years },
                  { name: 'Зарплата Маши', cost: 20_000, frequency: 'monthly' }])
