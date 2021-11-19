if ! which rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # todo source the correct file
else
    echo 'rust is installed'
fi

if ! which stylua >/dev/null 2>&1; then 
    cargo install stylua
else 
    echo 'stylua is installed'
fi
