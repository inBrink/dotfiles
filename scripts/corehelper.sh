if grep -Fq "alias core" ~/.bashrc; then
  sed -i "/alias core=/c\alias core='source\ <(curl -s https://raw.githubusercontent.com/inBrink/dotfiles/master/scripts/coreAsync.sh) --cloud'" ~/.bashrc
else
  echo -e "alias core='source <(curl -s https://raw.githubusercontent.com/inBrink/dotfiles/master/scripts/coreAsync.sh) --cloud'" >> ~/.bashrc
fi
source ~/.bashrc
