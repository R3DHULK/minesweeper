use strict;
use warnings;

my $width = 10;  # width of the board
my $height = 10;  # height of the board
my $num_mines = 10;  # number of mines

# Initialize the board
my @board;
for (my $y = 0; $y < $height; $y++) {
    for (my $x = 0; $x < $width; $x++) {
        $board[$y][$x] = 0;  # 0 means empty, 1 means mine
    }
}

# Add the mines
my $mines_added = 0;
while ($mines_added < $num_mines) {
    my $x = int(rand($width));
    my $y = int(rand($height));
    if ($board[$y][$x] == 0) {
        $board[$y][$x] = 1;
        $mines_added++;
    }
}

# Print the board
for (my $y = 0; $y < $height; $y++) {
    for (my $x = 0; $x < $width; $x++) {
        if ($board[$y][$x] == 1) {
            print "*";  # print a mine
        } else {
            my $count = 0;
            if ($x > 0 && $y > 0 && $board[$y-1][$x-1] == 1) { $count++; }  # top-left
            if ($y > 0 && $board[$y-1][$x] == 1) { $count++; }  # top
            if ($x < $width-1 && $y > 0 && $board[$y-1][$x+1] == 1) { $count++; }  # top-right
            if ($x > 0 && $board[$y][$x-1] == 1) { $count++; }  # left
            if ($x < $width-1 && $board[$y][$x+1] == 1) { $count++; }  # right
            if ($x > 0 && $y < $height-1 && $board[$y+1][$x-1] == 1) { $count++; }  # bottom-left
            if ($y < $height-1 && $board[$y+1][$x] == 1) { $count++; }  # bottom
            if ($x < $width-1 && $y < $height-1 && $board[$y+1][$x+1] == 1) { $count++; }  # bottom-right
            print $count;  # print the number of adjacent mines
        }
    }
    print "\n";  # print a new line at the end of each row
}
