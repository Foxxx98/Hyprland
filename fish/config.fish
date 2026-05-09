if status is-interactive
    # Commands to run in interactive sessions can go he
    fastfetch
end
function fish_greeting
    # do nothing
end
alias ls='lsd'
starship init fish | source
