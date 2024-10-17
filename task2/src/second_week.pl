#!/usr/bin/perl

use strict;
use warnings;

BEGIN {push @INC, '../include'}
use Expenses;
use Income;
use Report;

my $expenses = Expenses->new({
							 household_needs => [5383, 5000, 0, 136, 0, 0, 0, 5148, 99],
							 bad_habits => [46, 0, 0, 0, 0, 9, 0, 37, 0],
							 hygiene_and_health => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 clothes => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 trips => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 food_products => [277, 1500, 0, 113, 0, 0, 0, 100, 64],
							 entertainments => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 connection => [0, 0, 0, 0, 0, 0, 0, 0, 0],
							 total_per_week => [5706, 6500],
							 total_per_day => [0, 249, 0, 9, 0, 5285, 163]});

my $income = Income->new({
						 salary => 14298,
						 parents_money => 0,
						 total => 14298 + 0});

my $report = Report->new({
						 weekly_income => 14298,
						 weekly_expenses => 5706,
						 balance => 8592,
						 expenses_plan => 6500,
						 departure_plan => 2092});

my $folder = "../files/second_week/";
my $expenses_file = $folder . "expenses.txt";
my $income_file = $folder . "income.txt";
my $report_file = $folder . "report.txt";

$expenses->write_to_file($expenses_file);
$income->write_to_file($income_file);
$report->write_to_file($report_file);
