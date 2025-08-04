#!/bin/sh

cd "$(dirname "$0")"

if [ ! -f config_start.txt ]; then
  printf "Which Jar u want to use?\n> "
  read jar
  printf "Memory?\n> "
  read memory
  echo "jar=$jar" > config_start.txt
  echo "memory=${memory}M" >> config_start.txt
else
  . ./config_start.txt
fi

sed -i 's/^online-mode=.*/online-mode=false/' server.properties
sed -i 's/^motd=.*/motd=/' server.properties
sed -i 's/^enforce-secure-profile=.*/enforce-secure-profile=false/' server.properties

if grep -q "bungeecord:" spigot.yml; then
  sed -i 's/bungeecord:.*/bungeecord: true/' spigot.yml
else
  awk '/settings:/{print;print "  bungeecord: true";next}1' spigot.yml > spigot_tmp.yml && mv spigot_tmp.yml spigot.yml
fi

java -Xms128M -Xmx"$memory" -Dterminal.jline=false -Dterminal.ansi=true -jar "$jar"
