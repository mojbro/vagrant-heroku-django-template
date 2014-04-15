#!/bin/bash

# Exit on error
set -e

if [ -z "$1" ] ; then
	echo "You need to specify a project name for your Django project."
	echo
	echo "Usage: $0 <project-name>"
	exit 1
fi

PROJECT_NAME="$1"

if [ -z "$2" ] ; then
	PROJECT_DIR="$PROJECT_NAME"
else
	PROJECT_DIR="$2"
fi

if [ ! -d "$PROJECT_NAME" ] ; then
	mkdir "$PROJECT_NAME"
fi
cd "$PROJECT_NAME"

REPO_NAME=vagrant-heroku-django-template
curl -Lks https://github.com/mojbro/$REPO_NAME/archive/master.zip > master.zip
unzip master.zip
rm master.zip
mv ${REPO_NAME}-master/* .
rm -r ${REPO_NAME}-master

# cp -r ../vagrant-heroku-django-template/* .

mv project_name "$PROJECT_NAME"
rm README.md

# Files to subsitute {{ project_name }} with $PROJECT_NAME in
FILES_SUBS="Procfile Vagrantfile manage.py $PROJECT_NAME/settings.py $PROJECT_NAME/urls.py $PROJECT_NAME/wsgi.py"
for f in $FILES_SUBS ; do
	echo "Processing $f"
	mv $f $f.template
	sed 's/{{ project_name }}/'$PROJECT_NAME'/g' $f.template > $f
	rm $f.template
done
