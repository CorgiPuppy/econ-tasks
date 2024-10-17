#!/usr/bin/perl

use strict;
use warnings;

BEGIN {push @INC, '../include'}
use Expenses;
use Income;
use Report;

print("Таблица расходов и доходов личного бюджета на 2 недели\n");

my $expenses = Expenses->new({
							 household_needs => [2323, 23],
							 bad_habits => [2132],
							 hygiene_and_health => [32],
							 clothes => [32],
							 trips => [32],
							 food_products => [32],
							 entertainments => [32],
							 connection => [32],
							 total_per_week => [32],
							 total_per_day => [32]});

my $income = Income->new({
						 salary => 1000,
						 parents_money => 1000,
						 total => 1000 + 1000});

my $report = Report->new({
						 weekly_income => 1000,
						 weekly_expenses => 100,
						 balance => 10,
						 expenses_plan => 50,
						 departure_plan => 450});

my $expenses_file = "../files/expenses.txt";
my $income_file = "../files/income.txt";
my $report_file = "../files/report.txt";

$expenses->write_to_file($expenses_file);
$income->write_to_file($income_file);
$report->write_to_file($report_file);
