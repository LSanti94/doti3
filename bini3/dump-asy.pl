#!/usr/bin/env perl
# vim:ts=4:sw=4:expandtab
# renders the layout tree using asymptote
#
#        sudo  apt install asymptote
#
# ./dump-asy.pl
#   will render the entire tree
# ./dump-asy.pl 'name'
#   will render the tree starting from the node with the specified name,
#   e.g. ./dump-asy.pl 2 will render workspace 2 and below

use strict;
use warnings;
use Data::Dumper;
use AnyEvent::I3;
use File::Temp;
use v5.10;
my $path = qx(DISPLAY=:2 i3 --get-socketpath);
qx(echo "$path" > /tmp/out);
my $i3 = i3();

my $tree = $i3->get_tree->recv;

use Data::Dumper;
# print Dumper($tree);

my $tmp = File::Temp->new(UNLINK => 0, SUFFIX => '.asy');

say $tmp "import drawtree;";

say $tmp "treeLevelStep = 2cm;";

sub dump_node {
	my ($n, $parent) = @_;

    my $o = ($n->{orientation} eq 'none' ? "u" : ($n->{orientation} eq 'horizontal' ? "h" : "v"));
    my $w = (defined($n->{window}) ? $n->{window} : "N");
    my $na = $n->{name};
    $na =~ s/#/\\#/g;
    $na =~ s/\$/\\\$/g;
    $na =~ s/&/\\&/g;
    $na =~ s/_/\\_/g;
    $na =~ s/~/\\textasciitilde{}/g;
    $na =~ s/~/\\textasciitilde{}/g;
    $na =~ s/<.+?>//g;
    $na =~ s/[^[:ascii:]]//g;
    my $type = 'leaf';
    if (!defined($n->{window})) {
        $type = $n->{orientation} . '-split';
    }
    my $name = qq|``$na'' ($type)|;
    # print "  $name\n";
    # fix for names containing %
    $name =~ s/%/\\%/g;
    print $tmp "TreeNode n" . $n->{id} . " = makeNode(";

    print $tmp "n" . $parent->{id} . ", " if defined($parent);
    print $tmp "\"" . $name . "\");\n";

    dump_node($_, $n) for @{$n->{nodes}};
}

sub find_node_with_name {
    my ($node, $name) = @_;

    return $node if ($node->{name} eq $name);
    for my $child (@{$node->{nodes}}) {
        my $res = find_node_with_name($child, $name);
        return $res if defined($res);
    }
    return undef;
}

my $start = shift;
chomp($start=qx(i3-msg -t get_workspaces|jq -r '.[]| select(.focused==true).output'));
my $root;
if ($start) {
    # Find the specified node in the tree
    $root = find_node_with_name($tree, $start);
} else {
    $root = $tree;
}
dump_node($root);
say $tmp "draw(n" . $root->{id} . ", (0, 0));";

close($tmp);
my $rep = "$tmp";
$rep =~ s/asy$/eps/;
system("cat $tmp");
system("cd /tmp && asy $tmp && gv --page='$root' --noresize --antialias --scale=-1000 --fullscreen --widgetless  $rep && rm $rep");

