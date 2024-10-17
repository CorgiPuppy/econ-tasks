package Report;

use strict;
use warnings;

sub new
{
	my ($class, $args) = @_;
	my $self = bless { weekly_income => $args->{weekly_income},
					   weekly_expenses => $args->{weekly_expenses},
					   balance => $args->{balance},
					   expenses_plan => $args->{expenses_plan},
					   departure_plan => $args->{departure_plan}
					 }, $class;
}

sub write_to_file
{
	my $self = shift;
	my $title = "Отчёт\n";
	my $weekly_income_column = "Доходы за неделю" . "\t" . "$self->{weekly_income}\n";
	my $weekly_expenses_column = "Расходы за неделю" . "\t" . "$self->{weekly_expenses}\n";
	my $balance_column = "Сальдо" . "\t\t\t\t" . "$self->{balance}\n";
	my $expenses_plan_column = "План расходов" . "\t\t" . "$self->{expenses_plan}\n";
	my $departure_plan = "Отход от плана" . "\t\t" . "$self->{departure_plan}\n";

	my ($filename) = @_;
	open(FH, '>', $filename) or die $!;
	print FH $title . $weekly_income_column . $weekly_expenses_column . $balance_column . $expenses_plan_column . $departure_plan;
	close(FH);
}

1;
