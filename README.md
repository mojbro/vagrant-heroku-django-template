# vagrant-heroku-django-template

A template for setting up a Django 1.6 project with a Vagrant development
machine and support for Heroku.

It is primarily intended for myself for future projects, but feel free
to use it, modify it and what not.

## How to use

If you want to create a Django project named `myproject` with a Vagrant
development environment, just do the following (you'll need `curl` and
[Vagrant](http://www.vagrantup.com/)):

    host$ curl -Ok https://raw.github.com/mojbro/vagrant-heroku-django-template/master/vagrant/create-project.sh
    host$ bash ./create-project.sh myproject
    host$ cd myproject
    <some output>
    host$ vagrant up
    <lots of output, will take a while>

If everything worked, you should at this point have a working Vagrant environment with
a blank Django project called `myproject`.

### SSH in to the development environment

In the project

    host$ vagrant ssh

### Start the Django development server

Type:

    vagrant$ runserver

`runserver` is an alias for `cd myproject;python manage.py runserver 0.0.0.0:8080`
which you can do as well, of course.
