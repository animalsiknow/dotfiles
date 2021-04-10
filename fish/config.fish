if isatty
    source "$HOME/.opam/opam-init/init.fish"
end
source "$HOME/.opam/opam-init/variables.fish"

set -gp fish_user_paths "/usr/local/bin"
set -gp fish_user_paths "$HOME/.cargo/bin"
set -gp fish_user_paths "/usr/local/opt/ruby/bin"
set -gp fish_user_paths (gem environment gemdir)"/bin"
