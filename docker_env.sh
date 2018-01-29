
prefix="Auto_testing"

function clean()
{	
	echo ""
	echo "*** Now is Cleaning ***"
	echo ""

	container_list=`docker ps -aq --filter "name=$prefix"`

	if [ ! -z "$container_list" ]
	then
		sudo docker kill $(docker ps -q --filter "name=$prefix")
		sudo docker rm $(docker ps -aq --filter "name=$prefix")
	fi
	
	echo ""
	echo "*** Cleaning is Done ***"
	echo ""
}

function build()
{	
	docker_path=`pwd`
	cd ~
	home_pwd=`pwd`
	cd $docker_path

	mkdir $home_pwd/tmp/Downloads

	chmod 777 -R $home_pwd/tmp/Downloads

	echo ""
	echo "*** Now is building ***"
	echo ""

	selenium_hub=$prefix"_selenium_hub"
	chrome_node=$prefix"_chrome_node"
	firefox_node=$prefix"_firefox_node"
	
	echo "Selenium Hub Name:"$selenium_hub
	echo "Chrome Node Name:"$chrome_node
	echo "Firefox Node Name:"$firefox_node

	sudo docker pull selenium/hub

	sudo docker build -t selenium/vnc-node-chrome-debug ./node_chrome

	sudo docker run -p 5555:4444 -d --name "$selenium_hub"  selenium/hub
	
	sudo docker run -P -v $home_pwd/tmp/Downloads:/home/seluser/Downloads -d --name "$chrome_node" --link $selenium_hub:hub  selenium/vnc-node-chrome-debug

	sudo docker build -t selenium/vnc-node-firefox-debug ./node_firefox
	
	sudo docker run -P -v $home_pwd/tmp/Downloads:/home/seluser/Downloads -d --name "$firefox_node" --link $selenium_hub:hub  selenium/vnc-node-firefox-debug

	echo ""
	echo "*** Building is Done ***"
	echo ""

	sudo docker ps
}


if [[ "$1" == "build" ]]; then
	build
elif [[ "$1" == "clean" ]]; then
	clean
fi

