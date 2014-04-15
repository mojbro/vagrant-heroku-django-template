PROJECT_NAME=$(cat /home/vagrant/.project_name)
workon $PROJECT_NAME

alias runserver="cd ~/${PROJECT_NAME};python manage.py runserver 0.0.0.0:8080"
