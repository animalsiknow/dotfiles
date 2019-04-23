#!/usr/bin/env perl6

my @files = <
    config
    emacs.d spacemacs spacemacs-layers
    gitconfig gitignore
    irssi
    tmux.conf
    XCompose xinitrc xmodmap xresources
    zshrc zpath zprofile zshenv zfunc
>;

for @files -> $file {
    my $target = $*SPEC.catdir(%*ENV<HOME>, ".$file").IO;

    given $target {
        when :l { .unlink }
        when :e { die("$_ already exists.") }
    }

    my $source = $*SPEC.catdir($*CWD, $file).IO;
    qq{Linking "$target" -> "$source".}.say;
    $source.symlink: $target;
}
