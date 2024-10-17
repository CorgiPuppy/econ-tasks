#!/usr/bin/perl

use strict;
use warnings;

BEGIN {push @INC, '../include'}
use Expenses;
use Income;
use Report;

my $expenses = Expenses->new({
							 household_needs => [456, 500, 0, 456, 0, 0, 0, 0, 0],
							 bad_habits => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 hygiene_and_health => [37100, 35000, 0, 0, 0, 0, 0, 4500, 32600],
							 clothes => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 trips => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 food_products => [785, 1500, 67, 470, 90, 0, 158, 0, 0],
							 entertainments => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 connection => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 total_per_week => [38341, 37000],
							 total_per_day => [67, 926, 90, 0, 158, 4500, 32600]});

my $income = Income->new({
						 salary => 1579,
						 parents_money => 0,
						 total => 1579 + 0});

my $report = Report->new({
						 weekly_income => 1579,
						 weekly_expenses => 38341,
						 balance => 36762,
						 expenses_plan => 37000,
						 departure_plan => 258});

my $folder = "../files/first_week/";
my $expenses_file = $folder . "expenses.txt";
my $income_file = $folder . "income.txt";
my $report_file = $folder . "report.txt";

$expenses->write_to_file($expenses_file);
$income->write_to_file($income_file);
$report->write_to_file($report_file);
