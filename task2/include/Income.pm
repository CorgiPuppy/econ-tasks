package Income;

use strict;
use warnings;

sub new
{
	my ($class, $args) = @_;
	my $self = bless { salary => $args->{salary},
					   parents_money => $args->{parents_money},
					   total => $args->{total}};
}

sub write_to_file
{
	my $self = shift;

	my $title = "Доходы бюджета\n";
	my $columns = "Категории доходов" . "\t" . "Сумма\n";
	my $salary_column = "Зарплата" . "\t\t" . "$self->{salary}\n";
	my $parents_money_column = "Деньги родителей" . "\t" . "$self->{parents_money}\n";
	my $total_column = "Итого" . "\t\t\t" . "$self->{total}\n";	
	
	my ($filename) = @_;
	open(FH, '>', $filename) or die $!;
	print FH $title . $columns . $salary_column . $parents_money_column . $total_column;
	close(FH);

}

1;
