#!/bin/bash
#
if [[ "$#" = 0 ]]; then
echo -e "\nExample:\n./init.sh ubuntu:latest docker\n\nor:\n./init.sh ubuntu:latest docker sudo\n\nWhere:\nubuntu:latest - version linux, you can use ubuntu or debian any versions\ndocker - user which will be the entrance to the container, you can use any name you like\nsudo - if you want add \"docker\" user in sudo\n\n\nThis script create 2 files: Dockerfile and entrypoint.sh with gosu\nMore info: https://github.com/tianon/gosu\n"

else
mv ./Dockerfile ./bak_Dockerfile &> /dev/null
mv ./entrypoint.sh ./bak_entrypoint.sh &> /dev/null
#
#echo -e "FROM ubuntu:latest\nCOPY --from=gosu/assets /opt/gosu /opt/gosu\nCOPY entrypoint.sh /usr/local/bin/entrypoint.sh\n\nRUN set -x \\ \n    && /opt/gosu/gosu.install.sh \\ \n    && rm -fr /opt/gosu \\ \n    && apt-get update \\ \n    && apt-get install -y sudo curl ca-certificates \\ \n    && chmod +x /usr/local/bin/entrypoint.sh\n\nENTRYPOINT [\"/usr/local/bin/entrypoint.sh\"]" > ./Dockerfile
echo -e "FROM ubuntu:latest\nCOPY entrypoint.sh /usr/local/bin/entrypoint.sh\n\nRUN set -x \\ \n        && apt-get update \\ \n        && apt-get install -y gosu sudo \\ \n        && rm -rf /var/lib/apt/lists/* \\ \n        && gosu nobody true \\ \n        && chmod +x /usr/local/bin/entrypoint.sh\n\nENTRYPOINT [\"/usr/local/bin/entrypoint.sh\"]" > ./Dockerfile
if [[ -n "$1" ]]; then sed -i "s/ubuntu:latest/$1/g" ./Dockerfile; fi
#
echo -e '#!/bin/bash\nset -e\nCURRENT_UID=${uid:-9999}\nuseradd --shell /bin/bash -u $CURRENT_UID -o -c "" -m docker\nexport HOME=/home/docker' > ./entrypoint.sh
#
if [[ "$3" = "sudo" ]]; then echo -e '\nadduser docker sudo\necho "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers\ngosu docker bash' >> ./entrypoint.sh; else echo -e '\ngosu docker bash' >> ./entrypoint.sh; fi
if [[ -n "$2" ]]; then sed -i "s/docker/$2/g" ./entrypoint.sh; fi
#docker rmi app_cont
#docker build -t app_cont .
#docker run --rm -it -v $(pwd)/data:/home -e uid=$UID --name app_cont app_cont
echo -e "Execute:\n# docker build -t app_cont .\n\nand:\n# docker run --rm -it -e uid=$UID --name app_cont app_cont"
fi
