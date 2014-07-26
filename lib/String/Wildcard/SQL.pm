package String::Wildcard::SQL;

use 5.010001;
use strict;
use warnings;

# VERSION

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       contains_wildcard
               );

my $re1 =
    qr/
      #    (?:
      #        # non-empty, non-escaped character class
      #        (?<!\\)(?:\\\\)*\[
      #        (?:  \\\\ | \\\[ | \\\] | [^\\\[\]] )+
      #        (?<!\\)(?:\\\\)*\]
      #    )
      #|
          (?:
              # non-escaped % and _
              (?<!\\)(?:\\\\)*[_%]
          )
      /ox;

sub contains_wildcard {
    my ($str, $variant) = @_;

    $str =~ /$re1/go;
}

1;
# ABSTRACT: SQL wildcard string routines

=for Pod::Coverage ^(qqquote)$

=head1 SYNOPSIS

    use String::Wildcard::SQL qw(contains_wildcard);

    say 1 if contains_wildcard(""));      # -> 0
    say 1 if contains_wildcard("ab%"));   # -> 1
    say 1 if contains_wildcard("ab\\%")); # -> 0


=head1 DESCRIPTION


=head1 FUNCTIONS

=head2 contains_wildcard($str[, $variant]) => bool

Return true if C<$str> contains wildcard pattern. Wildcard patterns include C<%>
(meaning zero or more characters) and C<_> (exactly one character).


=head1 TODO

Support other variants. Transact-SQL supports character class, though I'm not
sure how the escaping mechanism works. Access supports DOS-style wildcard (C<*>
and C<?>) instead, and I'm also not sure whether there's something akin to
backslash escape mechanism there.

See L<String::Wildcard::Bash>'s TODO for the types of functions which I plan to
add to this module.


=head1 SEE ALSO

L<Regexp::Wildcards> to convert a string with wildcard pattern to equivalent
regexp pattern. Can handle Unix wildcards as well as SQL and DOS/Win32.

Other C<String::Wildcard::*> modules.

=cut
