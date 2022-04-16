#!/bin/bash

# Check variables
OS_CHECK=`uname -a | cut -d ' ' -f 1`
GO_PATH=`go env | grep GOPATH | cut -d '"' -f 2`
COBRA_CHECK=`ls $GO_PATH/bin/cobra | wc -l`

# Use for setting total dependencies
T='2'



# OS Check - Only works for MAC OSX/Linux
echo "================================"
echo "        OS CHECK"
if [[ "$OS_CHECK" == "Linux" ]]; then
   echo "OS is : $OS_CHECK 🐧"
   OS='LINX'
elif [[ "$OS_CHECK" == "Darwin" ]]; then
   echo "OS is : $OS_CHECK 🍎"
   OS='MAC'
else
   echo "This OS isn't supported"
   exit 1
fi
echo "================================"
echo "        GOPATH CHECK"
if [[ "$GO_PATH" == "" ]]; then
   echo "✖️ ERROR: Your GOPATH isn't set. ✖️"
   go env | grep GOPATH
   exit 1
else
   echo "🐹 GOPATH is set: $GO_PATH"
fi
echo "================================"
echo "       DEPENDENCY CHECK"
echo "(1/$T) ----> Checking for ASDF"
if [[ $OS == 'LINX' ]]; then
   ASDF_CHECK=`which ~/.asdf/bin/asdf | wc -l`
   if [[ $ASDF_CHECK == "0" ]]; then
      git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
      echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
      echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
      echo "Installed 'asdf' at ~/.asdf/bin/asdf"
   elif [[ $ASDF_CHECK == "1" ]]; then
      echo "'asdf' already installed."
   fi
elif [[ $OS == 'MAC' ]]; then
   ASDF_CHECK=`which /usr/local/bin/asdf | wc -l`
   if [[ $ASDF_CHECK == "0" ]]; then
       brew install asdf
       echo "Installed 'asdf' at /usr/local/bin/asdf"
   elif [[ $ASDF_CHECK == "1" ]]; then
      echo "'asdf' already installed."
   fi
fi
echo "(2/$T) ----> Checking for COBRA"
if [[ $COBRA_CHECK == "0" ]]; then
    go get github.com/spf13/cobra/cobra
    echo "Installed 'cobra' at $GO_PATH/bin/cobra"
elif [[ $COBRA_CHECK == "1" ]]; then
   echo "'cobra' already installed."
fi
echo "================================"
