
docker pull selenium/hub

docker build -t selenium/vnc-node-chrome-debug ./node_chrome

docker run -p 5555:4444 -d --name 'selenium_hub'  selenium/hub

docker run -P -d --link selenium_hub:hub  selenium/vnc-node-chrome-debug

docker build -t selenium/vnc-node-firefox-debug ./node_firefox

docker run -P -d --link selenium_hub:hub  selenium/vnc-node-firefox-debug

