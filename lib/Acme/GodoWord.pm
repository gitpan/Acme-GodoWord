package Acme::GodoWord;

use strict;
use warnings;
use utf8;

our $VERSION = '0.00001';

use Text::TinySegmenter;

our $jyoshi     = qr{か|かしら|から|が|くらい|けれども|こそ|さ|さえ|しか|ぞ|だけ|だに|だの|て|で|でも|と|ところが|とも|な|など|なり|に|ね|の|ので|のに|は|ばかり|へ|ほど|まで|も|や|やら|よ|より|わ|を}o;
our $jyodoushi  = qr{う|させ|させよ|させる|させれ|させろ|ず|せ|せよ|せる|せれ|せろ|そうだ|そうだっ|そうだろ|そうで|そうな|そうなら|そうに|た|たい|たかっ|たかろ|たがっ|たがら|たがり|たがる|たがれ|たがろ|たく|たけれ|たら|たろ|だ|だっ|だら|だろ|で|でし|でしょ|です|な|ない|なかっ|なかろ|なく|なけれ|なら|ぬ|ね|べき|べきだ|べきだっ|べきだろ|べきで|べきな|べきなら|べく|まい|まし|ましょ|ます|ますれ|ませ|やがっ|やがら|やがり|やがる|やがれ|よう|ようだ|ようだっ|ようだろ|ようで|ような|ようなら|ように|らしい|らしかっ|らしく|らしけれ|られ|られよ|られる|られれ|られろ|れ|れよ|れる|れれ|れろ|ん}o;
our $ignore     = qr{[、。!?！？]}o;

sub tokenize {
    my ( $class, $message ) = @_;

    my @tokens  = Text::TinySegmenter->segment($message);
    my @words   = ();

    for my $token ( @tokens ) {
        if ( @words <= 0 ) {
            push @words, $token;
        }
        elsif ( $token =~ m{^(?:$jyoshi)+$} && $words[$#words] =~ m{^(?:$jyoshi)+$} ) {
            $words[ $#words ] .= $token;
        }
        elsif ( $token =~ m{^(?:$jyodoushi)+$} ) {
            $words[ $#words ] .= $token;
        }
        elsif ( $token =~ m{^(?:$ignore)+$} ) {
            next;
        }
        else {
            push @words, $token;
        }
    }

    return @words;
}

sub babelize {
    my ( $class, $message ) = @_;
    return '【' . join ( q{」「}, $class->tokenize($message) ) .  '】';
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::GodoWord - Japanese tokenizer like master of babel

=head1 SYNOPSIS

    use Acme::GodoWord;
    
    my $message = 'あなたには見えない'; # you don't see
    
    # @tokens = qw( あなた には 見えない );
    my @tokens = Acme::GodoWord->tokenize( $message );
    
    # print q{【あなた」「には」「みえない】};
    print Acme::GodoWord->godowordize( $message );

=head1 DESCRIPTION

Acme::GodoWord is Japanese tokenizer like master of babel.

Master of babel is one kind of magic written in romance Kara no Kyoukai (空の境界)
and magician KUROGIRI Satsuki (黒霧皐月, Godoword mayday) uses it.

Master of babel is expressed by such feeling in the novel:

    【あなた」「には」「みえない】
    
    【ここ」「では」「みえない】

This module is the divider into which Japanese is divided as mentioned above.

Kara no Kyoukai (空の境界) is the romance written by NASU Kinoko (奈須きのこ).
It was filmed in recent years.

=head1 FUNCTION

=head2 tokenize

    my @tokens = Acme::GodoWord->tokenize( $utf8_message );

This method is tokenize Japanese message.

utf8 flag has to be on for the message to pass it to this argument.

=head2 babelize

    my $message = Acme::GodoWord->babelize( $utf8_message );

This method generates master of babel.

utf8 flag has to be on for the message to pass it to this argument.

=head1 AUTHOR

Naoki Okamrua (Nyarla) E<lt>nyarla[ at ]thotep.netE<gt>

=head1 SEE ALSO

L<Text::TinySegmenter>

L<http://en.wikipedia.org/wiki/Nasu_Kinoko>

L<http://en.wikipedia.org/wiki/Kara_no_Kyoukai>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
