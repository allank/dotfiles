SYSTEM=$(nix-instantiate --eval --expr 'builtins.currentSystem')
SYSTEM="${SYSTEM//\"}"
OS=$(uname -s)

HOME_SAFE=$(sed 's/[\/&]/\\&/g' <<< "$HOME")

cp base/flake-base.nix flake.nix
cp base/home-base.nix home.nix

if [ $OS == "Darwin" ]; then
	sed -i '' "s/<USER>/$USER/g" flake.nix
	sed -i '' "s/<SYSTEM>/$SYSTEM/g" flake.nix
	sed -i '' "s/<USER>/$USER/g" home.nix
	sed -i '' "s/<HOME>/$HOME_SAFE/g" home.nix
else
	sed -i "s/<USER>/$USER/g" flake.nix
	sed -i "s/<SYSTEM>/$SYSTEM/g" flake.nix
	sed -i "s/<USER>/$USER/g" home.nix
	sed -i "s/<HOME>/$HOME_SAFE/g" home.nix

fi


