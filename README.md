# Шаблон для создания контейнера с gosu утилитой

Утилита gosu позволяет создать контейнер с пользователем которому прокидываются права пользователя, от которого запускается контейнер.  
Поэтому все созданные файлы в проброшенных на хост volume будут принадлежать пользователю запустившему контейнер, что решает проблему с запуском контейнера не от root и прав на созданные из контейнера файлы.  
Данная утилита рекомендована докером: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/  

Для использования шаблона необходимо:
```bash
$ git clone 
$ ./init.sh ubuntu:latest docker
or:
$ ./init.sh ubuntu:latest docker sudo
```
где:  
- ubuntu:latest - версия ОС, на основе которой будет создан образ. Можно сипользовать ubuntu или debian любых версий, например: debian:9  
- docker - наименование пользователя, который будет создан в контейнере, имя можно задать любое по вкусу  
- sudo - нужно ли добавлять пользователя в sudo, если пользователю привелегии не нужны, то оставить этот аргумент пустым  


Скрипт init.sh создаст 2 файла Dockerfile и entrypoint.sh, которые можно изменять по своему усмотрению.  
Примеры данных файлов: example.Dockerfile и example.entrypoint.sh  


Подробности по ссылкам:  
https://github.com/tianon/gosu  
https://denibertovic.com/posts/handling-permissions-with-docker-volumes/  
https://github.com/kaluzki/docker/blob/gosu  
