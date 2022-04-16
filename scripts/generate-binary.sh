#!/bin/bash
source scripts/versioning.env
mkdir -p binary/sha256
if [[ $* == *--arch* ]]; then
   if [[ $* == *linux* ]]; then
      env GOOS=linux GOARCH=amd64 go build -o binary/mock-linux-amd64-$CURRENT_VERSION
      sha256sum binary/mock-linux-amd64-$CURRENT_VERSION  | cut -d ' ' -f 1 > binary/sha256/mock-linux-amd64-$CURRENT_VERSION.sha256
      echo "Generated Linux Binary 🐧"
   elif [[ $* == *mac* ]]; then
      env GOOS=darwin GOARCH=amd64 go build -o binary/mock-darwin-amd64-$CURRENT_VERSION
      sha256sum binary/mock-darwin-amd64-$CURRENT_VERSION | cut -d ' ' -f 1 > binary/sha256/mock-darwin-amd64-$CURRENT_VERSION.sha256
      echo "Generated Mac OSX Binary 🍎"
   elif [[ $* == *windows* ]]; then
      env GOOS=windows GOARCH=amd64  go build -o binary/mock-$CURRENT_VERSION.exe
      sha256sum binary/mock-$CURRENT_VERSION.exe  | cut -d ' ' -f 1 > binary/sha256/mock-$CURRENT_VERSION-windows.sha256
      echo "Generated Windows Binary 🪟"
   elif [[ $* == *all* ]]; then
      env GOOS=linux GOARCH=amd64 go build -o binary/mock-linux-amd64-$CURRENT_VERSION
      sha256sum binary/mock-linux-amd64-$CURRENT_VERSION  | cut -d ' ' -f 1 > binary/sha256/mock-linux-amd64-$CURRENT_VERSION.sha256
      echo "Generated Linux Binary 🐧"
      env GOOS=darwin GOARCH=amd64 go build -o binary/mock-darwin-amd64-$CURRENT_VERSION
      sha256sum binary/mock-darwin-amd64-$CURRENT_VERSION  | cut -d ' ' -f 1 > binary/sha256/mock-darwin-amd64-$CURRENT_VERSION.sha256
      echo "Generated Mac OSX Binary 🍎"
      env GOOS=windows GOARCH=amd64  go build -o binary/mock-$CURRENT_VERSION.exe
      sha256sum binary/mock-$CURRENT_VERSION.exe  | cut -d ' ' -f 1 > binary/sha256/mock-$CURRENT_VERSION-windows.sha256
      echo "Generated Windows Binary 🪟"
   fi
fi
