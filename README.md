# docker-rancid example setup

## as root

	echo "LIST_OF_GROUPS=\"my-group\"; export LIST_OF_GROUPS" >> /etc/rancid.conf

## as rancid user

	sudo -u rancid -i
	git config --global user.email "some@email.com"
	git config --global user.name "Some name"
	echo -e "add method * {ssh}\nadd user * {my-username}\nadd password * {my-ssh-pass} {my-enable-pass}" > .cloginrc
	chmod 0600 .cloginrc
	rancid-cvs
	
## on host crontab

	# run config differ hourly
	1 * * * * /usr/bin/docker start [rancid-container]
	# clean out config differ logs
	50 23 * * * /usr/bin/docker exec [rancid-container] /usr/bin/find /var/lib/rancid/logs -type f -mtime +2 -exec rm {} \;

# docker-rancid git-remote

## as rancid user

	ssh-keygen -t rsa
	# copy and paste the contents of ~/.ssh/id_rsa.pub to remote git-repo
	
	cd my-group/
	git remote add [name] [url]
	git push -u [remote name] master
	
