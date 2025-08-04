#!/bin/sh

cd "$(dirname "$0")"

sed -i 's/^online-mode=.*/online-mode=false/' server.properties
sed -i 's/^motd=.*/motd=/' server.properties
sed -i 's/^enforce-secure-profile=.*/enforce-secure-profile=false/' server.properties

if grep -q "bungeecord:" spigot.yml; then
  sed -i 's/bungeecord:.*/bungeecord: true/' spigot.yml
else
  awk '/settings:/{print;print "  bungeecord: true";next}1' spigot.yml > spigot_tmp.yml && mv spigot_tmp.yml spigot.yml
fi

java -Xms128M -Xmx4096M -Dterminal.jline=false -Dterminal.ansi=true -jar server.jar
